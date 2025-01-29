#ifndef COMPILER_H
#define COMPILER_H

#include <stdlib.h>
#include <string.h>

typedef struct op_line {
    int address;
    char *address_label;

    char *op;
    char *arg1;
    char *arg2;
} OP_LINE;

OP_LINE *create_op_line(int a, const char *l, const char *op, const char *a1, const char *a2);

void delete_op_line(OP_LINE *op);

int eval_num(char *num);

OP_LINE **parse_file(char *file);

#endif //COMPILER_H
