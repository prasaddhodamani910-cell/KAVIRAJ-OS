#ifndef VFS_H
#define VFS_H

#include "types.h"

#define MAX_NAME_LEN   32
#define MAX_FILE_SIZE  1024
#define MAX_CHILDREN   16
#define MAX_NODES      128

typedef enum {
    FS_FILE,
    FS_DIR
} vfs_type_t;

typedef struct vfs_node {
    char name[MAX_NAME_LEN];
    vfs_type_t type;
    size_t size;
    char data[MAX_FILE_SIZE];
    struct vfs_node *parent;
    struct vfs_node *children[MAX_CHILDREN];
    int child_count;
} vfs_node_t;

void vfs_init(void);
vfs_node_t *vfs_get_root(void);
vfs_node_t *vfs_get_cwd(void);
int vfs_chdir(const char *path);
void vfs_getcwd(char *buf, size_t max_len);
int vfs_mkdir(const char *name);
int vfs_touch(const char *name, const char *initial_data);
int vfs_write_file(const char *name, const char *data);
vfs_node_t *vfs_find(const char *path);
int vfs_remove(const char *name);
int vfs_list_dir(vfs_node_t *dir);
void vfs_sync(void);
void vfs_load(void);

#endif // VFS_H
