#ifndef KEDIT_H
#define KEDIT_H

#include "types.h"

#define KEDIT_MAX_LINES 100
#define KEDIT_MAX_COLS  128

// This struct holds the entire state of our text editor
typedef struct {
    char filename[64];                  // The name of the file being edited
    char lines[KEDIT_MAX_LINES][KEDIT_MAX_COLS]; // The actual text data in memory
    int num_lines;                      // Total number of lines currently used
    int cursor_x;                       // Cursor's X position (column)
    int cursor_y;                       // Cursor's Y position (row)
    int scroll_y;                       // How far down the screen has scrolled
    int is_dirty;                       // 1 if file was changed but not saved, 0 if safe to exit
} kedit_state_t;

// Starts the text editor for a specific file
void launch_kedit(const char* filename);

#endif // KEDIT_H
