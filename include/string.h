#ifndef STRING_H
#define STRING_H

#include "types.h"

size_t kstrlen(const char *s);
int kstrcmp(const char *s1, const char *s2);
int kstrncmp(const char *s1, const char *s2, size_t n);
char *kstrcpy(char *dest, const char *src);
char *kstrcat(char *dest, const char *src);
char *kstrncpy(char *dest, const char *src, size_t n);
void *kmemset(void *s, int c, size_t n);
void *kmemcpy(void *dest, const void *src, size_t n);
char *kstrstr(const char *haystack, const char *needle);
char *kstrchr(const char *s, int c);
int ktolower(int c);
void kstr_tolower(char *dest, const char *src);

// Kernel alias macros
#define strlen       kstrlen
#define strcmp       kstrcmp
#define strncmp      kstrncmp
#define strcpy       kstrcpy
#define strncpy      kstrncpy
#define strcat       kstrcat
#define memset       kmemset
#define memcpy       kmemcpy
#define strstr       kstrstr
#define strchr       kstrchr
#define tolower      ktolower
#define str_tolower  kstr_tolower

#endif // STRING_H
