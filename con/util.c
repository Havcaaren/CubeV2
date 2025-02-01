#include "util.h"

char *read_file(const char *fp) {
    FILE *f = fopen(fp, "r");
    fseek(f, 0, SEEK_END);
    const long int len = ftell(f) + 1;
    fseek(f, 0, SEEK_SET);

    char *buffer = calloc(len, sizeof(char));
    memset(buffer, ' ', len);
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
    memset(buffer, ' ', strlen(fp));
    char *buffer1 = calloc(strlen(fp), sizeof(char));
    memset(buffer1, ' ', strlen(fp));
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

    free(fp);
    free(buffer);
    return buffer1;
}

char *split_prep(char *fp) {
    for (int i = 0; fp[i] != '\0'; ++i) {
        if (fp[i] == ':' || fp[i] == ',') {
            fp[i] = ' ';
        }
    }
    return fp;
}

char **split_to_array(char *fp) {
    int i = 0;
    int max = 100;
    char **arr = calloc(max, sizeof(char *));

    fp = split_prep(fp);
    char *tok = strtok(fp, "\n");
    while (tok != NULL) {
        arr[i] = calloc(strlen(tok) + 1, sizeof(char));
        bool can = false;
        for (int j = 0; tok[j] != '\0'; ++j) {
            if (tok[j] != ' ') {
                can = true;
                break;
            }
        }
        if (can == true) {
            strcpy(arr[i], tok);
            i++;
        }
        if (i + 1 == max) {
            max += (max / 2);
            arr = realloc(arr, sizeof(char *) * max);
        }

        tok = strtok(NULL, "\n");
    }
    arr[i] = NULL;
    return arr;
}
