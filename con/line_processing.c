#include "line_processing.h"

struct line * create_line(int n, char *o) {
    struct line* l = malloc(sizeof(struct line));
    l->number = n;
    l->org = calloc(strlen(o), sizeof(char));
    strcpy(l->org, o);
    return l;
}

void delete_line(struct line *l) {
    free(l->org);
    free(l);
}

struct line ** add_lines(char *fp) {
    struct line** lines = calloc(1, sizeof(struct line));

    char* l = strtok(fp, "\n");
    while (l != nullptr) {
        
    }

    return lines;
}
