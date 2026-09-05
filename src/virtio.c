#include <virtio.h>
#include <uart.h>
#include <pmm.h>
#include <string.h>

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
#define VIRTIO_REG_QUEUE_READY   0x044
#define VIRTIO_REG_QUEUE_NOTIFY  0x050
#define VIRTIO_REG_INTERRUPT_STA 0x060
#define VIRTIO_REG_INTERRUPT_ACK 0x064
#define VIRTIO_REG_STATUS        0x070
#define VIRTIO_REG_QUEUE_DESC_LO 0x080
#define VIRTIO_REG_QUEUE_DESC_HI 0x084
#define VIRTIO_REG_QUEUE_DRVR_LO 0x090
#define VIRTIO_REG_QUEUE_DRVR_HI 0x094
#define VIRTIO_REG_QUEUE_DEVC_LO 0x0a0
#define VIRTIO_REG_QUEUE_DEVC_HI 0x0a4

// Status flags
#define VIRTIO_STATUS_ACKNOWLEDGE 1
#define VIRTIO_STATUS_DRIVER      2
#define VIRTIO_STATUS_FAILED      128
#define VIRTIO_STATUS_FEATURES_OK 8
#define VIRTIO_STATUS_DRIVER_OK   4

#define QUEUE_SIZE 16

struct virtq_desc {
    uint64_t addr;
    uint32_t len;
    uint16_t flags;
    uint16_t next;
} __attribute__((packed));

struct virtq_avail {
    uint16_t flags;
    uint16_t idx;
    uint16_t ring[QUEUE_SIZE];
    uint16_t used_event;
} __attribute__((packed));

struct virtq_used_elem {
    uint32_t id;
    uint32_t len;
} __attribute__((packed));

struct virtq_used {
    volatile uint16_t flags;
    volatile uint16_t idx;
    struct virtq_used_elem ring[QUEUE_SIZE];
    volatile uint16_t avail_event;
} __attribute__((packed));

struct virtio_blk_req {
    uint32_t type;
    uint32_t reserved;
    uint64_t sector;
} __attribute__((packed));

// Virtqueue structures (must be contiguous in memory)
static struct virtq_desc *vq_desc;
static struct virtq_avail *vq_avail;
static struct virtq_used *vq_used;

static uint64_t blk_base = 0;
static uint16_t avail_idx = 0;

static uint32_t mmio_read32(uint64_t base, uint64_t offset) {
    return *(volatile uint32_t *)(base + offset);
}

static void mmio_write32(uint64_t base, uint64_t offset, uint32_t value) {
    *(volatile uint32_t *)(base + offset) = value;
}

int virtio_blk_init(void) {
    // 1. Probe for virtio block device
    for (int i = 0; i < VIRTIO_MMIO_COUNT; i++) {
        uint64_t base = VIRTIO_MMIO_BASE + (i * VIRTIO_MMIO_SIZE);
        uint32_t magic = mmio_read32(base, VIRTIO_REG_MAGICValue);
        
        if (magic == 0x74726976) { // "virt"
            uint32_t version = mmio_read32(base, VIRTIO_REG_VERSION);
            uint32_t device_id = mmio_read32(base, VIRTIO_REG_DEVICEID);
            
            if (device_id == 2) { // virtio-blk
                blk_base = base;
                uart_printf("[+] Virtio Block Device found at MMIO 0x%x (Version: %d)\n", (uint32_t)blk_base, version);
                break;
            }
        }
    }

    if (blk_base == 0) {
        uart_puts("[-] Virtio Block Device not found.\n");
        return 0;
    }

    // 2. Device Initialization Sequence
    mmio_write32(blk_base, VIRTIO_REG_STATUS, 0); // Reset
    
    uint32_t status = VIRTIO_STATUS_ACKNOWLEDGE;
    mmio_write32(blk_base, VIRTIO_REG_STATUS, status);
    
    status |= VIRTIO_STATUS_DRIVER;
    mmio_write32(blk_base, VIRTIO_REG_STATUS, status);
    
    // Negotiate features (accept none for simplicity)
    mmio_write32(blk_base, VIRTIO_REG_DRIVER_FEAT, 0);
    
    // Legacy Virtio (Version 1) does NOT use FEATURES_OK (8).
    
    // 3. Setup Virtqueue (Queue 0)
    mmio_write32(blk_base, VIRTIO_REG_QUEUE_SEL, 0);
    uint32_t qmax = mmio_read32(blk_base, VIRTIO_REG_QUEUE_NUM_MAX);
    if (qmax == 0) {
        uart_puts("[-] Virtio: Queue not available\n");
        return 0;
    }

    mmio_write32(blk_base, VIRTIO_REG_QUEUE_NUM, QUEUE_SIZE);

    // Allocate 2 contiguous pages for virtqueue (Desc + Avail in page 1, Used in page 2)
    void *queue_page = pmm_alloc_page();
    pmm_alloc_page(); // Reserve the next page
    if (!queue_page) return 0;
    
    // Memory layout: Desc -> Avail -> Padding -> Used
    // In legacy virtio, Used ring must be aligned to the QueueAlign boundary (usually 4096)
    mmio_write32(blk_base, 0x028, 4096); // VIRTIO_REG_QUEUE_ALIGN = 4096
    
    vq_desc = (struct virtq_desc *)queue_page;
    vq_avail = (struct virtq_avail *)((uint8_t *)vq_desc + sizeof(struct virtq_desc) * QUEUE_SIZE);
    
    uint64_t used_addr = (uint64_t)vq_avail + sizeof(struct virtq_avail);
    used_addr = (used_addr + 4095) & ~4095; // Align to next page (4096)
    vq_used = (struct virtq_used *)used_addr;

    // Send queue address (Page Frame Number) to device
    uint32_t pfn = (uint32_t)((uint64_t)queue_page / 4096);
    mmio_write32(blk_base, 0x040, pfn); // VIRTIO_REG_QUEUE_PFN

    // Legacy virtio DOES NOT use VIRTIO_REG_QUEUE_READY!
    // But we write it just in case some emulators look for it.
    // Actually, writing to PFN is what activates the queue in legacy.

    // 4. Set DRIVER_OK
    status |= VIRTIO_STATUS_DRIVER_OK;
    mmio_write32(blk_base, VIRTIO_REG_STATUS, status);
    
    uart_puts("[+] Virtio Block Driver Initialized & Ready!\n");
    return 1;
}

// Simple synchronous polling read
int virtio_blk_read_sector(uint64_t sector, void *buffer) {
    if (!blk_base) return 0;

    // We need 3 descriptors for a read request:
    // 0: virtio_blk_req header (Device reads)
    // 1: buffer (Device writes)
    // 2: status byte (Device writes)

    // Allocate request struct and status byte (in a real OS, allocate safely, here we just use static for demo)
    static struct virtio_blk_req req;
    static volatile uint8_t req_status;

    req.type = 0; // VIRTIO_BLK_T_IN (Read)
    req.reserved = 0;
    req.sector = sector;
    req_status = 255;

    // Desc 0
    vq_desc[0].addr = (uint64_t)&req;
    vq_desc[0].len = sizeof(struct virtio_blk_req);
    vq_desc[0].flags = 1; // VIRTQ_DESC_F_NEXT
    vq_desc[0].next = 1;

    // Desc 1
    vq_desc[1].addr = (uint64_t)buffer;
    vq_desc[1].len = 512;
    vq_desc[1].flags = 1 | 2; // NEXT | WRITE
    vq_desc[1].next = 2;

    // Desc 2
    vq_desc[2].addr = (uint64_t)&req_status;
    vq_desc[2].len = 1;
    vq_desc[2].flags = 2; // WRITE
    vq_desc[2].next = 0;

    // Publish descriptor index to Available Ring
    vq_avail->ring[avail_idx % QUEUE_SIZE] = 0;
    
    // Memory barrier should be here
    __asm__ volatile("dmb sy" ::: "memory");
    
    avail_idx++;
    vq_avail->idx = avail_idx;
    
    __asm__ volatile("dmb sy" ::: "memory");
    mmio_write32(blk_base, VIRTIO_REG_QUEUE_NOTIFY, 0);

    // Poll for completion
    uint16_t last_used_idx = vq_used->idx;
    int timeout = 10000000;
    while (vq_used->idx == last_used_idx && timeout > 0) {
        for(volatile int i=0; i<100; i++);
        timeout--;
    }

    if (req_status != 0) {
        uart_printf("[-] Virtio Read Error (Status: %d)\n", req_status);
        return 0;
    }

    return 1;
}
