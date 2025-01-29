#include "compiler.h"

CODE_LINE *create_line_command(char *n, char **o) {
}

CODE_LINE *create_line_label(char *n, int a) {
}

CODE_LINE *create_line_op_0A(char *o) {
}

CODE_LINE *create_line_op_1A(char *o, char *a0) {
}

CODE_LINE *create_line_op_2A(char *o, char *a0, char *a1) {
}

CODE_LINE *create_line_op_3A(char *o, char *a0, char *a1, char *a2) {
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
