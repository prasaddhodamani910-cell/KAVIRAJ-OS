# Kaviraj OS - 64-bit ARM Operating System
**Created & Developed by Prasad Dhodamani**

A modular, 64-bit ARM (AArch64 / ARMv8-A) bare-metal operating system kernel featuring an in-memory Virtual File System (VFS) and interactive command shell.

---

## 🌟 Key Features

- **Developer & Creator**: Prasad Dhodamani
- **Virtual File System (VFS)**: In-memory hierarchical directory tree with file creation, reading, writing, and deletion
- **Dynamic Shell Prompt**: Real-time current working directory display (`KavirajOS:/docs# `)
- **PL011 Serial Console Driver**: MMIO-based hardware communication with freestanding custom `printf`
- **Freestanding C Library**: Self-contained string manipulation and memory routines
- **Global Termux Integration**: Run directly from any terminal window with `kaviraj` or `kaviraj-os`

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
| `android` | Display the smartphone hardware architecture roadmap |
| `memdump` | Dump raw machine instructions from the kernel entry point |

### 🛠️ Utilities
| Command | Description |
|---|---|
| `clear` / `cls` | Clear the terminal screen |
| `help` | Display the command reference manual |
| `exit` / `quit` / `halt` | Power down the operating system session |

---

## 🚀 Quick Start in Termux

Launch **Kaviraj OS** anytime from any directory:
```bash
kaviraj
```

To recompile and reinstall from source:
```bash
cd ~/my_os
make all
make install
```
