#include "ai.h"
#include "process.h"
#include "vfs.h"
#include "uart.h"
#include "string.h"
#include "vfs.h"

#if defined(__STDC_HOSTED__) && __STDC_HOSTED__ == 1
#include <stdio.h>
#include <stdlib.h>
#endif

static int query_count = 0;
int cloud_connected = 0;

void ai_init(void) {
    query_count = 0;
    cloud_connected = 0;

#if defined(__STDC_HOSTED__) && __STDC_HOSTED__ == 1
    // Check if API key is configured
    FILE *fp = popen("python3 /data/data/com.termux/files/home/my_os/tools/ai_bridge.py --check 2>/dev/null", "r");
    if (fp) {
        char buf[32];
        if (fgets(buf, sizeof(buf), fp)) {
            if (strncmp(buf, "configured", 10) == 0) {
                cloud_connected = 1;
            }
        }
        pclose(fp);
    }
#endif
}

static void print_ai_banner(void) {
    uart_puts("\033[2J\033[H");
    uart_puts("\033[1;35m    ╭────────────────────────────────────────────────────────────╮\033[0m\n");
    uart_puts("\033[1;35m    │\033[0m\033[1;37m                 KAVIRAJ CLOUD AI ASSISTANT                 \033[0m\033[1;35m│\033[0m\n");
    uart_puts("\033[1;35m    │\033[0m\033[35m           Smart Knowledge Engine for Kaviraj OS            \033[0m\033[1;35m│\033[0m\n");
    uart_puts("\033[1;35m    ├────────────────────────────────────────────────────────────┤\033[0m\n");
    uart_puts("\033[1;35m    │\033[0m  \033[1;33mDeveloper\033[0m : Prasad Dhodamani                              \033[1;35m│\033[0m\n");
    if (cloud_connected) {
        uart_puts("\033[1;35m    │\033[0m  \033[1;32mMode\033[0m      : \033[1;32m● PREMIUM\033[0m (Google Gemini LLM)                 \033[1;35m│\033[0m\n");
    } else {
        uart_puts("\033[1;35m    │\033[0m  \033[1;32mMode\033[0m      : \033[1;32m● READY\033[0m (Free Engine)                       \033[1;35m│\033[0m\n");
    }
    uart_puts("\033[1;35m    │\033[0m  \033[1;36mCommands\033[0m  : /help, /status, /clear, /exit                 \033[1;35m│\033[0m\n");
    uart_puts("\033[1;35m    ╰────────────────────────────────────────────────────────────╯\033[0m\n\n");

    uart_puts("\033[1;36m╭─\033[1;35m[ \033[1;37mKaviraj AI\033[1;35m ]\033[0m\n");
    uart_puts("\033[1;36m╰─\033[1;32m❯ \033[0mHello! I'm ready to answer your questions.\n");
    uart_puts("      Ask me about \033[1mscience, math, history, coding, definitions\033[0m, and more!\n\n");
}

#if defined(__STDC_HOSTED__) && __STDC_HOSTED__ == 1
// External access to proc_table and MAX_PROCESSES for context
extern process_t proc_table[];

static int call_neural_bridge(const char *prompt) {
    // Escape special shell characters
    char escaped[512];
    size_t e = 0;
    for (size_t i = 0; prompt[i] != '\0' && e < 500; i++) {
        char c = prompt[i];
        if (c == '"' || c == '\\' || c == '$' || c == '`' || c == '!' || c == '(' || c == ')') {
            escaped[e++] = '\\';
        }
        escaped[e++] = c;
    }
    escaped[e] = '\0';
    
    // Gather system context
    char cwd_buf[64];
    vfs_getcwd(cwd_buf, sizeof(cwd_buf));
    
    char sys_context[512];
    int ctx_len = snprintf(sys_context, sizeof(sys_context), "Current Directory: %s\nRunning Tasks:\n", cwd_buf);
    
    for (int i = 0; i < 16; i++) {
        if (proc_table[i].state != PROC_DEAD) {
            const char *state_str = "RUNNING";
            if (proc_table[i].state == PROC_SLEEPING) state_str = "SLEEPING";
            if (proc_table[i].state == PROC_ZOMBIE) state_str = "ZOMBIE";
            ctx_len += snprintf(sys_context + ctx_len, sizeof(sys_context) - ctx_len, 
                "- PID %d: %s (Mem: %d KB) [%s]\n", 
                proc_table[i].pid, proc_table[i].name, proc_table[i].memory_bytes / 1024, state_str);
            if (ctx_len >= (int)sizeof(sys_context) - 64) break;
        }
    }

    char cmd[2048];
    snprintf(cmd, sizeof(cmd),
        "python3 /data/data/com.termux/files/home/my_os/tools/ai_bridge.py --context \"%s\" \"%s\" 2>/dev/null",
        sys_context, escaped);

    FILE *fp = popen(cmd, "r");
    if (!fp) return 0;

    char buffer[512];
    int got_output = 0;
    while (fgets(buffer, sizeof(buffer), fp)) {
        uart_puts(buffer);
        got_output = 1;
    }
    pclose(fp);
    return got_output;
}


extern void execute_command(char *cmd_buffer);
extern int kernel_capture_mode;
extern char kernel_capture_buffer[16384];
extern int kernel_capture_idx;

void ai_auto_mode(const char *prompt) {


    char current_prompt[2048];
    strncpy(current_prompt, prompt, sizeof(current_prompt) - 1);
    
    uart_printf("\033[1;36m[AI Agent]\033[0m Goal: %s\n", current_prompt);

    int loops = 0;
    while (loops < 10) {
        char escaped[1024];
        size_t e = 0;
        for (size_t i = 0; current_prompt[i] != '\0' && e < 1000; i++) {
            char c = current_prompt[i];
            if (c == '"' || c == '\\' || c == '$' || c == '`' || c == '!' || c == '(' || c == ')') {
                escaped[e++] = '\\';
            }
            escaped[e++] = c;
        }
        escaped[e] = '\0';

        char cmd[2048];
        snprintf(cmd, sizeof(cmd), "python3 /data/data/com.termux/files/home/my_os/tools/ai_bridge.py --auto \"%s\" 2>/dev/null", escaped);

        FILE *fp = popen(cmd, "r");
        if (!fp) return;

        char buffer[1024];
        int is_cmd = 0;
        char exec_cmd[8192] = "";
        int exec_cmd_len = 0;

        while (fgets(buffer, sizeof(buffer), fp)) {
            if (strncmp(buffer, "__AUTO_EXEC_CMD__:", 18) == 0) {
                is_cmd = 1;
                strncpy(exec_cmd, buffer + 18, sizeof(exec_cmd) - 1);
                exec_cmd_len = strlen(exec_cmd);
            } else if (is_cmd) {
                if (exec_cmd_len + strlen(buffer) < sizeof(exec_cmd) - 1) {
                    strcpy(exec_cmd + exec_cmd_len, buffer);
                    exec_cmd_len += strlen(buffer);
                }
            } else {
                uart_puts(buffer);
            }
        }
        if (is_cmd && exec_cmd_len > 0 && exec_cmd[exec_cmd_len-1] == '\n') {
            exec_cmd[exec_cmd_len-1] = '\0';
        }
        pclose(fp);

        if (is_cmd) {
            uart_printf("\n\033[1;33m🤖 Agent Executing:\033[0m %s\n", exec_cmd);
            
            kernel_capture_mode = 1;
            kernel_capture_idx = 0;
            
            execute_command(exec_cmd);
            
            kernel_capture_mode = 0;
            
            if (kernel_capture_idx > 0) {
                snprintf(current_prompt, sizeof(current_prompt), "Command ran successfully. Output:\n%s", kernel_capture_buffer);
            } else {
                snprintf(current_prompt, sizeof(current_prompt), "Command ran successfully with no output.");
            }
            loops++;
        } else {
            break;
        }
    }
    
    if (loops >= 10) {
        uart_puts("\033[33m[!] Agent halted (reached maximum autonomous iterations).\033[0m\n");
    }
}

#endif


#if !defined(__STDC_HOSTED__) || __STDC_HOSTED__ == 0
void ai_auto_mode(const char *prompt) {
    uart_puts("Agent Mode requires Hosted Mode.\n");
}
#endif

void ai_process_query(const char *query) {
    if (!query || query[0] == '\0') {
        uart_puts("Please type a question or prompt.\n");
        return;
    }

    query_count++;

#if defined(__STDC_HOSTED__) && __STDC_HOSTED__ == 1
    if (call_neural_bridge(query)) {
        return;
    }
#endif

    // Bare-metal fallback
    uart_printf("Query: '%s'\n", query);
    uart_puts("Running in embedded mode. Connect to network and set API key for full AI.\n");
}

void ai_start_interactive(void) {
    print_ai_banner();

    char prompt_buf[256];

    while (1) {
        uart_puts("\n\033[1;36m╭─\033[1;32m[ \033[1;37mUser\033[1;32m ]\033[0m\n");
        uart_puts("\033[1;36m╰─\033[1;35m❯\033[0m ");

        size_t idx = 0;
        while (1) {
            char c = uart_getc();
            if (c == '\r' || c == '\n') {
                uart_puts("\r\n");
                prompt_buf[idx] = '\0';
                break;
            } else if (c == '\b' || c == 127) {
                if (idx > 0) {
                    idx--;
                    uart_puts("\b \b");
                }
            } else if (c >= 32 && c <= 126) {
                if (idx < sizeof(prompt_buf) - 1) {
                    prompt_buf[idx++] = c;
                    uart_putc(c);
                }
            }
        }

        if (strlen(prompt_buf) == 0) {
            continue;
        }

        // Session commands
        if (strcmp(prompt_buf, "/exit") == 0 || strcmp(prompt_buf, "/quit") == 0 || strcmp(prompt_buf, "exit") == 0) {
            uart_puts("\033[1;36mKaviraj AI:\033[0m Goodbye! Returning to Kaviraj OS shell.\n\n");
            break;
        }

        if (strcmp(prompt_buf, "/clear") == 0 || strcmp(prompt_buf, "clear") == 0) {
            print_ai_banner();
#if defined(__STDC_HOSTED__) && __STDC_HOSTED__ == 1
            system("python3 /data/data/com.termux/files/home/my_os/tools/ai_bridge.py --clear-memory > /dev/null 2>&1");
#endif
            continue;
        }

        
        if (strcmp(prompt_buf, "/setup") == 0) {
            uart_puts("\n\033[1;36m╭────────────────────────────────────────────────────────────╮\033[0m\n");
            uart_puts("\033[1;36m│\033[0m              \033[1;33mKaviraj AI - Neural Link Setup\033[0m                \033[1;36m│\033[0m\n");
            uart_puts("\033[1;36m│\033[0m          All API keys are \033[1;32m100% FREE\033[0m — no payment ever!     \033[1;36m│\033[0m\n");
            uart_puts("\033[1;36m╰────────────────────────────────────────────────────────────╯\033[0m\n\n");
            uart_puts("Pick any ONE of these free AI providers:\n\n");
            uart_puts("\033[1;33m Option A: Google Gemini (Recommended)\033[0m\n");
            uart_puts("   1. Go to \033[1;34mhttps://aistudio.google.com/app/apikey\033[0m\n");
            uart_puts("   2. Sign in with Google > Click 'Create API Key'\n");
            uart_puts("   3. Copy the key\n\n");
            uart_puts("\033[1;33m Option B: Groq Cloud (Ultra Fast)\033[0m\n");
            uart_puts("   1. Go to \033[1;34mhttps://console.groq.com/keys\033[0m\n");
            uart_puts("   2. Sign up free > Click 'Create API Key'\n");
            uart_puts("   3. Copy the key\n\n");
            uart_puts("\033[1;33m Option C: OpenRouter (Many Free Models)\033[0m\n");
            uart_puts("   1. Go to \033[1;34mhttps://openrouter.ai/keys\033[0m\n");
            uart_puts("   2. Sign up free > Click 'Create Key'\n");
            uart_puts("   3. Copy the key\n\n");
            uart_puts("\033[1mFinal Step:\033[0m Type \033[1;32m/key\033[0m followed by your key and press Enter!\n");
            uart_puts("\033[2mExample: /key AIzaSy...\033[0m\n\n");
            continue;
        }

        if (strcmp(prompt_buf, "/help") == 0) {
            uart_puts("\033[1;35m─── Kaviraj AI Help ───\033[0m\n");
            uart_puts("  Ask me anything — I'm a real AI powered by Google Gemini!\n\n");
            uart_puts("  \033[1mExample questions:\033[0m\n");
            uart_puts("    • Explain quantum physics in simple terms\n");
            uart_puts("    • Write a Python script to sort a list\n");
            uart_puts("    • What is the spelling of 17?\n");
            uart_puts("    • Translate 'good morning' to Japanese\n");
            uart_puts("    • Write a short poem about the moon\n");
            uart_puts("    • What is Women's Day?\n\n");
            uart_puts("  \033[1mCommands:\033[0m\n");
            uart_puts("    /setup      — View the easy guide to connect Kaviraj AI\n");
            uart_puts("    /key <KEY>  — Set your free Gemini API key\n");
            uart_puts("    /status     — Check connection status\n");
            uart_puts("    /clear      — Clear screen\n");
            uart_puts("    /exit       — Return to OS shell\n\n");
            continue;
        }

        if (strncmp(prompt_buf, "/key ", 5) == 0 || strncmp(prompt_buf, "/key\t", 5) == 0) {
#if defined(__STDC_HOSTED__) && __STDC_HOSTED__ == 1
            char kcmd[384];
            // Extract key (trim whitespace)
            const char *key = prompt_buf + 5;
            while (*key == ' ' || *key == '\t') key++;
            // Use single quotes to avoid shell interpretation of special chars
            snprintf(kcmd, sizeof(kcmd),
                "python3 /data/data/com.termux/files/home/my_os/tools/ai_bridge.py --set-key '%s'", key);
            int ret = system(kcmd);
            // system() returns the exit status shifted; WEXITSTATUS extracts it
            if (ret == 0) {
                cloud_connected = 1;
                uart_puts("\n\033[1;32mKaviraj AI is now connected! Ask me anything.\033[0m\n");
            }
#else
            uart_puts("Key setup only available in hosted (Termux) mode.\n");
#endif
            uart_puts("\n");
            continue;
        }

        if (strcmp(prompt_buf, "/status") == 0 || strcmp(prompt_buf, "/stats") == 0) {
#if defined(__STDC_HOSTED__) && __STDC_HOSTED__ == 1
            system("python3 /data/data/com.termux/files/home/my_os/tools/ai_bridge.py --status");
            uart_printf("  Queries this session: %d\n\n", query_count);
#else
            uart_printf("Session Queries: %d | Mode: Embedded\n\n", query_count);
#endif
            continue;
        }

        // Process query through the AI engine
        uart_puts("\033[1;36m╭─\033[1;35m[ \033[1;37mKaviraj AI\033[1;35m ]\033[0m\n");
        uart_puts("\033[1;36m╰─\033[1;32m❯ \033[0m");
        ai_process_query(prompt_buf);
        uart_puts("\n");
    }
}
