#include "util.h"

char *read_file(const char *fp) {
    FILE *f = fopen(fp, "r");
    fseek(f, 0, SEEK_END);
    const long int len = ftell(f) + 1;
    fseek(f, 0, SEEK_SET);

    char *buffer = calloc(len, sizeof(char));
    fread(buffer, sizeof(char), len, f);
    buffer[len] = '\0';
    return buffer;
}

char *remove_comments(char *fp) {
    char *buffer = calloc(strlen(fp), sizeof(char));
    int j = 0;
    for (int i = 0; fp[i] != '\0'; i++) {
        if (fp[i] == ';') {
            for (; fp[i] != '\n'; i++) {
            }
        }
        buffer[j] = fp[i];
        j++;
    }
    free(fp);
    return buffer;
}

char *remove_empty_lines(char *fp) {
    char *buffer = calloc(strlen(fp), sizeof(char));
    char *buffer1 = calloc(strlen(fp), sizeof(char));
    char *buffer2 = calloc(strlen(fp), sizeof(char));
    int j = 0;
    for (int i = 0; fp[i] != '\0'; i++) {
        if (fp[i] == ' ') {
            for (; fp[i + 1] == ' '; i++) {
            }
        }
        buffer[j] = fp[i];
        j++;
    }
    j = 0;
    for (int i = 0; buffer[i] != '\0'; i++) {
        if (buffer[i] == '\n') {
            for (; buffer[i + 1] == '\n'; i++) {
            }
        }
        buffer1[j] = buffer[i];
        j++;
    }

    j = 0;
    for (int i = 0; buffer1[i] != '\0'; i++) {
        if ((buffer1[i - 1] == ':')) {
            for (; buffer1[i] == ' ' || buffer1[i] == '\n'; i++) {
            }
        }
        buffer2[j] = buffer1[i];
        j++;
    }
    free(fp);
    free(buffer);
    free(buffer1);
    return buffer2;
}
