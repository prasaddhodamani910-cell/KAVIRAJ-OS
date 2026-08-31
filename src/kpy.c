#include "kpy.h"
#include "uart.h"
#include "vfs.h"
#include "string.h"

#if defined(__STDC_HOSTED__) && __STDC_HOSTED__ == 1
#include <stdio.h>
#include <stdlib.h>
#endif

void kpy_execute(const char *filename) {
    if (!filename || strlen(filename) == 0) {
        uart_puts("Usage: python <filename.py> OR python -c \"<code>\"\n");
        return;
    }

    if (strncmp(filename, "-c ", 3) == 0) {
        const char *code = filename + 3;
        while (*code == ' ') code++;
        int start = 0;
        int end = strlen(code) - 1;
        if (code[start] == '"' || code[start] == '\'') {
            char quote = code[start];
            start++;
            if (end >= start && code[end] == quote) {
                end--;
            }
        }
        
#if defined(__STDC_HOSTED__) && __STDC_HOSTED__ == 1
        FILE *fp = fopen(".kaviraj_host_exec.py", "w");
        if (fp) {
            for (int i = start; i <= end; i++) {
                fputc(code[i], fp);
            }
            fclose(fp);
            
            uart_puts("\033[35m[Kaviraj Python Engine] Executing inline script...\033[0m\n");
            FILE *pfp = popen("python3 .kaviraj_host_exec.py 2>&1", "r");
            if (pfp) {
                char pbuf[512];
                while (fgets(pbuf, sizeof(pbuf), pfp)) {
                    uart_puts(pbuf);
                }
                int ret = pclose(pfp);
                if (ret != 0) {
                    uart_puts("\033[31m[Kaviraj Python Engine] Process exited with error.\033[0m\n");
                }
            }
            remove(".kaviraj_host_exec.py");
        } else {
            uart_puts("\033[31m[-] Error: Failed to bridge inline script.\033[0m\n");
        }
#else
        uart_puts("Inline Python execution requires Hosted Mode.\n");
#endif
        return;
    }

    // Attempt to locate the script in the Virtual Filesystem
    vfs_node_t *node = vfs_find(filename);
    if (!node) {
        uart_printf("\033[31m[-] Error: Python script '%s' not found.\033[0m\n", filename);
        return;
    }
    if (node->type != FS_FILE) {
        uart_printf("\033[31m[-] Error: '%s' is a directory, not a python file.\033[0m\n", filename);
        return;
    }

#if defined(__STDC_HOSTED__) && __STDC_HOSTED__ == 1
    // Write VFS file to a physical host file to bridge execution
    FILE *fp = fopen(".kaviraj_host_exec.py", "w");
    if (fp) {
        fputs(node->data, fp);
        fclose(fp);
        
        uart_printf("\033[35m[Kaviraj Python Engine] Executing %s...\033[0m\n", filename);
        
        // Execute natively and capture output
        FILE *pfp = popen("python3 .kaviraj_host_exec.py 2>&1", "r");
        if (pfp) {
            char pbuf[512];
            while (fgets(pbuf, sizeof(pbuf), pfp)) {
                uart_puts(pbuf);
            }
            int ret = pclose(pfp);
            if (ret != 0) {
                uart_puts("\033[31m[Kaviraj Python Engine] Process exited with error.\033[0m\n");
            }
        }
        
        // Cleanup bridge file
        remove(".kaviraj_host_exec.py");
    } else {
        uart_puts("\033[31m[-] Error: Failed to bridge VFS to host executor.\033[0m\n");
    }
#else
    uart_puts("Python execution requires the Native OS Bridge (Hosted Mode).\n");
#endif
}
