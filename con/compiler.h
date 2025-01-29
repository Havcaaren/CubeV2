#ifndef COMPILER_H
#define COMPILER_H

#include <stdlib.h>
#include <string.h>

enum code_line_type {
    code_line_command,
    code_line_label,
    code_line_instruction_0A,
    code_line_instruction_1A,
    code_line_instruction_2A,
    code_line_instruction_3A
};

typedef struct {
    enum code_line_type type;

    union {
        struct {
            char *name;
            char *ops;
        } command;

        struct {
            char *name;
            int address;
        } label;

        struct {
            char *op;
            char *a0;
            char *a1;
            char *a2;
        } instruction;
    } val;
} CODE_LINE;

CODE_LINE *create_line_command(char *n, char *o);

CODE_LINE *create_line_label(char *n, int a);

CODE_LINE *create_line_op_0A(char *o);

CODE_LINE *create_line_op_1A(char *o, char *a0);

CODE_LINE *create_line_op_2A(char *o, char *a0, char *a1);

CODE_LINE *create_line_op_3A(char *o, char *a0, char *a1, char *a2);

int eval_num(char *num);

CODE_LINE **process_file(char **fp);

#endif //COMPILER_H
