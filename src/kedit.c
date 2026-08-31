#include "kedit.h"
#include "uart.h"
#include "string.h"
#include "vfs.h"

// The global state of our editor
static kedit_state_t E;

// Move the terminal cursor to a specific X, Y coordinate
static void move_cursor(int x, int y) {
    uart_printf("\033[%d;%dH", y + 1, x + 1);
}

// Clear the screen
static void clear_screen(void) {
    uart_puts("\033[2J\033[H");
}

#define TERM_ROWS 24
#define TERM_COLS 80

// Draw the UI (Top bar, bottom bar, and text)
static void kedit_draw(void) {
    uart_puts("\033[?25l"); // Hide cursor while drawing
    clear_screen();

    // 1. Draw Top Bar (Inverted Colors - safe for any terminal width)
    uart_puts("\033[7m"); 
    uart_printf(" Kaviraj Editor | File: %s", E.filename);
    if (E.is_dirty) {
        uart_puts(" [MODIFIED] ");
    } else {
        uart_puts("            ");
    }
    uart_puts("\033[0m\n"); // Reset colors and drop to next line

    // 2. Draw Text Lines (No background color forcing, no padding)
    for (int i = 0; i < 20; i++) {
        int file_row = E.scroll_y + i;
        if (file_row < E.num_lines) {
            uart_puts(E.lines[file_row]);
        } else {
            // Draw a vim-style tilde for empty lines at the end of the file
            uart_puts("\033[90m~\033[0m"); 
        }
        uart_puts("\n");
    }

    // 3. Draw Bottom Status Bar (Inverted Colors)
    uart_puts("\033[7m");
    uart_puts(" ^S Save  |  ^X Exit  |  Arrow Keys to Move ");
    uart_puts("\033[0m");
    
    // 4. Put the cursor in the correct position for typing
    uart_puts("\033[?25h"); // Show cursor
    move_cursor(E.cursor_x, E.cursor_y - E.scroll_y + 1); 
}

// Save the file back to the Virtual Filesystem
static void kedit_save(void) {
    char file_buffer[MAX_FILE_SIZE];
    file_buffer[0] = '\0';
    
    int len = 0;
    for (int i = 0; i < E.num_lines; i++) {
        int line_len = strlen(E.lines[i]);
        if (len + line_len + 1 < MAX_FILE_SIZE) {
            strcat(file_buffer, E.lines[i]);
            strcat(file_buffer, "\n");
            len += line_len + 1;
        }
    }

    vfs_write_file(E.filename, file_buffer);
    E.is_dirty = 0;
}

// Main loop for the editor
void launch_kedit(const char* filename) {
    // Initialize Editor State
    memset(&E, 0, sizeof(kedit_state_t));
    strncpy(E.filename, filename, sizeof(E.filename) - 1);
    E.num_lines = 1;
    
    // Try to load existing file from VFS
    vfs_node_t *node = vfs_find(filename);
    if (node && node->type == FS_FILE) {
        int line = 0, col = 0;
        for (size_t i = 0; i < node->size; i++) {
            char c = node->data[i];
            if (c == '\n') {
                E.lines[line][col] = '\0';
                line++;
                col = 0;
                if (line >= KEDIT_MAX_LINES) break;
            } else {
                if (col < KEDIT_MAX_COLS - 1) {
                    E.lines[line][col++] = c;
                }
            }
        }
        E.num_lines = (line == 0) ? 1 : line;
    }

    // Force block cursor like MS-DOS
    uart_puts("\033[2 q");

    // Main Keyboard Loop
    while (1) {
        kedit_draw();

        char c = uart_getc();

        if (c == 24) { // Ctrl+X
            uart_puts("\033[0m\033[2J\033[H\033[0 q\033[?25h"); // Reset colors, clear screen, restore default cursor
            uart_puts("Exiting kedit...\n");
            break;
        } 
        else if (c == 19) { // Ctrl+S
            kedit_save();
        }
        else if (c == 27) { // Arrow Keys (Escape sequence: ESC [ A)
            char seq1 = uart_getc();
            char seq2 = uart_getc();
            if (seq1 == '[') {
                if (seq2 == 'A' && E.cursor_y > 0) E.cursor_y--;                           // Up
                else if (seq2 == 'B' && E.cursor_y < E.num_lines - 1) E.cursor_y++;        // Down
                else if (seq2 == 'C' && (size_t)E.cursor_x < strlen(E.lines[E.cursor_y])) E.cursor_x++; // Right
                else if (seq2 == 'D' && E.cursor_x > 0) E.cursor_x--;                      // Left

                // Clamp cursor_x to the end of the line if we moved up/down to a shorter line
                if (seq2 == 'A' || seq2 == 'B') {
                    int len = strlen(E.lines[E.cursor_y]);
                    if (E.cursor_x > len) E.cursor_x = len;
                }
            }
        }
        else if (c == '\b' || c == 127) { // Backspace
            if (E.cursor_x > 0) {
                int len = strlen(E.lines[E.cursor_y]);
                for (int i = E.cursor_x - 1; i < len; i++) {
                    E.lines[E.cursor_y][i] = E.lines[E.cursor_y][i + 1];
                }
                E.cursor_x--;
                E.is_dirty = 1;
            }
        }
        else if (c == '\r' || c == '\n') { // Enter key
            if (E.num_lines < KEDIT_MAX_LINES) {
                // Shift lines down
                for (int i = E.num_lines; i > E.cursor_y; i--) {
                    strcpy(E.lines[i], E.lines[i - 1]);
                }
                // Terminate current line at cursor
                char temp[KEDIT_MAX_COLS];
                strcpy(temp, &E.lines[E.cursor_y][E.cursor_x]);
                E.lines[E.cursor_y][E.cursor_x] = '\0';
                
                // Put rest of text on next line
                E.cursor_y++;
                strcpy(E.lines[E.cursor_y], temp);
                E.cursor_x = 0;
                E.num_lines++;
                E.is_dirty = 1;
            }
        }
        else if (c >= 32 && c <= 126) { // Printable characters
            if (E.cursor_x < KEDIT_MAX_COLS - 1) {
                int len = strlen(E.lines[E.cursor_y]);
                // Shift text right to make room
                for (int i = len; i >= E.cursor_x; i--) {
                    E.lines[E.cursor_y][i + 1] = E.lines[E.cursor_y][i];
                }
                E.lines[E.cursor_y][E.cursor_x] = c;
                E.cursor_x++;
                E.is_dirty = 1;
            }
        }

        // Handle scrolling if cursor goes off screen
        if (E.cursor_y < E.scroll_y) {
            E.scroll_y = E.cursor_y;
        } else if (E.cursor_y >= E.scroll_y + 20) {
            E.scroll_y = E.cursor_y - 19;
        }
    }
}
