#include "fat16.h"
#include "virtio.h"
#include "uart.h"
#include "string.h"

static struct fat_bpb bpb;
static uint32_t fat_start_sector;
static uint32_t root_dir_start_sector;
static uint32_t root_dir_sectors;
static uint32_t data_start_sector;

void fat16_init(void) {
    uint8_t boot_sector[512];
    
    uart_puts("[FAT16] Reading Boot Sector (BPB)...\n");
    if (!virtio_blk_read_sector(0, boot_sector)) {
        uart_puts("[-] FAT16: Failed to read Boot Sector!\n");
        return;
    }

    memcpy(&bpb, boot_sector, sizeof(struct fat_bpb));

    // Verify it's FAT16
    if (strncmp(bpb.fs_type, "FAT16", 5) != 0 && strncmp(bpb.fs_type, "FAT12", 5) != 0) {
        // Sometimes mkfs.fat puts "mkfs.fat" here, let's just print a warning
        uart_puts("[WARNING] FAT16 magic not found. Assuming FAT16 anyway.\n");
    }

    fat_start_sector = bpb.reserved_sectors;
    root_dir_start_sector = fat_start_sector + (bpb.fat_count * bpb.fat_size_16);
    root_dir_sectors = (bpb.root_dir_entries * 32 + bpb.bytes_per_sector - 1) / bpb.bytes_per_sector;
    data_start_sector = root_dir_start_sector + root_dir_sectors;

    uart_printf("[+] FAT16 Initialized. Sectors/Cluster: %d, Root Entries: %d\n", bpb.sectors_per_cluster, bpb.root_dir_entries);
    uart_printf("    Data Start Sector: %d\n", data_start_sector);
}

void fat16_list_root(void) {
    uint8_t sector_buf[512];
    
    uart_puts("\n[FAT16 Root Directory]\n");
    for (uint32_t s = 0; s < root_dir_sectors; s++) {
        virtio_blk_read_sector(root_dir_start_sector + s, sector_buf);
        
        struct fat_dir_entry *entry = (struct fat_dir_entry *)sector_buf;
        for (int i = 0; i < 512 / 32; i++) {
            if (entry[i].name[0] == 0x00) {
                return; // End of directory
            }
            if ((uint8_t)entry[i].name[0] == 0xE5) {
                continue; // Deleted file
            }
            if (entry[i].attributes & FAT_ATTR_LFN) {
                continue; // Skip Long File Name entries for now
            }
            if (entry[i].attributes & FAT_ATTR_VOLUME_ID) {
                continue; // Skip Volume ID
            }

            // Print 8.3 name nicely
            char name_str[13];
            int pos = 0;
            for (int j = 0; j < 8; j++) {
                if (entry[i].name[j] != ' ') name_str[pos++] = entry[i].name[j];
            }
            if (entry[i].name[8] != ' ') {
                name_str[pos++] = '.';
                for (int j = 8; j < 11; j++) {
                    if (entry[i].name[j] != ' ') name_str[pos++] = entry[i].name[j];
                }
            }
            name_str[pos] = '\0';

            if (entry[i].attributes & FAT_ATTR_DIRECTORY) {
                uart_printf("<DIR>     %s\n", name_str);
            } else {
                uart_printf("<FILE>    %s (%u bytes)\n", name_str, entry[i].size);
            }
        }
    }
}

static void to_fat_name(const char *filename, char *fat_name) {
    for (int i = 0; i < 11; i++) fat_name[i] = ' ';
    int i = 0, j = 0;
    while (filename[i] != '\0' && filename[i] != '.' && j < 8) {
        char c = filename[i++];
        if (c >= 'a' && c <= 'z') c -= 32;
        fat_name[j++] = c;
    }
    while (filename[i] != '\0' && filename[i] != '.') i++;
    if (filename[i] == '.') {
        i++;
        j = 8;
        while (filename[i] != '\0' && j < 11) {
            char c = filename[i++];
            if (c >= 'a' && c <= 'z') c -= 32;
            fat_name[j++] = c;
        }
    }
}

uint16_t fat16_get_next_cluster(uint16_t cluster) {
    uint32_t fat_offset = cluster * 2;
    uint32_t fat_sector = fat_start_sector + (fat_offset / 512);
    uint32_t ent_offset = fat_offset % 512;
    uint8_t sector_buf[512];
    virtio_blk_read_sector(fat_sector, sector_buf);
    return *((uint16_t *)&sector_buf[ent_offset]);
}

int fat16_read_file(const char *filename, char *buffer, size_t max_len) {
    char fat_name[11];
    to_fat_name(filename, fat_name);

    uint8_t sector_buf[512];
    struct fat_dir_entry target;
    int found = 0;
    
    // Find file in root dir
    for (uint32_t s = 0; s < root_dir_sectors; s++) {
        virtio_blk_read_sector(root_dir_start_sector + s, sector_buf);
        struct fat_dir_entry *entry = (struct fat_dir_entry *)sector_buf;
        for (int i = 0; i < 512 / 32; i++) {
            if (entry[i].name[0] == 0x00) goto search_end;
            if ((uint8_t)entry[i].name[0] == 0xE5) continue;
            if (entry[i].attributes & FAT_ATTR_LFN) continue;
            if (entry[i].attributes & FAT_ATTR_DIRECTORY) continue;
            
            if (strncmp(entry[i].name, fat_name, 11) == 0) {
                target = entry[i];
                found = 1;
                break;
            }
        }
        if (found) break;
    }
    
search_end:
    if (!found) return -1; // Not found
    
    if (target.size == 0) {
        if (max_len > 0) buffer[0] = '\0';
        return 0;
    }
    
    uint16_t cluster = target.first_cluster_low;
    size_t bytes_read = 0;
    
    while (cluster >= 2 && cluster < 0xFFF8 && bytes_read < target.size && bytes_read < max_len) {
        uint32_t sector = data_start_sector + (cluster - 2) * bpb.sectors_per_cluster;
        for (int i = 0; i < bpb.sectors_per_cluster; i++) {
            virtio_blk_read_sector(sector + i, sector_buf);
            size_t to_copy = 512;
            if (bytes_read + to_copy > target.size) to_copy = target.size - bytes_read;
            if (bytes_read + to_copy > max_len - 1) to_copy = max_len - 1 - bytes_read;
            
            memcpy(buffer + bytes_read, sector_buf, to_copy);
            bytes_read += to_copy;
            
            if (bytes_read >= target.size || bytes_read >= max_len - 1) break;
        }
        cluster = fat16_get_next_cluster(cluster);
    }
    
    buffer[bytes_read] = '\0';
    return bytes_read;
}

void fat16_set_fat_entry(uint16_t cluster, uint16_t value) {
    uint32_t fat_offset = cluster * 2;
    uint32_t fat_sector = fat_start_sector + (fat_offset / 512);
    uint32_t ent_offset = fat_offset % 512;
    uint8_t sector_buf[512];
    virtio_blk_read_sector(fat_sector, sector_buf);
    *((uint16_t *)&sector_buf[ent_offset]) = value;
    virtio_blk_write_sector(fat_sector, sector_buf);
    
    // Write to secondary FATs
    for (int i = 1; i < bpb.fat_count; i++) {
        uint32_t backup_fat_sector = fat_sector + (i * bpb.fat_size_16);
        virtio_blk_write_sector(backup_fat_sector, sector_buf);
    }
}

uint16_t fat16_allocate_cluster(void) {
    uint8_t sector_buf[512];
    for (uint32_t s = 0; s < bpb.fat_size_16; s++) {
        virtio_blk_read_sector(fat_start_sector + s, sector_buf);
        uint16_t *entries = (uint16_t *)sector_buf;
        for (int i = 0; i < 256; i++) {
            uint16_t cluster = s * 256 + i;
            if (cluster < 2) continue;
            if (entries[i] == 0x0000) {
                entries[i] = 0xFFFF; // EOF
                virtio_blk_write_sector(fat_start_sector + s, sector_buf);
                for (int f = 1; f < bpb.fat_count; f++) {
                    virtio_blk_write_sector(fat_start_sector + s + (f * bpb.fat_size_16), sector_buf);
                }
                return cluster;
            }
        }
    }
    return 0; // Disk full
}

int fat16_write_file(const char *filename, const char *data, size_t len) {
    char fat_name[11];
    to_fat_name(filename, fat_name);

    uint8_t sector_buf[512];
    struct fat_dir_entry *target = NULL;
    uint32_t target_sector = 0;
    
    // 1. Find file or find a free slot
    for (uint32_t s = 0; s < root_dir_sectors; s++) {
        virtio_blk_read_sector(root_dir_start_sector + s, sector_buf);
        struct fat_dir_entry *entry = (struct fat_dir_entry *)sector_buf;
        for (int i = 0; i < 512 / 32; i++) {
            if (entry[i].name[0] == 0x00 || (uint8_t)entry[i].name[0] == 0xE5) {
                if (!target) {
                    target = &entry[i];
                    target_sector = root_dir_start_sector + s;
                }
            } else if (strncmp(entry[i].name, fat_name, 11) == 0 && !(entry[i].attributes & FAT_ATTR_DIRECTORY)) {
                target = &entry[i];
                target_sector = root_dir_start_sector + s;
                break; // Found existing file
            }
        }
        if (target && strncmp(target->name, fat_name, 11) == 0) break;
    }
    
    if (!target) return -1; // No free slots
    
    // 2. Clear old clusters if overwriting
    if (strncmp(target->name, fat_name, 11) == 0 && target->first_cluster_low >= 2) {
        uint16_t c = target->first_cluster_low;
        while (c >= 2 && c < 0xFFF8) {
            uint16_t next = fat16_get_next_cluster(c);
            fat16_set_fat_entry(c, 0x0000);
            c = next;
        }
    }
    
    // 3. Allocate new clusters and write data
    uint16_t first_cluster = 0;
    uint16_t prev_cluster = 0;
    size_t written = 0;
    
    while (written < len || (len == 0 && first_cluster == 0)) {
        uint16_t c = fat16_allocate_cluster();
        if (c == 0) return -2; // Disk full
        
        if (first_cluster == 0) first_cluster = c;
        if (prev_cluster != 0) fat16_set_fat_entry(prev_cluster, c);
        
        uint32_t data_sector = data_start_sector + (c - 2) * bpb.sectors_per_cluster;
        
        for (int i = 0; i < bpb.sectors_per_cluster; i++) {
            size_t to_write = 512;
            if (written + to_write > len) to_write = len - written;
            
            memset(sector_buf, 0, 512);
            memcpy(sector_buf, data + written, to_write);
            virtio_blk_write_sector(data_sector + i, sector_buf);
            
            written += to_write;
            if (written >= len) break;
        }
        prev_cluster = c;
        if (len == 0) break; // Allow empty files
    }
    
    // 4. Update Directory Entry
    // Re-read the sector that contains the target directory entry
    virtio_blk_read_sector(target_sector, sector_buf);
    
    // We need to find the exact slot again.
    // It's either an empty slot (name[0] == 0x00 or 0xE5) or the existing file.
    struct fat_dir_entry *entry = (struct fat_dir_entry *)sector_buf;
    for (int i = 0; i < 512 / 32; i++) {
        int match = 0;
        if (strncmp(entry[i].name, fat_name, 11) == 0) {
            match = 1;
        } else if (entry[i].name[0] == 0x00 || (uint8_t)entry[i].name[0] == 0xE5) {
            match = 1;
        }
        
        if (match) {
            strncpy(entry[i].name, fat_name, 11);
            entry[i].attributes = FAT_ATTR_ARCHIVE;
            entry[i].first_cluster_low = first_cluster;
            entry[i].first_cluster_high = 0;
            entry[i].size = len;
            virtio_blk_write_sector(target_sector, sector_buf);
            break;
        }
    }
    
    return len;
}

#include "vfs.h"
void fat16_populate_vfs(void) {
    uint8_t sector_buf[512];
    for (uint32_t s = 0; s < root_dir_sectors; s++) {
        virtio_blk_read_sector(root_dir_start_sector + s, sector_buf);
        struct fat_dir_entry *entry = (struct fat_dir_entry *)sector_buf;
        for (int i = 0; i < 512 / 32; i++) {
            if (entry[i].name[0] == 0x00) return;
            if ((uint8_t)entry[i].name[0] == 0xE5) continue;
            if (entry[i].attributes & FAT_ATTR_LFN) continue;
            if (entry[i].attributes & FAT_ATTR_DIRECTORY) continue;
            if (entry[i].attributes & FAT_ATTR_VOLUME_ID) continue;

            char name_str[13];
            int pos = 0;
            for (int j = 0; j < 8; j++) {
                if (entry[i].name[j] != ' ') name_str[pos++] = entry[i].name[j];
            }
            if (entry[i].name[8] != ' ') {
                name_str[pos++] = '.';
                for (int j = 8; j < 11; j++) {
                    if (entry[i].name[j] != ' ') name_str[pos++] = entry[i].name[j];
                }
            }
            name_str[pos] = '\0';
            
            char file_buf[1024];
            int bytes = fat16_read_file(name_str, file_buf, sizeof(file_buf));
            if (bytes >= 0) {
                vfs_touch(name_str, file_buf);
            }
        }
    }
}
