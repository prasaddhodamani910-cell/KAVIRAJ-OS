#ifndef KPKG_H
#define KPKG_H

void kpkg_init(void);
void kpkg_execute(char *args);
int kpkg_try_run(const char *cmd, const char *args);

#endif // KPKG_H
