CC = clang
LD = ld.lld
OBJCOPY = llvm-objcopy
OBJDUMP = llvm-objdump

TARGET_TRIPLE = aarch64-none-elf
CFLAGS_BARE = --target=$(TARGET_TRIPLE) -Wall -Wextra -O2 -ffreestanding -nostdlib -fno-builtin -mgeneral-regs-only -Iinclude
ASFLAGS_BARE = --target=$(TARGET_TRIPLE) -c

CFLAGS_HOST = -Wall -Wextra -O2 -Iinclude

PREFIX ?= /data/data/com.termux/files/usr
BIN_DIR = $(PREFIX)/bin

BUILD_DIR = build
SRC_DIR = src

SRCS_C = $(wildcard $(SRC_DIR)/*.c)
SRCS_S = $(wildcard $(SRC_DIR)/*.S)
OBJS_BARE = $(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/bare_%.o, $(SRCS_C)) \
            $(patsubst $(SRC_DIR)/%.S, $(BUILD_DIR)/bare_%.o, $(SRCS_S))

KERNEL_ELF = kernel.elf
KERNEL_BIN = kernel.bin
KERNEL_DISASM = kernel.asm
NATIVE_BIN = $(BUILD_DIR)/kaviraj_os

all: bare native

bare: $(KERNEL_BIN) $(KERNEL_DISASM)

native: $(NATIVE_BIN)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/bare_%.o: $(SRC_DIR)/%.c | $(BUILD_DIR)
	$(CC) $(CFLAGS_BARE) -c $< -o $@

$(BUILD_DIR)/bare_%.o: $(SRC_DIR)/%.S | $(BUILD_DIR)
	$(CC) $(ASFLAGS_BARE) $< -o $@

$(KERNEL_ELF): $(OBJS_BARE) linker.ld
	$(LD) -T linker.ld -nostdlib $(OBJS_BARE) -o $@

$(KERNEL_BIN): $(KERNEL_ELF)
	$(OBJCOPY) -O binary $< $@

$(KERNEL_DISASM): $(KERNEL_ELF)
	$(OBJDUMP) -d -S $< > $@
	@echo "Bare-metal build ready: $(KERNEL_ELF), $(KERNEL_BIN)"

$(NATIVE_BIN): $(SRCS_C) tools/native_runner.c | $(BUILD_DIR)
	$(CC) $(CFLAGS_HOST) $(SRCS_C) tools/native_runner.c -o $@
	@echo "Native Kaviraj OS ready: $(NATIVE_BIN)"

run: $(NATIVE_BIN)
	@echo "Starting Kaviraj OS interactive kernel session..."
	@$(NATIVE_BIN)

install: $(NATIVE_BIN)
	mkdir -p $(BIN_DIR)
	install -m 755 $(NATIVE_BIN) $(BIN_DIR)/kaviraj-os
	ln -sf $(BIN_DIR)/kaviraj-os $(BIN_DIR)/kaviraj
	@echo "==============================================================="
	@echo " [SUCCESS] Kaviraj OS installed into Termux system path!"
	@echo " You can now boot your OS anytime by typing:"
	@echo "     kaviraj-os"
	@echo "   or"
	@echo "     kaviraj"
	@echo "==============================================================="

clean:
	rm -rf $(BUILD_DIR) $(KERNEL_ELF) $(KERNEL_BIN) $(KERNEL_DISASM)

run-qemu: bare
	qemu-system-aarch64 -M virt -cpu cortex-a72 -kernel kernel.elf -nographic

.PHONY: all bare native run run-qemu install clean
