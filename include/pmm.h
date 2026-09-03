#ifndef KAVIRAJ_PMM_H
#define KAVIRAJ_PMM_H

#include <types.h>

#define PAGE_SIZE 4096

void pmm_init(void);
void *pmm_alloc_page(void);
void pmm_free_page(void *ptr);
uint32_t pmm_get_free_memory(void);

#endif
