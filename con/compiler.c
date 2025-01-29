#include "compiler.h"

CODE_LINE *create_line_command(char *n, char *o) {
    CODE_LINE *s = malloc(sizeof(CODE_LINE));

    s->type = code_line_command;
    s->val.command.name = calloc(strlen(n) + 1, sizeof(char));
    strcpy(s->val.command.name, n);
    s->val.command.ops = calloc(strlen(n) + 1, sizeof(char));
    strcpy(s->val.command.ops, o);

    return s;
}

CODE_LINE *create_line_label(char *n, int a) {
    CODE_LINE *s = malloc(sizeof(CODE_LINE));

    s->type = code_line_label;
    s->val.label.name = calloc(strlen(n) + 1, sizeof(char));
    strcpy(s->val.label.name, n);
    s->val.label.address = a;

    return s;
}

CODE_LINE *create_line_op_0A(char *o) {
    CODE_LINE *s = malloc(sizeof(CODE_LINE));

    s->type = code_line_instruction_0A;
    s->val.instruction.op = calloc(strlen(o) + 1, sizeof(char));
    strcpy(s->val.instruction.op, o);

    return s;
}

CODE_LINE *create_line_op_1A(char *o, char *a0) {
    CODE_LINE *s = malloc(sizeof(CODE_LINE));

    s->type = code_line_instruction_1A;
    s->val.instruction.op = calloc(strlen(o) + 1, sizeof(char));
    strcpy(s->val.instruction.op, o);
    s->val.instruction.a0 = calloc(strlen(a0) + 1, sizeof(char));
    strcpy(s->val.instruction.a0, o);

    return s;
}

CODE_LINE *create_line_op_2A(char *o, char *a0, char *a1) {
    CODE_LINE *s = malloc(sizeof(CODE_LINE));

    s->type = code_line_instruction_2A;
    s->val.instruction.op = calloc(strlen(o) + 1, sizeof(char));
    strcpy(s->val.instruction.op, o);
    s->val.instruction.a0 = calloc(strlen(a0) + 1, sizeof(char));
    strcpy(s->val.instruction.a0, o);
    s->val.instruction.a1 = calloc(strlen(a1) + 1, sizeof(char));
    strcpy(s->val.instruction.a1, o);

    return s;
}

CODE_LINE *create_line_op_3A(char *o, char *a0, char *a1, char *a2) {
    CODE_LINE *s = malloc(sizeof(CODE_LINE));

    s->type = code_line_instruction_3A;
    s->val.instruction.op = calloc(strlen(o) + 1, sizeof(char));
    strcpy(s->val.instruction.op, o);
    s->val.instruction.a0 = calloc(strlen(a0) + 1, sizeof(char));
    strcpy(s->val.instruction.a0, o);
    s->val.instruction.a1 = calloc(strlen(a1) + 1, sizeof(char));
    strcpy(s->val.instruction.a1, o);
    s->val.instruction.a2 = calloc(strlen(a2) + 1, sizeof(char));
    strcpy(s->val.instruction.a2, o);

    return s;
}

int eval_num(char *num) {
    int base = 10;
    int ret = 0;
    if (num[0] == '0' && num[1] == 'x') {
        base = 16;
    } else if (num[0] == '0' && num[1] == 'b') {
        base = 2;
    }
    int ptr = 1;
    for (int len = strlen(num); len != 2; --len) {
        ret += num[len] * base;
        base = base << ptr;
        ptr++;
    }


    return ret;
}
