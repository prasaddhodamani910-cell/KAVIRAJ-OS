#ifndef KAVIRAJ_VIRTIO_H
#define KAVIRAJ_VIRTIO_H

#include <types.h>

#define VIRTQ_DESC_F_NEXT  1
#define VIRTQ_DESC_F_WRITE 2

struct virtq_desc {
    uint64_t addr;
    uint32_t len;
    uint16_t flags;
    uint16_t next;
} __attribute__((packed));

struct virtq_avail {
    uint16_t flags;
    uint16_t idx;
    uint16_t ring[16];
    uint16_t used_event;
} __attribute__((packed));

struct virtq_used_elem {
    uint32_t id;
    uint32_t len;
} __attribute__((packed));

struct virtq_used {
    volatile uint16_t flags;
    volatile uint16_t idx;
    struct virtq_used_elem ring[16];
    volatile uint16_t avail_event;
} __attribute__((packed));

int virtio_blk_init(void);
int virtio_blk_read_sector(uint64_t sector, void *buffer);
int virtio_blk_write_sector(uint64_t sector, const void *buffer);

#endif
