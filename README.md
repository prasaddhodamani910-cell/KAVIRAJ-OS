# 🚀 Kaviraj OS - AArch64 Bare-Metal Operating System
[![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)
[![Architecture: AArch64](https://img.shields.io/badge/Architecture-AArch64-blue.svg)](#)
[![Bare Metal](https://img.shields.io/badge/Platform-Bare--Metal-orange.svg)](#)

**Created & Developed by Prasad Dhodamani**

A modular, real 64-bit ARM (AArch64 / ARMv8-A) bare-metal operating system kernel featuring a custom exception vector table, MMIO-based PL011 UART serial driver, custom freestanding C standard library, and virtual memory scheduler.

---

## 🌟 Key Features

- **Developer & Creator**: Prasad Dhodamani
- **Freestanding Design**: Built from scratch without any host OS dependencies or standard libraries (`-ffreestanding -nostdlib`).
- **Exception handling**: Custom Exception Vector Table implementing Synchronous, IRQ, FIQ, and SError handlers for EL1 Kernel Mode.
- **Virtual File System (VFS)**: In-memory hierarchical directory tree supporting directory traversing, file creation, reading, writing, and deletion.
- **Serial Console Interface**: Interactive console shell communicating over physical PL011 UART using MMIO.

---

## 📂 Project Directory Structure

```
Kaviraj OS
├── boot.S          - Assembly entry point setting up stack pointer and kernel handoff
├── src/            - Kernel core implementation source files
│   ├── kernel.c    - Main kernel loop and shell dispatcher
│   ├── vfs.c       - Virtual File System logic
│   ├── uart.c      - PL011 UART driver
│   └── string.c    - Freestanding standard string implementation
├── include/        - Header files
│   ├── types.h     - Core type declarations
│   ├── vfs.h       - Filesystem interface
│   ├── uart.h      - Serial driver configurations
│   └── string.h    - String library prototypes
├── linker.ld       - Linker script defining memory regions (ROM/RAM)
├── Makefile        - Build automation script (supports bare-metal and simulation runs)
└── LICENSE         - CC-BY-4.0 Attribution License
```

---

## 💻 Available Shell Commands

### 📂 File System & Navigation
| Command | Example | Description |
|---|---|---|
| `ls` / `dir` | `ls` or `ls docs` | List files and directories with sizes |
| `cd` | `cd docs`, `cd ..`, `cd /` | Change working directory |
| `pwd` | `pwd` | Print current directory path |
| `cat` | `cat welcome.txt` | Read and display file contents |
| `mkdir` | `mkdir myfiles` | Create a new directory |
| `touch` | `touch note.txt` | Create an empty file |
| `write` | `write file.txt hello` | Write text into a file |
| `echo` | `echo Hello > file.txt` | Echo text or redirect output to a file |
| `rm` | `rm file.txt` | Delete a file or directory |

### ⚙️ System & Diagnostics
| Command | Description |
|---|---|
| `about` | Display author (**Prasad Dhodamani**), architecture, and version info |
| `sysinfo` | Display CPU registers, Exception Level (EL1 Kernel Mode), and memory layout |
| `uname` / `uname -a` | Print OS name, architecture, and author details |
| `whoami` | Display current logged-in user (`root`) |
| `memdump` | Dump raw machine instructions from the kernel entry point |

### 🛠️ Utilities
| Command | Description |
|---|---|
| `clear` / `cls` | Clear the terminal screen |
| `help` | Display the command reference manual |
| `exit` / `quit` / `halt` | Power down the operating system session |

---

## 🛠️ Build and Emulation Guide

### Prerequisites
To build and run Kaviraj OS on your host machine, install the cross-compilation toolchain and QEMU emulator:
```bash
# Ubuntu/Debian
sudo apt install gcc-aarch64-linux-gnu binutils-aarch64-linux-gnu qemu-system-arm -y
```

### Compile the Kernel
Compiling compiles the freestanding assembler (`boot.S`) and C files to output a raw binary image `kernel.elf` / `kernel.bin`:
```bash
make bare
```

### One-Click Emulation
To boot and test the kernel in the QEMU emulator:
```bash
make run-qemu
```
*(This maps the virtual PL011 UART to standard input/output console).*

### Clean Project Files
To keep the directory clean:
```bash
make clean
```

---

## 📄 License
This project is open-source and licensed under the **Creative Commons Attribution 4.0 International (CC BY 4.0)** license. You are free to share, modify, and distribute this codebase as long as you provide proper attribution to the creator, **Prasad Dhodamani**. See the `LICENSE` file for details.
