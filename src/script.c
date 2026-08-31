#include "script.h"
#include "uart.h"
#include "string.h"
#include "vfs.h"

#define MAX_VARS 32
#define VAR_NAME_LEN 32
#define VAR_VAL_LEN 128

static char var_names[MAX_VARS][VAR_NAME_LEN];
static char var_values[MAX_VARS][VAR_VAL_LEN];
static int num_vars = 0;

// Need this to call back into the main shell execution
extern void execute_command(char *cmd_buffer);

void script_init(void) {
    num_vars = 0;
    script_set_var("OS", "KavirajOS");
    script_set_var("USER", "root");
}

void script_set_var(const char *name, const char *value) {
    for (int i = 0; i < num_vars; i++) {
        if (strcmp(var_names[i], name) == 0) {
            strncpy(var_values[i], value, VAR_VAL_LEN - 1);
            var_values[i][VAR_VAL_LEN - 1] = '\0';
            return;
        }
    }
    if (num_vars < MAX_VARS) {
        strncpy(var_names[num_vars], name, VAR_NAME_LEN - 1);
        var_names[num_vars][VAR_NAME_LEN - 1] = '\0';
        strncpy(var_values[num_vars], value, VAR_VAL_LEN - 1);
        var_values[num_vars][VAR_VAL_LEN - 1] = '\0';
        num_vars++;
    }
}

const char* script_get_var(const char *name) {
    for (int i = 0; i < num_vars; i++) {
        if (strcmp(var_names[i], name) == 0) {
            return var_values[i];
        }
    }
    return "";
}

void script_expand_vars(const char *input, char *output) {
    int i = 0, o = 0;
    while (input[i] != '\0') {
        if (input[i] == '$') {
            i++;
            char vname[VAR_NAME_LEN];
            int v = 0;
            while ((input[i] >= 'A' && input[i] <= 'Z') || 
                   (input[i] >= 'a' && input[i] <= 'z') || 
                   (input[i] >= '0' && input[i] <= '9') || 
                   input[i] == '_') {
                if (v < VAR_NAME_LEN - 1) {
                    vname[v++] = input[i];
                }
                i++;
            }
            vname[v] = '\0';
            const char *val = script_get_var(vname);
            int k = 0;
            while (val[k] != '\0') {
                output[o++] = val[k++];
            }
        } else {
            output[o++] = input[i++];
        }
    }
    output[o] = '\0';
}

int script_execute_line(char *line) {
    // Basic trimming
    while (*line == ' ' || *line == '\t') line++;
    if (*line == '\0' || *line == '#') return 0; // Comment or empty

    char expanded[256];
    script_expand_vars(line, expanded);

    // Simple variable assignment: VAR=VALUE
    int is_assignment = 0;
    for (int i = 0; expanded[i] != '\0'; i++) {
        if (expanded[i] == '=' && i > 0 && expanded[i-1] != '=' && expanded[i+1] != '=') {
            // Might be an assignment. Let's check if there are spaces before =
            int space_before = 0;
            for(int j=0; j<i; j++) if(expanded[j] == ' ') space_before = 1;
            if (!space_before && expanded[0] != 'i' && expanded[1] != 'f') { // Very basic check to avoid 'if' commands
                expanded[i] = '\0';
                script_set_var(expanded, expanded + i + 1);
                return 0;
            }
        }
    }

    // Simple one-line logic: if ARG1 == ARG2 then CMD
    if (expanded[0] == 'i' && expanded[1] == 'f' && expanded[2] == ' ') {
        char arg1[64], arg2[64], cmd_to_run[128];
        int pos = 3;
        int a1 = 0;
        while (expanded[pos] != ' ' && expanded[pos] != '\0' && a1 < 63) {
            arg1[a1++] = expanded[pos++];
        }
        arg1[a1] = '\0';
        
        while (expanded[pos] == ' ') pos++;
        if (expanded[pos] == '=' && expanded[pos+1] == '=') pos += 2;
        else if (expanded[pos] == '!' && expanded[pos+1] == '=') pos += 2;
        // Simplified: only supporting == for now
        
        while (expanded[pos] == ' ') pos++;
        int a2 = 0;
        while (expanded[pos] != ' ' && expanded[pos] != '\0' && a2 < 63) {
            arg2[a2++] = expanded[pos++];
        }
        arg2[a2] = '\0';
        
        while (expanded[pos] == ' ') pos++;
        if (expanded[pos] == 't' && expanded[pos+1] == 'h' && expanded[pos+2] == 'e' && expanded[pos+3] == 'n') {
            pos += 4;
            while (expanded[pos] == ' ') pos++;
            strcpy(cmd_to_run, expanded + pos);
            
            if (strcmp(arg1, arg2) == 0) {
                execute_command(cmd_to_run);
            }
            return 0;
        }
    }

    // Normal command
    execute_command(expanded);
    return 0;
}

int script_run_file(const char *filename) {
    vfs_node_t *node = vfs_find(filename);
    if (!node || node->type != FS_FILE) {
        uart_printf("\033[31msh: cannot open %s\033[0m\n", filename);
        return -1;
    }
    
    char line[256];
    int pos = 0;
    for (size_t i = 0; i <= node->size; i++) {
        if (i == node->size || node->data[i] == '\n') {
            line[pos] = '\0';
            if (pos > 0) {
                script_execute_line(line);
            }
            pos = 0;
        } else if (node->data[i] != '\r') {
            if (pos < 255) line[pos++] = node->data[i];
        }
    }
    return 0;
}
