#include "types.h"
#include "uart.h"
#include "string.h"
#include "vfs.h"
#include "kedit.h"
#include "process.h"
#include "script.h"
#include "tui.h"
#include "kproj.h"
#include "exceptions.h"

#if defined(__STDC_HOSTED__) && __STDC_HOSTED__ == 1
#include <stdlib.h>
#endif

#define OS_NAME     "Kaviraj OS"
#define OS_VERSION  "v6.0.0 (Developer Edition)"
#define OS_CREATOR  "Prasad Dhodamani"

// Symbols defined in linker.ld (or simulated in host mode)
extern uint8_t __kernel_start[];
extern uint8_t __text_start[];
extern uint8_t __text_end[];
extern uint8_t __rodata_start[];
extern uint8_t __rodata_end[];
extern uint8_t __data_start[];
extern uint8_t __data_end[];
extern uint8_t __bss_start[];
extern uint8_t __bss_end[];
extern uint8_t __stack_top[];
extern uint8_t __kernel_end[];

static uint64_t get_current_el(void) {
#if defined(__STDC_HOSTED__) && __STDC_HOSTED__ == 1
    return 1;
#else
    uint64_t el;
    __asm__ volatile("mrs %0, CurrentEL" : "=r"(el));
    return (el >> 2) & 0x3;
#endif
}

static uint64_t get_midr(void) {
#if defined(__STDC_HOSTED__) && __STDC_HOSTED__ == 1
    return 0x410FD034;
#else
    uint64_t midr;
    __asm__ volatile("mrs %0, midr_el1" : "=r"(midr));
    return midr;
#endif
}

#if defined(__STDC_HOSTED__) && __STDC_HOSTED__ == 1
#include <unistd.h>
#define BOOT_DELAY(ms) usleep((ms) * 1000)
#else
#define BOOT_DELAY(ms) do { for(volatile int i=0; i<(ms)*15000; i++); } while(0)
#endif

void print_banner(void) {
    uart_puts("\033[2J\033[H"); // Clear screen
    // Print Slanted ASCII Logo
    uart_puts("\n");
    uart_puts("\033[1;36m       __ __ ___ _    __________  ___       __\033[0m\n");
    uart_puts("\033[1;36m      / //_//   | |  / /  _/ __ \\/   |     / /\033[0m\n");
    uart_puts("\033[1;34m     / ,<  / /| | | / // // /_/ / /| |__  / / \033[0m\n");
    uart_puts("\033[1;34m    / /| |/ ___ | |/ // // _, _/ ___ / /_/ /  \033[0m\n");
    uart_puts("\033[1;34m   /_/ |_/_/  |_|___/___/_/ |_/_/  |_\\____/   \033[0m\n\n");
    
    // System Info Box
    uart_puts("\033[1;30m    ╭──────────────────────────────────────────────╮\033[0m\n");
    uart_printf("\033[1;30m    │\033[0m  \033[1;37mSystem   :\033[0m \033[37mBare-Metal 64-bit ARM Kernel\033[0m   \033[1;30m│\033[0m\n");
    uart_printf("\033[1;30m    │\033[0m  \033[1;37mVersion  :\033[0m \033[36m%s\033[0m       \033[1;30m│\033[0m\n", OS_VERSION);
    uart_printf("\033[1;30m    │\033[0m  \033[1;37mCreator  :\033[0m \033[32m%s\033[0m           \033[1;30m│\033[0m\n", OS_CREATOR);
    uart_puts("\033[1;30m    ╰──────────────────────────────────────────────╯\033[0m\n\n");
}

void print_about(void) {
    uart_puts("\033[1;32m[+] About Kaviraj OS:\033[0m\n");
    uart_printf("    OS Name        : %s\n", OS_NAME);
    uart_printf("    Version        : %s\n", OS_VERSION);
    uart_printf("    Creator/Author : %s\n", OS_CREATOR);
    uart_puts("    Architecture   : 64-bit ARM (AArch64 / ARMv8-A)\n");
    uart_puts("    Target Systems : ARM64 Mobile Platforms & Virtual Machines\n");
    uart_puts("\n");
}

void print_sysinfo(void) {
    uint64_t el = get_current_el();
    uint64_t midr = get_midr();

    uart_puts("\033[1;32m[+] System Information:\033[0m\n");
    uart_printf("    Operating System: %s (%s)\n", OS_NAME, OS_VERSION);
    uart_printf("    Developer       : %s\n", OS_CREATOR);
    uart_printf("    Architecture    : ARM64 (AArch64 / ARMv8-A)\n");
    uart_printf("    Execution Level : EL%u (%s)\n", (uint32_t)el, (el == 1) ? "Kernel Mode" : (el == 2 ? "Hypervisor" : "User/Secure"));
    uart_printf("    CPU Implementer : 0x%x (MIDR: %p)\n", (uint32_t)((midr >> 24) & 0xFF), midr);
    uart_printf("    Kernel Base     : %p\n", (uint64_t)__kernel_start);
    uart_printf("    Kernel Code     : %p - %p (%u bytes)\n", (uint64_t)__text_start, (uint64_t)__text_end, (uint64_t)(__text_end - __text_start));
    uart_printf("    Read-Only Data  : %p - %p (%u bytes)\n", (uint64_t)__rodata_start, (uint64_t)__rodata_end, (uint64_t)(__rodata_end - __rodata_start));
    uart_printf("    Data & BSS      : %p - %p (%u bytes)\n", (uint64_t)__data_start, (uint64_t)__bss_end, (uint64_t)(__bss_end - __data_start));
    uart_printf("    Stack Pointer   : %p (Top)\n", (uint64_t)__stack_top);
    uart_puts("\n");
}

void print_android_roadmap(void) {
    uart_puts("\033[1;33m[Kaviraj OS - Android Architecture Roadmap]\033[0m\n");
    uart_puts("To run on smartphone hardware with Camera, Wi-Fi, BT & Hotspot:\n");
    uart_puts(" 1. Bootloader : Fastboot / ABOOT loads Kernel Image + Device Tree (.dtb)\n");
    uart_puts(" 2. Memory/MMU : Paging (TTBR0_EL1 / TTBR1_EL1) + Virtual Memory translation\n");
    uart_puts(" 3. Driver Bus : PCIe, I2C, SPI, MIPI-CSI (Camera) & SDIO/PCIe (Wi-Fi/BT)\n");
    uart_puts(" 4. Vendor HAL : Hardware Abstraction Layer (HAL / Treble) loads proprietary\n");
    uart_puts("                 firmware blobs required for Qualcomm/MediaTek chips.\n");
    uart_puts(" 5. Net Stack  : IP/TCP/UDP packet processing + hostapd (Wi-Fi Hotspot).\n\n");
}

void read_line(char *buffer, size_t max_len) {
    size_t idx = 0;
    while (1) {
        char c = uart_getc();
        if (c == '\r' || c == '\n') {
            uart_puts("\r\n");
            buffer[idx] = '\0';
            break;
        } else if (c == '\b' || c == 127) { // Backspace
            if (idx > 0) {
                idx--;
                uart_puts("\b \b");
            }
        } else if (c >= 32 && c <= 126) {
            if (idx < max_len - 1) {
                buffer[idx++] = c;
                uart_putc(c);
            }
        }
    }
}

static void parse_args(const char *cmd_line, char *cmd, char *arg) {
    size_t i = 0;
    while (cmd_line[i] == ' ') i++;

    size_t ci = 0;
    while (cmd_line[i] != ' ' && cmd_line[i] != '\0' && ci < 31) {
        cmd[ci++] = cmd_line[i++];
    }
    cmd[ci] = '\0';

    while (cmd_line[i] == ' ') i++;

    size_t ai = 0;
    while (cmd_line[i] != '\0' && ai < 127) {
        arg[ai++] = cmd_line[i++];
    }
    arg[ai] = '\0';
}

void print_help(void) {
    uart_puts("\033[1;37m========================= KAVIRAJ OS COMMANDS =========================\033[0m\n");
    uart_puts("\033[1;35m[Applications]\033[0m\n");
    uart_puts("  tui / desktop     - Launch Dual-Pane Text User Interface\n");
    uart_puts("  kedit <file>      - Launch Kedit Text Editor (MS-DOS style UI)\n\n");

    uart_puts("\033[1;33m[File System & Navigation]\033[0m\n");
    uart_puts("  ls / dir          - List files and directories in current folder\n");
    uart_puts("  cd <dir>          - Change current directory (e.g. cd docs, cd ..)\n");
    uart_puts("  pwd               - Print working directory path\n");
    uart_puts("  cat <file>        - View file contents (e.g. cat welcome.txt)\n");
    uart_puts("  mkdir <name>      - Create a new directory (e.g. mkdir myfiles)\n");
    uart_puts("  touch <name>      - Create an empty file (e.g. touch test.txt)\n");
    uart_puts("  write <f> <text>  - Write text to a file\n");
    uart_puts("  rm <name>         - Delete a file or directory\n");
    uart_puts("  sh / run <script> - Execute a .kav shell script file\n\n");

    uart_puts("\033[1;33m[System & Diagnostics]\033[0m\n");
    uart_puts("  ktop              - Task Monitor (view memory and processes)\n");
    uart_puts("  kill <pid>        - Terminate a running process\n");
    uart_puts("  about             - Display OS creator (Prasad Dhodamani) & build info\n");
    uart_puts("  sysinfo           - Display CPU registers, EL mode, and memory layout\n");
    uart_puts("  uname [-a]        - Print operating system name and architecture\n");
    uart_puts("  whoami            - Print current user identity\n");
    uart_puts("  android           - Show Android mobile hardware roadmap\n");
    uart_puts("  memdump           - Dump first 32 bytes of kernel code memory\n\n");
    uart_puts("\033[1;33m[Developer Tools]\033[0m\n");
    uart_puts("  kproj <name>      - Scaffold a production Python project workspace\n");
    uart_puts("  fetch             - Display system info (neofetch-style)\n\n");

    uart_puts("\033[1;33m[Utilities & Control]\033[0m\n");
    uart_puts("  echo <message>    - Print text to screen, or 'echo text > file.txt'\n");
    uart_puts("  clear / cls       - Clear terminal screen\n");
    uart_puts("  version           - Show OS version and update changelog\n");
    uart_puts("  help              - Display this command manual\n");
    uart_puts("  exit / quit / halt- Power down kernel session\n");
    uart_puts("\033[1;37m=======================================================================\033[0m\n\n");
}

void execute_command(char *cmd_buffer) {
    char cmd[32];
    char arg[128];
    char cwd_buf[64];

    parse_args(cmd_buffer, cmd, arg);

    if (strcmp(cmd, "help") == 0) {
        print_help();
    } else if (strcmp(cmd, "about") == 0) {
        print_about();
    } else if (strcmp(cmd, "version") == 0) {
        uart_puts("\033[1;36m    ╭──────────────────────────────────────────────╮\033[0m\n");
        uart_printf("\033[1;36m    │\033[0m  \033[1;37mKaviraj OS\033[0m \033[36m%s\033[0m      \033[1;36m│\033[0m\n", OS_VERSION);
        uart_printf("\033[1;36m    │\033[0m  \033[33mDeveloper : \033[32m%s\033[0m           \033[1;36m│\033[0m\n", OS_CREATOR);
        uart_puts("\033[1;36m    ╰──────────────────────────────────────────────╯\033[0m\n");
        // Changelog print removed to stay completely freestanding (no host Python calls)
    } else if (strcmp(cmd, "sysinfo") == 0) {
        print_sysinfo();
    } else if (strcmp(cmd, "rm") == 0) {
        if (strlen(arg) > 0) {
            if (vfs_remove(arg) == 0) uart_puts("Removed.\n");
            else uart_puts("File not found or error.\n");
        } else {
            uart_puts("Usage: rm <filename>\n");
        }
    } else if (strcmp(cmd, "kedit") == 0) {
        if (strlen(arg) > 0) {
            launch_kedit(arg);
        } else {
            uart_puts("Usage: kedit <filename>\n");
        }
    } else if (strcmp(cmd, "kproj") == 0) {
        kproj_execute(arg);
    } else if (strcmp(cmd, "tui") == 0 || strcmp(cmd, "desktop") == 0) {
        tui_launch();
    } else if (strcmp(cmd, "ktop") == 0) {
        launch_ktop();
    } else if (strcmp(cmd, "kill") == 0) {
        if (strlen(arg) > 0) {
            int pid = 0;
            // Basic string to int
            for (int i = 0; arg[i] >= '0' && arg[i] <= '9'; i++) {
                pid = pid * 10 + (arg[i] - '0');
            }
            int res = process_kill(pid);
            if (res == 0) {
                uart_printf("Process %d killed.\n", pid);
            } else if (res == -1) {
                uart_printf("Process %d not found or already dead.\n", pid);
            }
        } else {
            uart_puts("Usage: kill <pid>\n");
        }
    } else if (strcmp(cmd, "echo") == 0) {
        char *redir = strstr(cmd_buffer, ">");
        if (redir) {
            *redir = '\0';
            char *file = redir + 1;
            while (*file == ' ') file++;
            
            char *content = cmd_buffer + 5; // skip "echo "
            vfs_write_file(file, content);
        } else {
            uart_printf("%s\n", arg);
        }
    } else if (strcmp(cmd, "uname") == 0) {
        if (strcmp(arg, "-a") == 0) {
            uart_printf("%s %s aarch64 %s (Built for ARM64 Bare-Metal)\n", OS_NAME, OS_VERSION, OS_CREATOR);
        } else {
            uart_printf("%s\n", OS_NAME);
        }
    } else if (strcmp(cmd, "whoami") == 0) {
        uart_puts("root (Superuser / System Administrator)\n");
    } else if (strcmp(cmd, "pwd") == 0) {
        vfs_getcwd(cwd_buf, sizeof(cwd_buf));
        uart_printf("%s\n", cwd_buf);
    } else if (strcmp(cmd, "ls") == 0 || strcmp(cmd, "dir") == 0) {
        vfs_node_t *target_dir = vfs_get_cwd();
        if (strlen(arg) > 0) {
            vfs_node_t *node = vfs_find(arg);
            if (!node) {
                uart_printf("\033[31mls: cannot access '%s': No such file or directory\033[0m\n", arg);
                return;
            }
            if (node->type == FS_FILE) {
                uart_printf("\033[0m<FILE> %u B\t%s\033[0m\n", (uint32_t)node->size, node->name);
                return;
            }
            target_dir = node;
        }
        vfs_list_dir(target_dir);
    } else if (strcmp(cmd, "cd") == 0) {
        if (vfs_chdir(arg) != 0) {
            uart_printf("\033[31mcd: %s: No such directory\033[0m\n", arg);
        }
    } else if (strcmp(cmd, "cat") == 0) {
        if (strlen(arg) > 0) {
            vfs_node_t *f = vfs_find(arg);
            if (f && f->type == FS_FILE) {
                uart_printf("%s\n", f->data);
            } else {
                uart_puts("cat: file not found\n");
            }
        } else {
            uart_puts("Usage: cat <filename>\n");
        }
    } else if (strcmp(cmd, "mkdir") == 0) {
        if (strlen(arg) > 0) {
            if (vfs_mkdir(arg) != 0) uart_puts("mkdir failed.\n");
        } else {
            uart_puts("Usage: mkdir <name>\n");
        }
    } else if (strcmp(cmd, "touch") == 0) {
        if (strlen(arg) > 0) {
            if (vfs_touch(arg, NULL) != 0) uart_puts("touch failed.\n");
        } else {
            uart_puts("Usage: touch <name>\n");
        }
    } else if (strcmp(cmd, "write") == 0) {
        char *space = strchr(arg, ' ');
        if (space) {
            *space = '\0';
            char *text = space + 1;
            if (vfs_write_file(arg, text) != 0) uart_puts("write failed.\n");
        } else {
            uart_puts("Usage: write <filename> <text...>\n");
        }
    } else if (strcmp(cmd, "fetch") == 0) {
        uart_puts("\n");
        uart_puts("\033[1;36m  /\\  \033[0m OS: Kaviraj OS v6.0.0 (Developer Edition)\n");
        uart_puts("\033[1;36m /  \\ \033[0m Host: ARM64 Bare-metal\n");
        uart_puts("\033[1;36m/____\\\033[0m Kernel: Custom Monolithic (AArch64)\n");
        uart_printf("\033[1;36m \\  / \033[0m Creator: %s\n", OS_CREATOR);
        uart_puts("\033[1;36m  \\/  \033[0m Shell: Kaviraj Shell (ksh)\n");
        uart_puts("       AI: Kaviraj Cloud AI (Gemini 3.6)\n");
        uart_puts("       Python: Native kpy Engine\n");
        uart_puts("       Packages: kpkg Registry\n\n");
    } else if (strcmp(cmd, "clear") == 0 || strcmp(cmd, "cls") == 0) {
        uart_puts("\033[2J\033[H");
    } else if (strcmp(cmd, "sh") == 0 || strcmp(cmd, "run") == 0) {
        if (strlen(arg) > 0) {
            script_run_file(arg);
        } else {
            uart_puts("Usage: sh <script.kav>\n");
        }
    } else if (strcmp(cmd, "memdump") == 0) {
        uart_puts("Dumping kernel entry point memory:\n");
        uint8_t *ptr = (uint8_t *)__kernel_start;
        for (int i = 0; i < 32; i++) {
            if (i > 0 && i % 8 == 0) uart_puts(" ");
            if (i > 0 && i % 16 == 0) uart_puts("\n");
            uint8_t b = ptr[i];
            const char hex_chars[] = "0123456789ABCDEF";
            uart_putc(hex_chars[(b >> 4) & 0xF]);
            uart_putc(hex_chars[b & 0xF]);
            uart_putc(' ');
        }
        uart_puts("\n");
    } else if (strcmp(cmd, "android") == 0) {
        print_android_roadmap();
    } else if (strcmp(cmd, "exit") == 0 || strcmp(cmd, "quit") == 0 || strcmp(cmd, "halt") == 0) {
        uart_puts("Halting Kaviraj OS kernel. Goodbye!\n");
        uart_puts("[*] Kaviraj OS kernel shutting down.\n");
#if defined(__STDC_HOSTED__) && __STDC_HOSTED__ == 1
        exit(0);
#else
        while (1) {
            __asm__ volatile("wfi");
        }
#endif
    } else {
        uart_printf("\033[31m%s: command not found\033[0m\n", cmd);
    }
}

void kernel_shell(void) {
    char cmd_buffer[160];
    char cwd_buf[64];

    uart_puts("\033[1;35mType 'help' for command list or 'ls' to browse files.\033[0m\n\n");

    while (1) {
        vfs_getcwd(cwd_buf, sizeof(cwd_buf));
        uart_printf("\033[1;30m╭─\033[1;34m[\033[1;36mroot\033[1;30m@\033[1;32mKavirajOS\033[1;34m]\033[1;30m──\033[1;34m[\033[1;35m%s\033[1;34m]\033[0m\n", cwd_buf);
        uart_puts("\033[1;30m╰─\033[1;36m❯\033[0m ");
        read_line(cmd_buffer, sizeof(cmd_buffer));

        if (strlen(cmd_buffer) == 0) {
            continue;
        }
        
        // This processes variables, assignments, if/then, and normal commands!
        script_execute_line(cmd_buffer);

        // Check exit condition since script_execute_line doesn't break the loop natively
        if (strcmp(cmd_buffer, "exit") == 0 || strcmp(cmd_buffer, "quit") == 0 || strcmp(cmd_buffer, "halt") == 0) {
            break;
        }
    }
}

void kmain(void) {
    uart_init();
    uart_puts("\033[2J\033[H");
    
    // Boot sequence animation
    uart_puts("\033[1;30m[    0.000000] \033[0mBooting Kaviraj OS Kernel...\n"); BOOT_DELAY(100);
    uart_puts("\033[1;30m[    0.005120] \033[0mInitializing UART Controller... \033[1;32m[ OK ]\033[0m\n"); BOOT_DELAY(150);
    vfs_init();
    uart_puts("\033[1;30m[    0.041050] \033[0mMounting Virtual Filesystem...  \033[1;32m[ OK ]\033[0m\n"); BOOT_DELAY(200);
    
    // Initialize exception vectors (Stage 1)
#if !defined(__STDC_HOSTED__) || __STDC_HOSTED__ == 0
    init_exceptions();
    uart_puts("\033[1;30m[    0.050000] \033[0mLoading Exception Vectors...    \033[1;32m[ OK ]\033[0m\n"); BOOT_DELAY(150);
#endif

    process_init();
    script_init();
    uart_puts("\033[1;30m[    0.062120] \033[0mInitializing Task Scheduler...  \033[1;32m[ OK ]\033[0m\n"); BOOT_DELAY(150);
    BOOT_DELAY(400);

#if !defined(__STDC_HOSTED__) || __STDC_HOSTED__ == 0
    // Stage 1 Verification test: trigger synchronous exception
    uart_puts("[Stage 1 Test] Triggering deliberate undefined instruction exception...\n");
    trigger_undefined_instruction();
    uart_puts("[Stage 1 Test] Resumed execution successfully after exception handler!\n\n");
#endif

    print_banner();
    
    uart_printf("\033[1;32m[+] %s booted successfully!\033[0m\n\n", OS_NAME);
    print_sysinfo();
    kernel_shell();

    uart_puts("[*] Kaviraj OS kernel shutting down.\n");
}
