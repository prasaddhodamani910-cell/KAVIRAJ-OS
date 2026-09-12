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
#define VIRTIO_REG_QUEUE_NOTIFY  0x050
#define VIRTIO_REG_STATUS        0x070
#define VIRTIO_REG_CONFIG        0x100

// Status flags
#define VIRTIO_STATUS_ACKNOWLEDGE 1
#define VIRTIO_STATUS_DRIVER      2
#define VIRTIO_STATUS_DRIVER_OK   4

static uint64_t net_base = 0;
static uint8_t mac_addr[MAC_LEN];

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

    // We will set up the Queues (RX=0, TX=1) shortly.
    
    status |= VIRTIO_STATUS_DRIVER_OK;
    mmio_write32(net_base, VIRTIO_REG_STATUS, status);
}
