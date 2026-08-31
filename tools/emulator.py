#!/usr/bin/env python3
"""
AetherOS ARM64 Bare-Metal Runner & PL011 UART Emulator
Supports interactive terminal mode and piped batch testing.
"""

import sys
import os
import struct
import select

UART0_BASE = 0x09000000
UART0_DR   = 0x09000000
UART0_FR   = 0x09000018

RAM_BASE   = 0x40000000
RAM_SIZE   = 16 * 1024 * 1024  # 16 MB

class ARM64CPU:
    def __init__(self, ram_base=RAM_BASE, ram_size=RAM_SIZE):
        self.ram_base = ram_base
        self.ram_size = ram_size
        self.ram = bytearray(ram_size)
        self.regs = [0] * 32  # x0-x30
        self.sp = 0
        self.pc = ram_base
        self.flags = {'N': 0, 'Z': 0, 'C': 0, 'V': 0}
        self.input_queue = bytearray()
        self.running = True

    def load_elf(self, elf_path):
        with open(elf_path, 'rb') as f:
            data = f.read()

        if data[:4] != b'\x7fELF':
            raise ValueError("Not a valid ELF file")

        e_entry = struct.unpack_from('<Q', data, 0x18)[0]
        e_phoff = struct.unpack_from('<Q', data, 0x20)[0]
        e_phentsize = struct.unpack_from('<H', data, 0x36)[0]
        e_phnum = struct.unpack_from('<H', data, 0x38)[0]

        self.pc = e_entry

        for i in range(e_phnum):
            ph_offset = e_phoff + i * e_phentsize
            p_type, p_flags = struct.unpack_from('<II', data, ph_offset)
            p_offset, p_vaddr, p_paddr, p_filesz, p_memsz, p_align = struct.unpack_from('<QQQQQQ', data, ph_offset + 8)

            if p_type == 1: # PT_LOAD
                ram_offset = p_paddr - self.ram_base
                seg_bytes = data[p_offset : p_offset + p_filesz]
                self.ram[ram_offset : ram_offset + p_filesz] = seg_bytes
                if p_memsz > p_filesz:
                    bss_len = p_memsz - p_filesz
                    self.ram[ram_offset + p_filesz : ram_offset + p_memsz] = b'\x00' * bss_len

    def read_mem(self, addr, size):
        if UART0_BASE <= addr < UART0_BASE + 0x1000:
            return self.mmio_read(addr, size)
        
        offset = addr - self.ram_base
        if 0 <= offset <= self.ram_size - size:
            if size == 1:
                return self.ram[offset]
            elif size == 2:
                return struct.unpack_from('<H', self.ram, offset)[0]
            elif size == 4:
                return struct.unpack_from('<I', self.ram, offset)[0]
            elif size == 8:
                return struct.unpack_from('<Q', self.ram, offset)[0]
        return 0

    def write_mem(self, addr, val, size):
        if UART0_BASE <= addr < UART0_BASE + 0x1000:
            self.mmio_write(addr, val, size)
            return

        offset = addr - self.ram_base
        if 0 <= offset <= self.ram_size - size:
            if size == 1:
                self.ram[offset] = val & 0xFF
            elif size == 2:
                struct.pack_into('<H', self.ram, offset, val & 0xFFFF)
            elif size == 4:
                struct.pack_into('<I', self.ram, offset, val & 0xFFFFFFFF)
            elif size == 8:
                struct.pack_into('<Q', self.ram, offset, val & 0xFFFFFFFFFFFFFFFF)

    def mmio_read(self, addr, size):
        if addr == UART0_FR:
            self.check_stdin()
            rxfe = (1 << 4) if len(self.input_queue) == 0 else 0
            return rxfe
        elif addr == UART0_DR:
            self.check_stdin()
            if self.input_queue:
                return self.input_queue.pop(0)
            return 0
        return 0

    def mmio_write(self, addr, val, size):
        if addr == UART0_DR:
            char = chr(val & 0xFF)
            sys.stdout.write(char)
            sys.stdout.flush()

    def check_stdin(self):
        try:
            r, _, _ = select.select([sys.stdin], [], [], 0)
            if r:
                data = os.read(sys.stdin.fileno(), 64)
                if not data:
                    # End of file / stream
                    pass
                else:
                    self.input_queue.extend(data)
        except Exception:
            pass

    def get_reg(self, idx):
        if idx == 31:
            return 0
        return self.regs[idx] & 0xFFFFFFFFFFFFFFFF

    def set_reg(self, idx, val):
        if idx != 31:
            self.regs[idx] = val & 0xFFFFFFFFFFFFFFFF

    def get_sp(self):
        return self.sp & 0xFFFFFFFFFFFFFFFF

    def set_sp(self, val):
        self.sp = val & 0xFFFFFFFFFFFFFFFF

    def set_flags_sub(self, val1, val2, is_64):
        mask = 0xFFFFFFFFFFFFFFFF if is_64 else 0xFFFFFFFF
        v1 = val1 & mask
        v2 = val2 & mask
        res = (v1 - v2) & mask
        self.flags['Z'] = 1 if res == 0 else 0
        self.flags['N'] = 1 if ((res >> (63 if is_64 else 31)) & 1) else 0
        self.flags['C'] = 1 if v1 >= v2 else 0
        s1 = struct.unpack('<q' if is_64 else '<i', struct.pack('<Q' if is_64 else '<I', v1))[0]
        s2 = struct.unpack('<q' if is_64 else '<i', struct.pack('<Q' if is_64 else '<I', v2))[0]
        sres = s1 - s2
        min_val = -0x8000000000000000 if is_64 else -0x80000000
        max_val =  0x7FFFFFFFFFFFFFFF if is_64 else  0x7FFFFFFF
        self.flags['V'] = 1 if (sres < min_val or sres > max_val) else 0

    def set_flags_add(self, val1, val2, is_64):
        mask = 0xFFFFFFFFFFFFFFFF if is_64 else 0xFFFFFFFF
        v1 = val1 & mask
        v2 = val2 & mask
        res = (v1 + v2) & mask
        self.flags['Z'] = 1 if res == 0 else 0
        self.flags['N'] = 1 if ((res >> (63 if is_64 else 31)) & 1) else 0
        self.flags['C'] = 1 if ((v1 + v2) > mask) else 0
        s1 = struct.unpack('<q' if is_64 else '<i', struct.pack('<Q' if is_64 else '<I', v1))[0]
        s2 = struct.unpack('<q' if is_64 else '<i', struct.pack('<Q' if is_64 else '<I', v2))[0]
        sres = s1 + s2
        min_val = -0x8000000000000000 if is_64 else -0x80000000
        max_val =  0x7FFFFFFFFFFFFFFF if is_64 else  0x7FFFFFFF
        self.flags['V'] = 1 if (sres < min_val or sres > max_val) else 0

    def test_cond(self, cond):
        if cond == 0x0: return self.flags['Z'] == 1 # EQ
        if cond == 0x1: return self.flags['Z'] == 0 # NE
        if cond == 0x2: return self.flags['C'] == 1 # CS/HS
        if cond == 0x3: return self.flags['C'] == 0 # CC/LO
        if cond == 0x4: return self.flags['N'] == 1 # MI
        if cond == 0x5: return self.flags['N'] == 0 # PL
        if cond == 0x6: return self.flags['V'] == 1 # VS
        if cond == 0x7: return self.flags['V'] == 0 # VC
        if cond == 0x8: return self.flags['C'] == 1 and self.flags['Z'] == 0 # HI
        if cond == 0x9: return self.flags['C'] == 0 or self.flags['Z'] == 1  # LS
        if cond == 0xA: return self.flags['N'] == self.flags['V']            # GE
        if cond == 0xB: return self.flags['N'] != self.flags['V']            # LT
        if cond == 0xC: return self.flags['Z'] == 0 and (self.flags['N'] == self.flags['V']) # GT
        if cond == 0xD: return self.flags['Z'] == 1 or (self.flags['N'] != self.flags['V'])  # LE
        return True # AL

    def step(self):
        inst = self.read_mem(self.pc, 4)
        pc_cur = self.pc
        self.pc += 4

        # NOP
        if inst == 0xd503201f:
            return

        # WFI / WFE
        if inst in (0xd503207f, 0xd503205f):
            self.check_stdin()
            import time
            time.sleep(0.005)
            return

        # RET
        if (inst & 0xfffffc1f) == 0xd65f0000:
            rn = (inst >> 5) & 0x1F
            self.pc = self.regs[rn]
            return

        # B / BL imm26
        if (inst >> 26) in (0b000101, 0b100101):
            is_bl = (inst >> 31) & 1
            imm26 = inst & 0x3FFFFFF
            if imm26 & 0x2000000:
                imm26 -= 0x4000000
            target = pc_cur + imm26 * 4
            if is_bl:
                self.regs[30] = self.pc
            self.pc = target
            return

        # B.cond imm19
        if (inst >> 24) == 0x54 and (inst & 0x10) == 0:
            cond = inst & 0xF
            imm19 = (inst >> 5) & 0x7FFFF
            if imm19 & 0x40000:
                imm19 -= 0x80000
            if self.test_cond(cond):
                self.pc = pc_cur + imm19 * 4
            return

        # CBZ / CBNZ
        if (inst >> 24) in (0x34, 0x35, 0xB4, 0xB5):
            is_64 = (inst >> 31) & 1
            is_cbnz = (inst >> 24) & 1
            rt = inst & 0x1F
            imm19 = (inst >> 5) & 0x7FFFF
            if imm19 & 0x40000:
                imm19 -= 0x80000
            val = self.get_reg(rt) if is_64 else (self.get_reg(rt) & 0xFFFFFFFF)
            if (val == 0 and not is_cbnz) or (val != 0 and is_cbnz):
                self.pc = pc_cur + imm19 * 4
            return

        # TBZ / TBNZ
        if (inst >> 25) in (0b0110110, 0b0110111, 0b1110110, 0b1110111):
            b5 = (inst >> 31) & 1
            b40 = (inst >> 19) & 0x1F
            bit = (b5 << 5) | b40
            is_tbnz = (inst >> 24) & 1
            rt = inst & 0x1F
            imm14 = (inst >> 5) & 0x3FFF
            if imm14 & 0x2000:
                imm14 -= 0x4000
            val = (self.get_reg(rt) >> bit) & 1
            if (val != 0 and is_tbnz) or (val == 0 and not is_tbnz):
                self.pc = pc_cur + imm14 * 4
            return

        # ADR / ADRP
        if (inst >> 24) & 0x1F in (0x10, 0x90):
            is_adrp = (inst >> 31) & 1
            rd = inst & 0x1F
            immlo = (inst >> 29) & 0x3
            immhi = (inst >> 5) & 0x7FFFF
            imm = (immhi << 2) | immlo
            if imm & 0x100000:
                imm -= 0x200000
            if is_adrp:
                base = pc_cur & ~0xFFF
                self.set_reg(rd, base + (imm << 12))
            else:
                self.set_reg(rd, pc_cur + imm)
            return

        # LDR (literal)
        if (inst >> 24) in (0x18, 0x58):
            is_64 = (inst >> 30) & 1
            rt = inst & 0x1F
            imm19 = (inst >> 5) & 0x7FFFF
            if imm19 & 0x40000:
                imm19 -= 0x80000
            addr = pc_cur + imm19 * 4
            val = self.read_mem(addr, 8 if is_64 else 4)
            self.set_reg(rt, val)
            return

        # MRS
        if (inst >> 20) == 0xd53:
            rt = inst & 0x1F
            sys_reg = (inst >> 5) & 0x7FFF
            if sys_reg == 0x4211: self.set_reg(rt, 0x4)          # CurrentEL (EL1)
            elif sys_reg == 0x4005: self.set_reg(rt, 0x80000000) # MPIDR_EL1 (Core 0)
            elif sys_reg == 0x4000: self.set_reg(rt, 0x410FD034) # MIDR_EL1 (Cortex-A53)
            else: self.set_reg(rt, 0)
            return

        # MOVZ / MOVK
        if (inst >> 23) in (0x128, 0x129, 0x1a8, 0x1a9):
            is_64 = (inst >> 31) & 1
            opc = (inst >> 29) & 0x3
            hw = (inst >> 21) & 0x3
            imm16 = (inst >> 5) & 0xFFFF
            rd = inst & 0x1F
            shift = hw * 16
            if opc == 2: # MOVZ
                self.set_reg(rd, imm16 << shift)
            elif opc == 3: # MOVK
                cur = self.get_reg(rd)
                mask = ~(0xFFFF << shift) & (0xFFFFFFFFFFFFFFFF if is_64 else 0xFFFFFFFF)
                self.set_reg(rd, (cur & mask) | (imm16 << shift))
            return

        # ADD / SUB / CMP / CMN (immediate)
        if (inst >> 24) in (0x11, 0x31, 0x51, 0x71, 0x91, 0xB1, 0xD1, 0xF1):
            is_64 = (inst >> 31) & 1
            is_sub = (inst >> 30) & 1
            set_flags = (inst >> 29) & 1
            sh = (inst >> 22) & 1
            imm12 = (inst >> 10) & 0xFFF
            if sh: imm12 <<= 12
            rn = (inst >> 5) & 0x1F
            rd = inst & 0x1F
            val_rn = self.get_sp() if rn == 31 else self.get_reg(rn)
            if not is_64: val_rn &= 0xFFFFFFFF

            if set_flags:
                if is_sub: self.set_flags_sub(val_rn, imm12, is_64)
                else: self.set_flags_add(val_rn, imm12, is_64)
            
            res = (val_rn - imm12) if is_sub else (val_rn + imm12)
            if rd == 31 and not set_flags:
                self.set_sp(res)
            elif rd != 31:
                self.set_reg(rd, res)
            return

        # CSEL (Conditional Select)
        if (inst >> 21) == 0b10011010100 or (inst >> 21) == 0b00011010100:
            is_64 = (inst >> 31) & 1
            rm = (inst >> 16) & 0x1F
            cond = (inst >> 12) & 0xF
            rn = (inst >> 5) & 0x1F
            rd = inst & 0x1F
            val = self.get_reg(rn) if self.test_cond(cond) else self.get_reg(rm)
            self.set_reg(rd, val if is_64 else (val & 0xFFFFFFFF))
            return

        # Data-processing (2 source / Multiply): UMULH / MSUB / MADD
        if (inst >> 24) in (0x1B, 0x9B):
            is_64 = (inst >> 31) & 1
            op31 = (inst >> 21) & 7
            rm = (inst >> 16) & 0x1F
            ra = (inst >> 10) & 0x1F
            rn = (inst >> 5) & 0x1F
            rd = inst & 0x1F
            v_rn = self.get_reg(rn)
            v_rm = self.get_reg(rm)
            v_ra = self.get_reg(ra)
            if op31 == 0: # MADD (rd = ra + rn * rm)
                self.set_reg(rd, v_ra + v_rn * v_rm)
            elif op31 == 1: # MSUB (rd = ra - rn * rm)
                self.set_reg(rd, v_ra - v_rn * v_rm)
            elif op31 == 2: # UMULH
                self.set_reg(rd, (v_rn * v_rm) >> 64)
            return

        # Shifted Register: ADD / SUB / CMP
        if (inst >> 24) in (0x0B, 0x2B, 0x4B, 0x6B, 0x8B, 0xAB, 0xCB, 0xEB):
            is_64 = (inst >> 31) & 1
            is_sub = (inst >> 30) & 1
            set_flags = (inst >> 29) & 1
            shift_type = (inst >> 22) & 3
            rm = (inst >> 16) & 0x1F
            imm6 = (inst >> 10) & 0x3F
            rn = (inst >> 5) & 0x1F
            rd = inst & 0x1F
            v_rn = self.get_reg(rn)
            v_rm = self.get_reg(rm)
            if not is_64:
                v_rn &= 0xFFFFFFFF
                v_rm &= 0xFFFFFFFF
            if shift_type == 0: v_rm = (v_rm << imm6) & (0xFFFFFFFFFFFFFFFF if is_64 else 0xFFFFFFFF)
            elif shift_type == 1: v_rm = (v_rm >> imm6)

            if set_flags:
                if is_sub: self.set_flags_sub(v_rn, v_rm, is_64)
                else: self.set_flags_add(v_rn, v_rm, is_64)

            res = (v_rn - v_rm) if is_sub else (v_rn + v_rm)
            if rd != 31:
                self.set_reg(rd, res)
            return

        # Logical (AND, ORR, EOR, BIC, TST)
        if (inst >> 24) & 0x1F in (0x0A, 0x12):
            is_64 = (inst >> 31) & 1
            opc = (inst >> 29) & 0x3
            rn = (inst >> 5) & 0x1F
            rd = inst & 0x1F
            rm = (inst >> 16) & 0x1F
            v_rn = self.get_reg(rn)
            v_rm = self.get_reg(rm)
            if opc == 0: res = v_rn & v_rm
            elif opc == 1: res = v_rn | v_rm
            elif opc == 2: res = v_rn ^ v_rm
            else: # TST / ANDS
                res = v_rn & v_rm
                self.flags['Z'] = 1 if res == 0 else 0
                self.flags['N'] = 1 if ((res >> (63 if is_64 else 31)) & 1) else 0
                self.flags['C'] = 0
                self.flags['V'] = 0
            if rd != 31 and opc != 3:
                self.set_reg(rd, res)
            return

        # STP / LDP
        if (inst >> 25) in (0x54, 0x55, 0x56, 0x57, 0xA8 >> 1, 0xA9 >> 1, 0xAA >> 1, 0xAB >> 1):
            is_load = (inst >> 22) & 1
            is_64 = (inst >> 31) & 1
            mode = (inst >> 23) & 3
            imm7 = (inst >> 15) & 0x7F
            if imm7 & 0x40: imm7 -= 0x80
            scale = 8 if is_64 else 4
            offset = imm7 * scale
            rt2 = (inst >> 10) & 0x1F
            rn = (inst >> 5) & 0x1F
            rt = inst & 0x1F

            base = self.get_sp() if rn == 31 else self.get_reg(rn)
            eff_addr = base + (offset if mode == 3 else 0)

            if is_load:
                self.set_reg(rt, self.read_mem(eff_addr, scale))
                self.set_reg(rt2, self.read_mem(eff_addr + scale, scale))
            else:
                self.write_mem(eff_addr, self.get_reg(rt), scale)
                self.write_mem(eff_addr + scale, self.get_reg(rt2), scale)

            new_base = base + offset if mode in (1, 3) else base
            if rn == 31: self.set_sp(new_base)
            else: self.set_reg(rn, new_base)
            return

        # LDR / STR (byte, word, dword, signed, unsigned)
        if (inst >> 24) in (0x38, 0x39, 0x78, 0x79, 0xB8, 0xB9, 0xF8, 0xF9):
            size_code = (inst >> 30) & 0x3
            size = 1 << size_code
            is_load = ((inst >> 22) & 1) or ((inst >> 20) & 1)
            rn = (inst >> 5) & 0x1F
            rt = inst & 0x1F
            base = self.get_sp() if rn == 31 else self.get_reg(rn)
            imm12 = (inst >> 10) & 0xFFF
            addr = base + (imm12 * size)
            if is_load:
                val = self.read_mem(addr, size)
                self.set_reg(rt, val)
            else:
                self.write_mem(addr, self.get_reg(rt), size)
            return

def run_kernel(elf_file):
    cpu = ARM64CPU()
    cpu.load_elf(elf_file)

    is_tty = sys.stdin.isatty()
    old_settings = None
    if is_tty:
        import termios, tty
        old_settings = termios.tcgetattr(sys.stdin)
        tty.setraw(sys.stdin.fileno())

    try:
        while cpu.running:
            cpu.step()
    except KeyboardInterrupt:
        pass
    finally:
        if is_tty and old_settings:
            import termios
            termios.tcsetattr(sys.stdin, termios.TCSADRAIN, old_settings)
        print("\r\n[Simulator: Execution stopped]\r\n")

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Usage: python3 emulator.py <kernel.elf>")
        sys.exit(1)
    run_kernel(sys.argv[1])
