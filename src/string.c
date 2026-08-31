#include "string.h"

size_t kstrlen(const char *s) {
    size_t len = 0;
    while (s && s[len] != '\0') {
        len++;
    }
    return len;
}

char *kstrcat(char *dest, const char *src) {
    if (!dest || !src) return dest;
    char *ret = dest;
    while (*dest) {
        dest++;
    }
    while ((*dest++ = *src++))
        ;
    return ret;
}

int kstrcmp(const char *s1, const char *s2) {
    if (!s1 || !s2) return -1;
    while (*s1 && (*s1 == *s2)) {
        s1++;
        s2++;
    }
    return *(const unsigned char *)s1 - *(const unsigned char *)s2;
}

int kstrncmp(const char *s1, const char *s2, size_t n) {
    if (!s1 || !s2) return -1;
    while (n && *s1 && (*s1 == *s2)) {
        s1++;
        s2++;
        n--;
    }
    if (n == 0) return 0;
    return *(const unsigned char *)s1 - *(const unsigned char *)s2;
}

char *kstrcpy(char *dest, const char *src) {
    if (!dest || !src) return dest;
    char *ret = dest;
    while ((*dest++ = *src++))
        ;
    return ret;
}

char *kstrncpy(char *dest, const char *src, size_t n) {
    if (!dest || !src) return dest;
    char *ret = dest;
    while (n && (*dest++ = *src++)) {
        n--;
    }
    while (n--) {
        *dest++ = '\0';
    }
    return ret;
}

void *kmemset(void *s, int c, size_t n) {
    if (!s) return s;
    unsigned char *p = (unsigned char *)s;
    while (n--) {
        *p++ = (unsigned char)c;
    }
    return s;
}

void *kmemcpy(void *dest, const void *src, size_t n) {
    if (!dest || !src) return dest;
    unsigned char *d = (unsigned char *)dest;
    const unsigned char *s = (const unsigned char *)src;
    while (n--) {
        *d++ = *s++;
    }
    return dest;
}

char *kstrstr(const char *haystack, const char *needle) {
    if (!haystack || !needle) return NULL;
    if (*needle == '\0') return (char *)haystack;

    for (; *haystack != '\0'; haystack++) {
        if (*haystack == *needle) {
            const char *h = haystack;
            const char *n = needle;
            while (*h && *n && (*h == *n)) {
                h++;
                n++;
            }
            if (*n == '\0') {
                return (char *)haystack;
            }
        }
    }
    return NULL;
}

char *kstrchr(const char *s, int c) {
    if (!s) return NULL;
    while (*s != '\0') {
        if (*s == (char)c) return (char *)s;
        s++;
    }
    if ((char)c == '\0') return (char *)s;
    return NULL;
}

int ktolower(int c) {
    if (c >= 'A' && c <= 'Z') {
        return c + ('a' - 'A');
    }
    return c;
}

void kstr_tolower(char *dest, const char *src) {
    if (!dest || !src) return;
    while (*src != '\0') {
        *dest++ = (char)ktolower((unsigned char)*src++);
    }
    *dest = '\0';
}
