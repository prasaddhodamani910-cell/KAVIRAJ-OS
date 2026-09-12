#ifndef NET_H
#define NET_H

#include "types.h"

// MAC Address length
#define MAC_LEN 6
#define MTU     1500

struct virtio_net_hdr {
    uint8_t flags;
    uint8_t gso_type;
    uint16_t hdr_len;
    uint16_t gso_size;
    uint16_t csum_start;
    uint16_t csum_offset;
    // uint16_t num_buffers; // Only if VIRTIO_NET_F_MRG_RXBUF is negotiated
} __attribute__((packed));

void virtio_net_init(void);
void virtio_net_poll(void);
void virtio_net_send(const void *packet, size_t len);
void virtio_net_get_mac(uint8_t *mac);

#endif
