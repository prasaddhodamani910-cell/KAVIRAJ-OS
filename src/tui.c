#include "tui.h"
#include "uart.h"
#include "vfs.h"
#include "string.h"
#include "process.h"

// Terminal size assumption
#define TUI_WIDTH 80
#define TUI_HEIGHT 24

static int active_pane = 0; // 0 = Files, 1 = Tasks
static int selected_file = 0;
static vfs_node_t *current_dir;
static vfs_node_t *dir_nodes[64];
static int num_nodes = 0;

extern process_t proc_table[];

static void draw_box(int x, int y, int w, int h, const char *title, int is_active) {
    const char *col = is_active ? "\033[1;36m" : "\033[1;30m";
    uart_puts(col);
    
    // Top border
    uart_printf("\033[%d;%dH╭", y, x);
    for (int i = 1; i < w - 1; i++) uart_puts("─");
    uart_puts("╮");
    
    // Title
    uart_printf("\033[%d;%dH %s ", y, x + 2, title);
    
    // Sides
    for (int i = 1; i < h - 1; i++) {
        uart_printf("\033[%d;%dH│", y + i, x);
        uart_printf("\033[%d;%dH│", y + i, x + w - 1);
    }
    
    // Bottom border
    uart_printf("\033[%d;%dH╰", y + h - 1, x);
    for (int i = 1; i < w - 1; i++) uart_puts("─");
    uart_puts("╯");
    
    uart_puts("\033[0m");
}

static void update_nodes() {
    num_nodes = 0;
    if (current_dir->parent != NULL) {
        dir_nodes[num_nodes++] = NULL; // Represents ".."
    }
    for (size_t i = 0; i < current_dir->size && num_nodes < 64; i++) {
        dir_nodes[num_nodes++] = current_dir->children[i];
    }
    if (selected_file >= num_nodes) selected_file = num_nodes - 1;
    if (selected_file < 0) selected_file = 0;
}

static void draw_files(int x, int y, int w, int h) {
    for (int i = 0; i < h - 2; i++) {
        uart_printf("\033[%d;%dH", y + 1 + i, x + 1);
        for (int j = 0; j < w - 2; j++) uart_puts(" ");
    }
    
    int start = 0;
    if (selected_file > h - 4) {
        start = selected_file - (h - 4);
    }
    
    for (int i = 0; i < h - 2 && (start + i) < num_nodes; i++) {
        int idx = start + i;
        uart_printf("\033[%d;%dH", y + 1 + i, x + 2);
        
        if (idx == selected_file && active_pane == 0) {
            uart_puts("\033[7m"); // Invert
        }
        
        if (dir_nodes[idx] == NULL) {
            uart_puts(".. (UP)              ");
        } else {
            char entry[64];
            if (dir_nodes[idx]->type == FS_DIR) {
                strcpy(entry, "[DIR] ");
            } else {
                strcpy(entry, "      ");
            }
            strcat(entry, dir_nodes[idx]->name);
            uart_puts(entry);
        }
        
        if (idx == selected_file && active_pane == 0) {
            uart_puts("\033[0m");
        }
    }
}

static void draw_tasks(int x, int y, int w, int h) {
    for (int i = 0; i < h - 2; i++) {
        uart_printf("\033[%d;%dH", y + 1 + i, x + 1);
        for (int j = 0; j < w - 2; j++) uart_puts(" ");
    }
    
    uart_printf("\033[%d;%dH  \033[1mPID  NAME       MEM\033[0m", y + 1, x + 1);
    
    int row = 2;
    for (int i = 0; i < 16 && row < h - 2; i++) {
        if (proc_table[i].state != PROC_DEAD) {
            uart_printf("\033[%d;%dH  %d    %s     %dK", 
                y + row, x + 1, 
                proc_table[i].pid, 
                proc_table[i].name, 
                proc_table[i].memory_bytes / 1024);
            row++;
        }
    }
}

void tui_launch(void) {
    current_dir = vfs_get_cwd();
    active_pane = 0;
    selected_file = 0;
    
    uart_puts("\033[2J\033[?25l"); // clear, hide cursor
    
    while (1) {
        update_nodes();
        
        // Draw Header
        uart_puts("\033[H\033[7m Kaviraj OS TUI Desktop (Tab: Switch | Enter: Open | q: Quit) \033[0m\033[K");
        
        draw_box(1, 2, 40, 22, "Filesystem Tree", active_pane == 0);
        draw_files(1, 2, 40, 22);
        
        draw_box(42, 2, 38, 22, "Task Monitor", active_pane == 1);
        draw_tasks(42, 2, 38, 22);
        
        char c = uart_getc();
        if (c == 'q' || c == 'Q') {
            break;
        } else if (c == '\t') {
            active_pane = !active_pane;
        } else if (c == 27) { // ESC sequence
            char seq1 = uart_getc();
            char seq2 = uart_getc();
            if (seq1 == '[') {
                if (seq2 == 'A') { // UP
                    if (active_pane == 0 && selected_file > 0) selected_file--;
                } else if (seq2 == 'B') { // DOWN
                    if (active_pane == 0 && selected_file < num_nodes - 1) selected_file++;
                }
            }
        } else if (c == '\n' || c == '\r') {
            if (active_pane == 0 && num_nodes > 0) {
                if (dir_nodes[selected_file] == NULL) {
                    current_dir = current_dir->parent;
                    selected_file = 0;
                } else if (dir_nodes[selected_file]->type == FS_DIR) {
                    current_dir = dir_nodes[selected_file];
                    selected_file = 0;
                } else {
                    // It's a file, launch kedit
                    extern void launch_kedit(const char*);
                    
                    vfs_node_t *tmp = dir_nodes[selected_file];
                    char path[128];
                    path[0] = '\0';
                    
                    while(tmp && tmp != vfs_find("/")) {
                        char old[128];
                        strcpy(old, path);
                        strcpy(path, "/");
                        strcat(path, tmp->name);
                        strcat(path, old);
                        tmp = tmp->parent;
                    }
                    if (strlen(path) == 0) strcpy(path, "/");
                    
                    launch_kedit(path);
                    
                    // Re-clear screen and hide cursor when coming back from kedit
                    uart_puts("\033[2J\033[?25l"); 
                }
            }
        }
    }
    
    uart_puts("\033[0m\033[2J\033[H\033[?25h"); // Reset, clear, show cursor
}
