#include "compiler.h"

OP_LINE *create_op_line(const int a, const char *l, const char *op, const char *a1, const char *a2) {
    OP_LINE *o = malloc(sizeof(struct op_line));

    o->address = a;
    if (l != NULL) {
        o->address_label = calloc(strlen(l), sizeof(char));
        strcpy(o->address_label, l);
    }
    if (op != NULL) {
        o->op = calloc(strlen(op), sizeof(char));
        strcpy(o->op, op);
    }
    if (a1 != NULL) {
        o->arg1 = calloc(strlen(a1), sizeof(char));
        strcpy(o->arg1, a1);
    }
    if (a2 != NULL) {
        o->arg2 = calloc(strlen(a2), sizeof(char));
        strcpy(o->arg2, a2);
    }
    return o;
}

void delete_op_line(OP_LINE *op) {
    free(op->address_label);
    free(op->op);
    free(op->arg1);
    free(op->arg2);
    free(op);
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

OP_LINE **parse_file(char **toks) {
    int max = 10;
    int i = 0;
    OP_LINE **lines = calloc(max, sizeof(OP_LINE *));
    int address = 0;
    int j = 0;
    while (toks[j] != NULL) {
        if (toks[j][0] == '.') { // label or com
        }

        i++;
        if (i + 1 == max) {
            max += (max / 2);
            lines = realloc(lines, sizeof(OP_LINE *) * max);
        }
    }
    lines[i + 1] = NULL;
    return lines;
}
