#include "net.h"
#include "virtio.h"
#include "mmio.h"
#include "uart.h"
#include "pmm.h"
#include "string.h"

#define VIRTIO_MMIO_BASE  0x0a000000ULL
#define VIRTIO_MMIO_SIZE  0x200
#define VIRTIO_MMIO_COUNT 32

// MMIO Registers
#define VIRTIO_REG_MAGICValue    0x000
#define VIRTIO_REG_VERSION       0x004
#define VIRTIO_REG_DEVICEID      0x008
#define VIRTIO_REG_VENDORID      0x00c
#define VIRTIO_REG_DEVICE_FEAT   0x010
#define VIRTIO_REG_DRIVER_FEAT   0x020
#define VIRTIO_REG_QUEUE_SEL     0x030
#define VIRTIO_REG_QUEUE_NUM_MAX 0x034
#define VIRTIO_REG_QUEUE_NUM     0x038
#define VIRTIO_REG_QUEUE_ALIGN   0x03c
#define VIRTIO_REG_QUEUE_PFN     0x040
#define VIRTIO_REG_GUEST_PAGE_SIZE 0x028
#define VIRTIO_REG_QUEUE_NOTIFY  0x050
#define VIRTIO_REG_STATUS        0x070
#define VIRTIO_REG_CONFIG        0x100

// Status flags
#define VIRTIO_STATUS_ACKNOWLEDGE 1
#define VIRTIO_STATUS_DRIVER      2
#define VIRTIO_STATUS_DRIVER_OK   4

static uint64_t net_base = 0;
static uint8_t mac_addr[MAC_LEN];

static struct virtq_desc *rx_desc;
static struct virtq_avail_net *rx_avail;
static struct virtq_used_net *rx_used;

static struct virtq_desc *tx_desc;
static struct virtq_avail_net *tx_avail;
static struct virtq_used_net *tx_used;

static uint16_t rx_avail_idx = 0;
static uint16_t tx_avail_idx = 0;

#define KNET_QUEUE_SIZE 1024
#define RX_BUFFER_SIZE 2048
static uint8_t rx_buffers[KNET_QUEUE_SIZE][RX_BUFFER_SIZE];
static uint8_t tx_buffers[KNET_QUEUE_SIZE][RX_BUFFER_SIZE];

static uint8_t net_queue_mem[2][32768] __attribute__((aligned(4096)));
static uint32_t net_qmax = 0;

struct virtq_avail_net {
    uint16_t flags;
    uint16_t idx;
    uint16_t ring[1024];
    uint16_t used_event;
} __attribute__((packed));

struct virtq_used_net {
    volatile uint16_t flags;
    volatile uint16_t idx;
    struct virtq_used_elem ring[1024];
    volatile uint16_t avail_event;
} __attribute__((packed));

static void setup_queue(uint32_t qnum, struct virtq_desc **desc, struct virtq_avail_net **avail, struct virtq_used_net **used) {
    mmio_write32(net_base, VIRTIO_REG_QUEUE_SEL, qnum);
    uint32_t qmax = mmio_read32(net_base, VIRTIO_REG_QUEUE_NUM_MAX);
    uart_printf("[KNet] Queue %d Max Size: %d\n", qnum, qmax);
    if (qmax == 0) return;
    
    net_qmax = qmax;
    mmio_write32(net_base, VIRTIO_REG_QUEUE_NUM, qmax);
    
    void *queue_page = (void *)net_queue_mem[qnum];
    memset(queue_page, 0, 32768);
    
    mmio_write32(net_base, VIRTIO_REG_GUEST_PAGE_SIZE, 4096);
    mmio_write32(net_base, VIRTIO_REG_QUEUE_ALIGN, 4096);
    
    *desc = (struct virtq_desc *)queue_page;
    struct virtq_avail_net *avail_net = (struct virtq_avail_net *)((uint8_t *)(*desc) + sizeof(struct virtq_desc) * qmax);
    *avail = avail_net;
    
    uint64_t used_addr = (uint64_t)avail_net + 4 + (qmax * 2) + 2;
    used_addr = (used_addr + 4095) & ~4095;
    *used = (struct virtq_used_net *)used_addr;
    
    uint32_t pfn = (uint32_t)((uint64_t)queue_page / 4096);
    mmio_write32(net_base, VIRTIO_REG_QUEUE_PFN, pfn);
}

void virtio_net_init(void) {
    for (int i = 0; i < VIRTIO_MMIO_COUNT; i++) {
        uint64_t base = VIRTIO_MMIO_BASE + (i * VIRTIO_MMIO_SIZE);
        uint32_t magic = mmio_read32(base, VIRTIO_REG_MAGICValue);
        
        if (magic == 0x74726976) { // "virt"
            uint32_t device_id = mmio_read32(base, VIRTIO_REG_DEVICEID);
            if (device_id == 1) { // virtio-net
                net_base = base;
                uart_printf("[+] Virtio Network Device found at MMIO 0x%x\n", (uint32_t)net_base);
                break;
            }
        }
    }

    if (net_base == 0) {
        uart_puts("[-] Virtio Network Device not found.\n");
        return;
    }

    // Reset
    mmio_write32(net_base, VIRTIO_REG_STATUS, 0);
    
    uint32_t status = VIRTIO_STATUS_ACKNOWLEDGE;
    mmio_write32(net_base, VIRTIO_REG_STATUS, status);
    
    status |= VIRTIO_STATUS_DRIVER;
    mmio_write32(net_base, VIRTIO_REG_STATUS, status);

    // Negotiate features: VIRTIO_NET_F_MAC is bit 5
    uint32_t features = mmio_read32(net_base, VIRTIO_REG_DEVICE_FEAT);
    mmio_write32(net_base, VIRTIO_REG_DRIVER_FEAT, features & (1 << 5)); 

    // Read MAC address
    for (int i = 0; i < 6; i++) {
        mac_addr[i] = mmio_read8(net_base, VIRTIO_REG_CONFIG + i);
    }

    uart_printf("[+] Virtio-Net MAC Address: %x:%x:%x:%x:%x:%x\n", 
                mac_addr[0], mac_addr[1], mac_addr[2], 
                mac_addr[3], mac_addr[4], mac_addr[5]);

    // Setup Queues
    setup_queue(0, &rx_desc, &rx_avail, &rx_used);
    setup_queue(1, &tx_desc, &tx_avail, &tx_used);
    
    // Populate RX queue with buffers
    for (int i = 0; i < net_qmax; i++) {
        rx_desc[i].addr = (uint64_t)rx_buffers[i];
        rx_desc[i].len = RX_BUFFER_SIZE;
        rx_desc[i].flags = 2; // VIRTQ_DESC_F_WRITE (device writes to it)
        rx_desc[i].next = 0;
        
        rx_avail->ring[i] = i;
    }
    
    status |= VIRTIO_STATUS_DRIVER_OK;
    mmio_write32(net_base, VIRTIO_REG_STATUS, status);

    __asm__ volatile("dmb sy" ::: "memory");
    rx_avail_idx = net_qmax;
    rx_avail->idx = rx_avail_idx;
    // mmio_write32(net_base, VIRTIO_REG_QUEUE_NOTIFY, 0); // Notify Queue 0 (RX)
}

static uint16_t last_rx_used_idx = 0;
static uint16_t last_tx_used_idx = 0;

static uint32_t poll_ticks = 0;

void virtio_net_poll(void) {
    if (!net_base) return;

    poll_ticks++;
    if (poll_ticks == 1000) {
        extern void test_arp(void);
        test_arp();
        poll_ticks = 0;
    }

    __asm__ volatile("dmb sy" ::: "memory");

    if (poll_ticks == 999) {
        uart_printf("[KNet] tx_used->idx = %d, last = %d\n", tx_used->idx, last_tx_used_idx);
    }

    while (last_tx_used_idx != tx_used->idx) {
        uint16_t ring_idx = last_tx_used_idx % net_qmax;
        uint32_t id = tx_used->ring[ring_idx].id;
        uart_printf("[KNet] TX packet at descriptor %d acknowledged by QEMU!\n", id);
        last_tx_used_idx++;
    }

    __asm__ volatile("dmb sy" ::: "memory");

    while (last_rx_used_idx != rx_used->idx) {
        uint16_t ring_idx = last_rx_used_idx % net_qmax;
        uint32_t id = rx_used->ring[ring_idx].id;
        uint32_t len = rx_used->ring[ring_idx].len;
        
        uart_printf("[KNet] Received packet of size %d bytes at descriptor %d\n", len, id);
        
        uint8_t *pkt = rx_buffers[id];
        uart_puts("       Hex: ");
        for (uint32_t i = 0; i < 32 && i < len; i++) {
            uart_printf("%x ", pkt[i]);
        }
        uart_puts("\n");
        
        // Re-queue
        rx_avail->ring[rx_avail_idx % net_qmax] = id;
        __asm__ volatile("dmb sy" ::: "memory");
        rx_avail_idx++;
        rx_avail->idx = rx_avail_idx;
        mmio_write32(net_base, VIRTIO_REG_QUEUE_NOTIFY, 0);
        
        last_rx_used_idx++;
    }
}

static uint16_t tx_desc_idx = 0;

void virtio_net_send(const void *packet, size_t len) {
    if (!net_base) return;
    
    uint16_t head_idx = tx_desc_idx % net_qmax;
    uint16_t next_idx = (tx_desc_idx + 1) % net_qmax;
    tx_desc_idx += 2;
    
    struct virtio_net_hdr *hdr = (struct virtio_net_hdr *)tx_buffers[head_idx];
    memset(hdr, 0, sizeof(struct virtio_net_hdr));
    
    // Copy payload to second buffer
    memcpy(tx_buffers[next_idx], packet, len);
    
    // Descriptor 1: Header
    tx_desc[head_idx].addr = (uint64_t)tx_buffers[head_idx];
    tx_desc[head_idx].len = sizeof(struct virtio_net_hdr);
    tx_desc[head_idx].flags = 1; // VIRTQ_DESC_F_NEXT
    tx_desc[head_idx].next = next_idx;
    
    // Descriptor 2: Payload
    tx_desc[next_idx].addr = (uint64_t)tx_buffers[next_idx];
    tx_desc[next_idx].len = len;
    tx_desc[next_idx].flags = 0;
    tx_desc[next_idx].next = 0;
    
    tx_avail->ring[tx_avail_idx % net_qmax] = head_idx;
    
    __asm__ volatile("dmb sy" ::: "memory");
    tx_avail_idx++; // One request added to the ring
    tx_avail->idx = tx_avail_idx;
    
    __asm__ volatile("dmb sy" ::: "memory");
    mmio_write32(net_base, VIRTIO_REG_QUEUE_NOTIFY, 1); // Notify Queue 1 (TX)
    
    uart_printf("[KNet] Sent packet of size %d bytes\n", len);
}

void virtio_net_get_mac(uint8_t *mac) {
    for (int i = 0; i < 6; i++) mac[i] = mac_addr[i];
}
