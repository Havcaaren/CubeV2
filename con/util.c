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

struct line * create_line(const int n, const char *o) {
    struct line* l = malloc(sizeof(struct line));
    l->number = n;
    l->org = calloc(strlen(o), sizeof(char));
    strcpy(l->org, o);
    return l;
}

line_list* create_node_list(struct line* l) {
    line_list* list = malloc(sizeof(line_list));

    list->node = l;
    list->next = NULL;

    return list;
}

void append_line_list(line_list* list, struct line* line) {
    line_list* it = list;
    while (it->next != NULL) {
        it = it->next;
    }
    it->next = create_node_list(line);
}

void free_line(struct line* l) {
    free(l->org);
    free(l);
}

void free_list(line_list* l) {
    if (l->next == NULL) {
        free_line(l->node);
        free(l);
        return;
    }
    free_line(l->node);
    free_list(l->next);
    free(l);
}



line_list* process_file_to_list(char* f) {
    const char* tok = strtok(f, "\n");
    int i = 0;
    line_list* lt = create_node_list(create_line(i, tok));
    tok = strtok(NULL, "\n");
    while (tok != NULL) {
        append_line_list(lt, create_line(i, tok));
        i++;
        tok = strtok(NULL, "\n");
    }
    return lt;
}
