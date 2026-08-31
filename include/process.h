#ifndef PROCESS_H
#define PROCESS_H

#include <stdint.h>
#include <stddef.h>

#define MAX_PROCESSES 16

typedef enum {
    PROC_RUNNING,
    PROC_SLEEPING,
    PROC_ZOMBIE,
    PROC_DEAD
} proc_state_t;

typedef struct {
    int pid;
    char name[32];
    proc_state_t state;
    uint32_t memory_bytes;
    uint32_t cpu_time_ms;
} process_t;

void process_init(void);
int process_kill(int pid);
void launch_ktop(void);

#endif // PROCESS_H
