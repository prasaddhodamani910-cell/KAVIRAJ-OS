#include <sched.h>
#include <pmm.h>
#include <uart.h>
#include <string.h>

#define MAX_TASKS 16

enum task_state {
    TASK_FREE,
    TASK_READY,
    TASK_RUNNING,
    TASK_SLEEPING
};

struct task {
    struct exception_context *ctx;
    void *stack_base;
    enum task_state state;
    int id;
};

static struct task tasks[MAX_TASKS];
static int current_task = -1;

void sched_init(void) {
    for (int i = 0; i < MAX_TASKS; i++) {
        tasks[i].state = TASK_FREE;
        tasks[i].id = i;
    }

    tasks[0].state = TASK_RUNNING;
    tasks[0].stack_base = NULL; 
    current_task = 0;
    
    uart_puts("[+] Preemptive Task Scheduler initialized.\n");
}

void sched_create_task(void (*entry)(void)) {
    int task_id = -1;
    for (int i = 1; i < MAX_TASKS; i++) {
        if (tasks[i].state == TASK_FREE) {
            task_id = i;
            break;
        }
    }

    if (task_id == -1) {
        uart_puts("[-] Scheduler: Max tasks reached!\n");
        return;
    }

    void *stack = pmm_alloc_page();
    if (!stack) {
        uart_puts("[-] Scheduler: Failed to allocate stack for new task!\n");
        return;
    }

    tasks[task_id].stack_base = stack;
    
    uint64_t stack_top = (uint64_t)stack + 4096;
    struct exception_context *ctx = (struct exception_context *)(stack_top - sizeof(struct exception_context));

    memset(ctx, 0, sizeof(struct exception_context));
    ctx->elr_el1 = (uint64_t)entry;
    ctx->spsr_el1 = 0x00000005; // EL1h, Interrupts enabled
    
    tasks[task_id].ctx = ctx;
    tasks[task_id].state = TASK_READY;

    uart_printf("[+] Task %d created successfully. Entry: 0x%x\n", task_id, (uint32_t)ctx->elr_el1);
}

struct exception_context *sched_switch(struct exception_context *ctx) {
    if (current_task == -1) return ctx;

    tasks[current_task].ctx = ctx;
    
    if (tasks[current_task].state == TASK_RUNNING) {
        tasks[current_task].state = TASK_READY;
    }

    int next_task = current_task;
    int attempts = 0;
    while (attempts < MAX_TASKS) {
        next_task = (next_task + 1) % MAX_TASKS;
        if (tasks[next_task].state == TASK_READY) {
            break;
        }
        attempts++;
    }

    if (tasks[next_task].state == TASK_READY) {
        current_task = next_task;
        tasks[current_task].state = TASK_RUNNING;
    }

    return tasks[current_task].ctx;
}
