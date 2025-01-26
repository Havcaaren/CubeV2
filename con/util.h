#ifndef CUBE_UTIL_H
#define CUBE_UTIL_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <string.h>

struct line {
    int number;
    char *org;
};

typedef  struct list_node {
    struct line* node;
    struct list_node* next;
} line_list;

char *read_file(const char *fp);

void output_file(const char *fp, size_t len);

char *remove_comments(char *fp);

char *remove_empty_lines(char *fp);

struct line *create_line(int n, const char *o);

line_list* create_node_list(struct line* l);

void append_line_list(line_list* list, struct line* line);

void free_line(struct line* l);

void free_list(line_list* l);


line_list* process_file_to_list(char* f);



#endif //CUBE_UTIL_H
