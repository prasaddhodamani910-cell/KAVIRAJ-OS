#include "vfs.h"
#include "string.h"
#include "uart.h"

#if defined(__STDC_HOSTED__) && __STDC_HOSTED__ == 1
#include <stdio.h>
#endif

static vfs_node_t node_pool[MAX_NODES];
static int node_count = 0;

static vfs_node_t *root_dir = NULL;
static vfs_node_t *current_dir = NULL;

int vfs_load_internal(void);

static vfs_node_t *alloc_node(const char *name, vfs_type_t type, vfs_node_t *parent) {
    if (node_count >= MAX_NODES) {
        return NULL;
    }
    vfs_node_t *node = &node_pool[node_count++];
    memset(node, 0, sizeof(vfs_node_t));
    
    // Copy name
    size_t i = 0;
    while (name[i] != '\0' && i < MAX_NAME_LEN - 1) {
        node->name[i] = name[i];
        i++;
    }
    node->name[i] = '\0';
    
    node->type = type;
    node->parent = parent;
    node->size = 0;
    node->child_count = 0;

    if (parent != NULL && parent->child_count < MAX_CHILDREN) {
        parent->children[parent->child_count++] = node;
    }

    return node;
}

void vfs_init(void) {
    if (vfs_load_internal()) {
        return; // Successfully loaded from persistent storage
    }

    node_count = 0;
    root_dir = alloc_node("/", FS_DIR, NULL);
    current_dir = root_dir;

    // Create default root directories
    vfs_node_t *bin = alloc_node("bin", FS_DIR, root_dir);
    vfs_node_t *etc = alloc_node("etc", FS_DIR, root_dir);
    vfs_node_t *home = alloc_node("home", FS_DIR, root_dir);
    vfs_node_t *docs = alloc_node("docs", FS_DIR, root_dir);

    // Create /bin/ai executable entry
    vfs_node_t *bin_ai = alloc_node("ai", FS_FILE, bin);
    if (bin_ai) {
        const char *ai_bin_msg = "ELF64 AArch64 executable: Kaviraj AI Neural Engine (Type 'ai' to execute)\n";
        strcpy(bin_ai->data, ai_bin_msg);
        bin_ai->size = strlen(ai_bin_msg);
    }

    // Create /etc/os-release
    vfs_node_t *os_rel = alloc_node("os-release", FS_FILE, etc);
    if (os_rel) {
        const char *rel_info = "NAME=\"Kaviraj OS\"\nVERSION=\"1.0.0\"\nCREATOR=\"Prasad Dhodamani\"\nARCH=\"aarch64\"\n";
        strcpy(os_rel->data, rel_info);
        os_rel->size = strlen(rel_info);
    }

    // Create /docs/welcome.txt
    vfs_node_t *welcome = alloc_node("welcome.txt", FS_FILE, docs);
    if (welcome) {
        const char *msg = "Welcome to Kaviraj OS!\nDesigned and developed by Prasad Dhodamani.\nA 64-bit ARM bare-metal operating system kernel.\n";
        strcpy(welcome->data, msg);
        welcome->size = strlen(msg);
    }

    // Create /docs/hardware.txt
    vfs_node_t *hw = alloc_node("hardware.txt", FS_FILE, docs);
    if (hw) {
        const char *hw_msg = "CPU: 64-bit ARMv8-A (AArch64)\nConsole: PL011 UART MMIO (0x09000000)\nBase Address: 0x40000000\n";
        strcpy(hw->data, hw_msg);
        hw->size = strlen(hw_msg);
    }

    // Create /docs/ai.txt
    vfs_node_t *ai_doc = alloc_node("ai.txt", FS_FILE, docs);
    if (ai_doc) {
        const char *ai_msg = "Kaviraj AI Assistant (ChatGPT for Kaviraj OS)\nType 'ai' or 'chat' in the terminal to launch the interactive AI session.\nType 'ai <question>' for quick single-shot answers.\n";
        strcpy(ai_doc->data, ai_msg);
        ai_doc->size = strlen(ai_msg);
    }

    // Create /home/readme.txt
    vfs_node_t *readme = alloc_node("readme.txt", FS_FILE, home);
    if (readme) {
        const char *rm_msg = "Kaviraj OS Terminal Shell ready.\nAvailable commands: ai, ls, cd, cat, mkdir, touch, write, rm, pwd, clear, exit.\nType 'ai' to chat with Kaviraj AI!\n";
        strcpy(readme->data, rm_msg);
        readme->size = strlen(rm_msg);
    }
}

vfs_node_t *vfs_get_root(void) {
    return root_dir;
}

vfs_node_t *vfs_get_cwd(void) {
    return current_dir;
}

void vfs_getcwd(char *buf, size_t max_len) {
    if (!current_dir || current_dir == root_dir) {
        if (max_len > 1) {
            buf[0] = '/';
            buf[1] = '\0';
        }
        return;
    }

    // Reconstruct path from root to current_dir
    vfs_node_t *path_nodes[16];
    int depth = 0;
    vfs_node_t *curr = current_dir;
    while (curr && curr != root_dir && depth < 16) {
        path_nodes[depth++] = curr;
        curr = curr->parent;
    }

    buf[0] = '\0';
    size_t pos = 0;
    for (int i = depth - 1; i >= 0; i--) {
        if (pos < max_len - 1) {
            buf[pos++] = '/';
            buf[pos] = '\0';
        }
        size_t nlen = strlen(path_nodes[i]->name);
        for (size_t k = 0; k < nlen && pos < max_len - 1; k++) {
            buf[pos++] = path_nodes[i]->name[k];
        }
        buf[pos] = '\0';
    }
}

vfs_node_t *vfs_find(const char *path) {
    if (!path || path[0] == '\0') return NULL;

    vfs_node_t *curr = current_dir;
    size_t idx = 0;

    if (path[0] == '/') {
        curr = root_dir;
        idx = 1;
        while (path[idx] == '/') idx++;
        if (path[idx] == '\0') return root_dir;
    }

    char segment[MAX_NAME_LEN];
    while (path[idx] != '\0') {
        size_t seg_len = 0;
        while (path[idx] != '/' && path[idx] != '\0' && seg_len < MAX_NAME_LEN - 1) {
            segment[seg_len++] = path[idx++];
        }
        segment[seg_len] = '\0';
        while (path[idx] == '/') idx++;

        if (strcmp(segment, ".") == 0) {
            continue;
        } else if (strcmp(segment, "..") == 0) {
            if (curr->parent != NULL) {
                curr = curr->parent;
            }
        } else {
            // Find child with matching name
            vfs_node_t *found = NULL;
            for (int c = 0; c < curr->child_count; c++) {
                if (curr->children[c] && strcmp(curr->children[c]->name, segment) == 0) {
                    found = curr->children[c];
                    break;
                }
            }
            if (!found) {
                return NULL;
            }
            curr = found;
        }
    }

    return curr;
}

int vfs_chdir(const char *path) {
    if (!path || path[0] == '\0' || strcmp(path, "~") == 0) {
        vfs_node_t *home = vfs_find("/home");
        if (home && home->type == FS_DIR) {
            current_dir = home;
            return 0;
        }
        current_dir = root_dir;
        return 0;
    }

    vfs_node_t *target = vfs_find(path);
    if (!target) {
        return -1; // Directory not found
    }
    if (target->type != FS_DIR) {
        return -2; // Not a directory
    }

    current_dir = target;
    return 0;
}

int vfs_mkdir(const char *name) {
    if (!name || name[0] == '\0') return -1;
    if (current_dir->child_count >= MAX_CHILDREN) return -2; // Directory full

    // Check if name already exists
    for (int i = 0; i < current_dir->child_count; i++) {
        if (current_dir->children[i] && strcmp(current_dir->children[i]->name, name) == 0) {
            return -3; // Already exists
        }
    }

    vfs_node_t *new_dir = alloc_node(name, FS_DIR, current_dir);
    if (!new_dir) return -4; // Out of nodes
    vfs_sync();
    return 0;
}

int vfs_touch(const char *path, const char *initial_data) {
    if (!path || path[0] == '\0') return -1;
    
    char dir_path[256];
    char file_name[MAX_NAME_LEN];
    vfs_node_t *target_dir = current_dir;
    
        char *last_slash = NULL;
    for (int i = 0; path[i] != '\0'; i++) {
        if (path[i] == '/') last_slash = (char *)&path[i];
    }
    if (last_slash) {
        size_t dlen = last_slash - path;
        if (dlen >= sizeof(dir_path)) dlen = sizeof(dir_path) - 1;
        strncpy(dir_path, path, dlen);
        dir_path[dlen] = '\0';
        
        target_dir = vfs_find(dir_path);
        if (!target_dir || target_dir->type != FS_DIR) return -1;
        
        strncpy(file_name, last_slash + 1, MAX_NAME_LEN - 1);
    } else {
        strncpy(file_name, path, MAX_NAME_LEN - 1);
    }
    file_name[MAX_NAME_LEN - 1] = '\0';

    for (int i = 0; i < target_dir->child_count; i++) {
        if (target_dir->children[i] && strcmp(target_dir->children[i]->name, file_name) == 0) {
            if (initial_data) {
                size_t dlen = strlen(initial_data);
                if (dlen >= MAX_FILE_SIZE) dlen = MAX_FILE_SIZE - 1;
                memcpy(target_dir->children[i]->data, initial_data, dlen);
                target_dir->children[i]->data[dlen] = '\0';
                target_dir->children[i]->size = dlen;
                vfs_sync();
            }
            return 0;
        }
    }

    if (target_dir->child_count >= MAX_CHILDREN) return -2;

    vfs_node_t *new_file = alloc_node(file_name, FS_FILE, target_dir);
    if (!new_file) return -4;

    if (initial_data) {
        size_t dlen = strlen(initial_data);
        if (dlen >= MAX_FILE_SIZE) dlen = MAX_FILE_SIZE - 1;
        memcpy(new_file->data, initial_data, dlen);
        new_file->data[dlen] = '\0';
        new_file->size = dlen;
    }

    vfs_sync();
    return 0;
}

int vfs_write_file(const char *name, const char *data) {
    return vfs_touch(name, data);
}

int vfs_remove(const char *name) {
    if (!name || name[0] == '\0') return -1;

    int idx = -1;
    for (int i = 0; i < current_dir->child_count; i++) {
        if (current_dir->children[i] && strcmp(current_dir->children[i]->name, name) == 0) {
            idx = i;
            break;
        }
    }

    if (idx == -1) return -1; // Not found

    // Shift remaining children
    for (int i = idx; i < current_dir->child_count - 1; i++) {
        current_dir->children[i] = current_dir->children[i + 1];
    }
    current_dir->children[current_dir->child_count - 1] = NULL;
    current_dir->child_count--;
    vfs_sync();
    return 0;
}

int vfs_list_dir(vfs_node_t *dir) {
    if (!dir) dir = current_dir;
    if (dir->type != FS_DIR) return -1;

    uart_puts("\033[1;37mTYPE   SIZE    NAME\033[0m\n");
    uart_puts("----------------------------------------\n");

    // Print . and ..
    uart_puts("\033[1;34m<DIR>          .\033[0m\n");
    if (dir->parent != NULL) {
        uart_puts("\033[1;34m<DIR>          ..\033[0m\n");
    }

    for (int i = 0; i < dir->child_count; i++) {
        vfs_node_t *child = dir->children[i];
        if (!child) continue;

        if (child->type == FS_DIR) {
            uart_printf("\033[1;34m<DIR>          %s/\033[0m\n", child->name);
        } else {
            uart_printf("\033[0m<FILE> %u B\t%s\033[0m\n", (uint32_t)child->size, child->name);
        }
    }

    uart_printf("\n\033[36mTotal: %d item(s)\033[0m\n", dir->child_count);
    return 0;
}

void vfs_sync(void) {
#if defined(__STDC_HOSTED__) && __STDC_HOSTED__ == 1
    FILE *f = fopen("kaviraj_disk.img", "wb");
    if (!f) return;
    
    // Make a temporary copy to manipulate pointers safely
    vfs_node_t temp_pool[MAX_NODES];
    memcpy(temp_pool, node_pool, sizeof(vfs_node_t) * node_count);
    
    for (int i = 0; i < node_count; i++) {
        if (temp_pool[i].parent) {
            long idx = temp_pool[i].parent - node_pool;
            temp_pool[i].parent = (vfs_node_t*)idx;
        } else {
            temp_pool[i].parent = (vfs_node_t*)-1;
        }
        
        for (int c = 0; c < temp_pool[i].child_count; c++) {
            if (temp_pool[i].children[c]) {
                long idx = temp_pool[i].children[c] - node_pool;
                temp_pool[i].children[c] = (vfs_node_t*)idx;
            } else {
                temp_pool[i].children[c] = (vfs_node_t*)-1;
            }
        }
    }
    
    long root_idx = root_dir ? (root_dir - node_pool) : -1;
    long curr_idx = current_dir ? (current_dir - node_pool) : -1;
    
    fwrite(&node_count, sizeof(int), 1, f);
    fwrite(temp_pool, sizeof(vfs_node_t), node_count, f);
    fwrite(&root_idx, sizeof(long), 1, f);
    fwrite(&curr_idx, sizeof(long), 1, f);
    
    fclose(f);
#endif
}

int vfs_load_internal(void) {
#if defined(__STDC_HOSTED__) && __STDC_HOSTED__ == 1
    FILE *f = fopen("kaviraj_disk.img", "rb");
    if (!f) return 0;
    
    fread(&node_count, sizeof(int), 1, f);
    if (node_count <= 0 || node_count > MAX_NODES) {
        fclose(f);
        return 0; // corrupted or empty
    }
    
    fread(node_pool, sizeof(vfs_node_t), node_count, f);
    
    long root_offset, curr_offset;
    fread(&root_offset, sizeof(long), 1, f);
    fread(&curr_offset, sizeof(long), 1, f);
    
    root_dir = (root_offset >= 0 && root_offset < node_count) ? &node_pool[root_offset] : NULL;
    current_dir = (curr_offset >= 0 && curr_offset < node_count) ? &node_pool[curr_offset] : NULL;
    
    // Fix all pointers
    for (int i = 0; i < node_count; i++) {
        long p_off = (long)node_pool[i].parent;
        if (p_off >= 0 && p_off < node_count) {
            node_pool[i].parent = &node_pool[p_off];
        } else {
            node_pool[i].parent = NULL;
        }
        
        for (int c = 0; c < node_pool[i].child_count; c++) {
            long c_off = (long)node_pool[i].children[c];
            if (c_off >= 0 && c_off < node_count) {
                node_pool[i].children[c] = &node_pool[c_off];
            } else {
                node_pool[i].children[c] = NULL;
            }
        }
    }
    
    fclose(f);
    return 1;
#else
    return 0;
#endif
}

void vfs_load(void) {
    vfs_load_internal();
}
