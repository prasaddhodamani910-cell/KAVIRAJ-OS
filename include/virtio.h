#ifndef KAVIRAJ_VIRTIO_H
#define KAVIRAJ_VIRTIO_H

#include <types.h>

int virtio_blk_init(void);
int virtio_blk_read_sector(uint64_t sector, void *buffer);
int virtio_blk_write_sector(uint64_t sector, const void *buffer);

#endif
