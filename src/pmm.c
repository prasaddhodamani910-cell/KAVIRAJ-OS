#include <pmm.h>
#include <uart.h>
#include <string.h>

extern uint8_t __kernel_end[];

// QEMU virt machine defaults to 128MB RAM starting at 0x40000000
#define RAM_BASE 0x40000000ULL
#define RAM_SIZE (128 * 1024 * 1024)
#define TOTAL_PAGES (RAM_SIZE / PAGE_SIZE)
#define BITMAP_SIZE (TOTAL_PAGES / 8)

static uint8_t memory_bitmap[BITMAP_SIZE];
static uint32_t free_pages = TOTAL_PAGES;
static uint32_t first_free_page_hint = 0;

static void bitmap_set(uint32_t bit) {
    memory_bitmap[bit / 8] |= (1 << (bit % 8));
}

static void bitmap_clear(uint32_t bit) {
    memory_bitmap[bit / 8] &= ~(1 << (bit % 8));
}

static int bitmap_test(uint32_t bit) {
    return (memory_bitmap[bit / 8] & (1 << (bit % 8))) != 0;
}

void pmm_init(void) {
    memset(memory_bitmap, 0, BITMAP_SIZE);

    uint64_t kernel_end_addr = (uint64_t)__kernel_end;
    
    if (kernel_end_addr % PAGE_SIZE != 0) {
        kernel_end_addr = (kernel_end_addr + PAGE_SIZE) & ~(PAGE_SIZE - 1);
    }

    uint32_t kernel_pages = (kernel_end_addr - RAM_BASE) / PAGE_SIZE;

    for (uint32_t i = 0; i < kernel_pages; i++) {
        bitmap_set(i);
    }

    free_pages = TOTAL_PAGES - kernel_pages;
    first_free_page_hint = kernel_pages;

    uart_printf("[+] Physical Memory Manager initialized.\n");
    uart_printf("    Total RAM : %d MB\n", RAM_SIZE / (1024 * 1024));
    uart_printf("    Kernel    : %d Pages\n", kernel_pages);
    uart_printf("    Free      : %d MB\n", (free_pages * PAGE_SIZE) / (1024 * 1024));
}

void *pmm_alloc_page(void) {
    if (free_pages == 0) {
        uart_puts("[-] PMM: Out of memory!\n");
        return NULL;
    }

    for (uint32_t i = first_free_page_hint; i < TOTAL_PAGES; i++) {
        if (!bitmap_test(i)) {
            bitmap_set(i);
            free_pages--;
            first_free_page_hint = i + 1;
            
            void *page_addr = (void *)(RAM_BASE + (i * PAGE_SIZE));
            memset(page_addr, 0, PAGE_SIZE);
            return page_addr;
        }
    }

    uart_puts("[-] PMM: Memory fragmentation error!\n");
    return NULL;
}

void pmm_free_page(void *ptr) {
    uint64_t addr = (uint64_t)ptr;
    
    if (addr < RAM_BASE || addr >= (RAM_BASE + RAM_SIZE)) {
        uart_puts("[-] PMM: Invalid free address (out of bounds)\n");
        return;
    }

    if (addr % PAGE_SIZE != 0) {
        uart_puts("[-] PMM: Invalid free address (not page aligned)\n");
        return;
    }

    uint32_t page_idx = (addr - RAM_BASE) / PAGE_SIZE;

    if (!bitmap_test(page_idx)) {
        uart_puts("[-] PMM: Double free detected!\n");
        return;
    }

    bitmap_clear(page_idx);
    free_pages++;

    if (page_idx < first_free_page_hint) {
        first_free_page_hint = page_idx;
    }
}

uint32_t pmm_get_free_memory(void) {
    return free_pages * PAGE_SIZE;
}
