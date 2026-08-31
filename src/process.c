#include "process.h"
#include "uart.h"
#include "string.h"

process_t proc_table[MAX_PROCESSES];
int next_pid = 1;

void process_init(void) {
    for (int i = 0; i < MAX_PROCESSES; i++) {
        proc_table[i].pid = 0;
        proc_table[i].state = PROC_DEAD;
    }

    // Launch default OS daemons
    proc_table[0].pid = next_pid++;
    strcpy(proc_table[0].name, "kinit");
    proc_table[0].state = PROC_RUNNING;
    proc_table[0].memory_bytes = 1048576; // 1 MB
    proc_table[0].cpu_time_ms = 450;

    proc_table[1].pid = next_pid++;
    strcpy(proc_table[1].name, "klogd");
    proc_table[1].state = PROC_SLEEPING;
    proc_table[1].memory_bytes = 256000;
    proc_table[1].cpu_time_ms = 12;

    proc_table[2].pid = next_pid++;
    strcpy(proc_table[2].name, "ai_daemon");
    proc_table[2].state = PROC_SLEEPING;
    proc_table[2].memory_bytes = 4194304; // 4 MB
    proc_table[2].cpu_time_ms = 1200;

    proc_table[3].pid = next_pid++;
    strcpy(proc_table[3].name, "shell");
    proc_table[3].state = PROC_RUNNING;
    proc_table[3].memory_bytes = 512000;
    proc_table[3].cpu_time_ms = 85;
}

int process_kill(int pid) {
    if (pid <= 0) return -1;
    for (int i = 0; i < MAX_PROCESSES; i++) {
        if (proc_table[i].pid == pid && proc_table[i].state != PROC_DEAD) {
            if (pid == 1) {
                uart_puts("\033[1;31m[KERNEL PANIC] Attempted to kill init process!\033[0m\n");
                return -2; // Panic
            }
            proc_table[i].state = PROC_ZOMBIE;
            return 0;
        }
    }
    return -1; // Not found
}

static const char* state_to_str(proc_state_t s) {
    switch(s) {
        case PROC_RUNNING: return "\033[1;32mRUNNING \033[0m";
        case PROC_SLEEPING: return "\033[1;34mSLEEPING\033[0m";
        case PROC_ZOMBIE: return "\033[1;31mZOMBIE  \033[0m";
        default: return "DEAD    ";
    }
}

void launch_ktop(void) {
    uart_puts("\033[2J\033[H\033[?25l"); // Clear screen, hide cursor
    
    // Simulate updating top screen once
    uart_puts("\033[7m Kaviraj OS Task Monitor (ktop) - Press any key to exit \033[0m\n");
    
    uint32_t total_mem = 0;
    int proc_count = 0;
    for (int i = 0; i < MAX_PROCESSES; i++) {
        if (proc_table[i].state != PROC_DEAD && proc_table[i].state != PROC_ZOMBIE) {
            total_mem += proc_table[i].memory_bytes;
            proc_count++;
        }
    }
    
    uart_printf("Tasks: %d total, Memory: %d KB / 16384 KB (16 MB)\n", proc_count, total_mem / 1024);
    uart_puts("------------------------------------------------------------\n");
    uart_puts("\033[1;37mPID   STATE      MEM(KB)   CPU(ms)   COMMAND\033[0m\n");
    
    for (int i = 0; i < MAX_PROCESSES; i++) {
        if (proc_table[i].state != PROC_DEAD) {
            uart_printf("%d     %s %d        %d        %s\n", 
                proc_table[i].pid, 
                state_to_str(proc_table[i].state),
                proc_table[i].memory_bytes / 1024,
                proc_table[i].cpu_time_ms,
                proc_table[i].name);
        }
    }
    
    uart_puts("\n\033[36mMonitoring mode active... (Press 'q' or Enter to exit)\033[0m\n");
    
    // Wait for any key
    while (1) {
        char c = uart_getc();
        if (c == 'q' || c == '\n' || c == 24 || c == 3) {
            break;
        }
    }
    
    uart_puts("\033[0m\033[2J\033[H\033[?25h"); // Reset, clear, show cursor
}
