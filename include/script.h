#ifndef SCRIPT_H
#define SCRIPT_H

void script_init(void);
void script_set_var(const char *name, const char *value);
const char* script_get_var(const char *name);
void script_expand_vars(const char *input, char *output);
int script_execute_line(char *line);
int script_run_file(const char *filename);

#endif // SCRIPT_H
