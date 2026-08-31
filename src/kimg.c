#include "kimg.h"
#include "uart.h"
#include "string.h"

#if defined(__STDC_HOSTED__) && __STDC_HOSTED__ == 1
#include <stdio.h>
#include <stdlib.h>
#endif

void kimg_execute(char *arg) {
    if (!arg || strlen(arg) == 0) {
        uart_puts("Usage: image <url>\n");
        uart_puts("Example: image https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png\n");
        return;
    }

#if defined(__STDC_HOSTED__) && __STDC_HOSTED__ == 1
    uart_puts("\033[36m[*] Fetching and rendering image (this may take a moment)...\033[0m\n");
    
    // Escape the URL (very basic for now)
    char escaped[256];
    size_t e = 0;
    for (size_t i = 0; arg[i] != '\0' && e < 250; i++) {
        if (arg[i] == '"' || arg[i] == '$' || arg[i] == '`' || arg[i] == '\\') {
            escaped[e++] = '\\';
        }
        escaped[e++] = arg[i];
    }
    escaped[e] = '\0';
    
    char pycmd[512];
    snprintf(pycmd, sizeof(pycmd), "python3 /data/data/com.termux/files/home/my_os/tools/kimg.py \"%s\"", escaped);
    
    FILE *fp = popen(pycmd, "r");
    if (fp) {
        char buffer[1024];
        while (fgets(buffer, sizeof(buffer), fp)) {
            uart_puts(buffer);
        }
        pclose(fp);
    } else {
        uart_puts("\033[31m[-] Failed to launch image renderer.\033[0m\n");
    }
#else
    uart_puts("Image rendering requires the host network and python stack.\n");
#endif
}
