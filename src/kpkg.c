#include "kpkg.h"
#include "uart.h"
#include "vfs.h"
#include "string.h"
#include "script.h"

#if defined(__STDC_HOSTED__) && __STDC_HOSTED__ == 1
#include <stdio.h>
#include <stdlib.h>
#endif

void kpkg_init(void) {
    // Ensure /bin exists
    if (!vfs_find("/bin")) {
        vfs_mkdir("/bin");
    }
}

void kpkg_execute(char *args) {
#if defined(__STDC_HOSTED__) && __STDC_HOSTED__ == 1
    char cmd[32];
    char pkg[32];
    pkg[0] = '\0';
    
    // Parse args
    int i = 0, j = 0;
    while (args[i] != ' ' && args[i] != '\0' && i < 31) {
        cmd[i] = args[i];
        i++;
    }
    cmd[i] = '\0';
    
    while (args[i] == ' ') i++;
    
    while (args[i] != '\0' && j < 31) {
        pkg[j++] = args[i++];
    }
    pkg[j] = '\0';

    if (strcmp(cmd, "update") == 0) {
        uart_puts("\033[36m[*] Fetching latest package index from pkg.kaviraj.io...\033[0m\n");
        // Simulated delay is in python, we'll just run list invisibly or pretend
        system("python3 /data/data/com.termux/files/home/my_os/tools/kpkg.py list > /dev/null");
        uart_puts("\033[32m[+] Repository updated successfully.\033[0m\n");
    } 
    else if (strcmp(cmd, "list") == 0) {
        uart_puts("\033[36m[*] Available Packages:\033[0m\n");
        uart_puts("    \033[1mNAME          VERSION    DESCRIPTION\033[0m\n");
        uart_puts("    ------------------------------------------------\n");
        
        FILE *fp = popen("python3 /data/data/com.termux/files/home/my_os/tools/kpkg.py list", "r");
        if (fp) {
            char line[128];
            while (fgets(line, sizeof(line), fp)) {
                // Parse pkg|version|desc
                char *p = line;
                char *v = strchr(p, '|');
                if (v) {
                    *v = '\0';
                    v++;
                    char *d = strchr(v, '|');
                    if (d) {
                        *d = '\0';
                        d++;
                        // Remove trailing newline from desc
                        int len = strlen(d);
                        if (len > 0 && d[len-1] == '\n') d[len-1] = '\0';
                        
                        // Fix spacing
                                                uart_puts("    \033[32m");
                        uart_puts(p);
                        for(int sp=0; sp<12-strlen(p); sp++) uart_puts(" ");
                        uart_puts("\033[0m  ");
                        uart_puts(v);
                        for(int sp=0; sp<8-strlen(v); sp++) uart_puts(" ");
                        uart_puts("   ");
                        uart_puts(d);
                        uart_puts("\n");
                    }
                }
            }
            pclose(fp);
        }
    }
    else if (strcmp(cmd, "install") == 0) {
        if (strlen(pkg) == 0) {
            uart_puts("Usage: kpkg install <package>\n");
            return;
        }
        
        uart_printf("\033[36m[*] Downloading package '%s'...\033[0m\n", pkg);
        
        char pycmd[128];
        snprintf(pycmd, sizeof(pycmd), "python3 /data/data/com.termux/files/home/my_os/tools/kpkg.py install %s", pkg);
        
        FILE *fp = popen(pycmd, "r");
        if (fp) {
            char line[256];
            if (fgets(line, sizeof(line), fp)) {
                if (strncmp(line, "OK", 2) == 0) {
                    // Read the rest as script content
                    char script_content[1024];
                    script_content[0] = '\0';
                    while (fgets(line, sizeof(line), fp)) {
                        strcat(script_content, line);
                    }
                    
                    // Write to /bin/<pkg>.kav
                    char filename[64];
                    strcpy(filename, pkg);
                    strcat(filename, ".kav");
                    
                    // Temporarily chdir to /bin since vfs_write_file only operates on CWD
                    vfs_node_t *saved_cwd = vfs_get_cwd();
                    vfs_chdir("/bin");
                    vfs_write_file(filename, script_content);
                    
                    // We must expose a way to set cwd back if vfs_chdir doesn't accept absolute easily, 
                    // or just cd /
                    vfs_chdir("/");
                    if (strcmp(saved_cwd->name, "/") != 0) {
                        // try to cd back (simple 1 level for now)
                        vfs_chdir(saved_cwd->name);
                    }
                    
                    uart_printf("\033[32m[+] Installed %s successfully to /bin/%s\033[0m\n", pkg, filename);
                } else {
                    uart_puts("\033[31m[-] Error: Package not found in repository.\033[0m\n");
                }
            }
            pclose(fp);
        }
    }
    else {
        uart_puts("Usage:\n");
        uart_puts("  kpkg update          - Update package lists\n");
        uart_puts("  kpkg list            - List available packages\n");
        uart_puts("  kpkg install <pkg>   - Install a package\n");
    }
#else
    uart_puts("kpkg requires network stack (Hosted Mode).\n");
#endif
}

int kpkg_try_run(const char *cmd, const char *args) {
    // Check if /bin/cmd.kav exists
    char path[64];
    strcpy(path, "/bin/");
    strcat(path, cmd);
    strcat(path, ".kav");
    
    vfs_node_t *node = vfs_find(path);
    if (node && node->type == FS_FILE) {
        // We found an installed package!
        // Run it
        script_run_file(path);
        return 1;
    }
    return 0;
}
