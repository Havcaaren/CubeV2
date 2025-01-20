#ifndef LINE_PROCESSING_H
#define LINE_PROCESSING_H

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

struct line {
    int number;

    char *org;
};

struct line *create_line(int n, char *o);

void delete_line(struct line *l);

struct line **add_lines(char *fp);

#endif //LINE_PROCESSING_H
