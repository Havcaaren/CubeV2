#include "compiler.h"

OP_LINE *create_op_line(const int a, const char *l, const char *op, const char *a1, const char *a2) {
    OP_LINE *o = malloc( sizeof(struct op_line));

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

char **get_parts(char *line) {
    char **parts = calloc(4, sizeof(char*));
    if (line[0] == '.') {
        parts[0] = strtok(line, ":");
    }
    parts[1] = strtok(NULL, " ");
    parts[2] = strtok(NULL, ",");
    parts[3] = strtok(NULL, ",");

    return parts;
}

char *get_label(char *line) {
    if (line[0] == '.') {
        char *index = strtok(line, ":");
        line = strtok(NULL, ":");
        return index;
    }
    return NULL;
}

char **get_ops(char *line) {
    char **toks = calloc(3, sizeof(char*));
    toks[0] = strtok(line, " ");
    toks[1] = strtok(NULL, ",");
    toks[2] = strtok(NULL, ",");
    return toks;
}

OP_LINE **parse_file(char *file) {
    int max = 10;
    int i = 0;
    OP_LINE **lines = calloc(max, sizeof(OP_LINE *));
    char *tok = strtok(file, "\n");
    int address = 0;
    char *label;
    char *op;
    char *arg1;
    char *arg2;
    char *base = file + strlen(tok) + 1;
    while (tok != NULL) {
        char **ops = get_parts(tok);
        label = ops[0];
        op = ops[1];
        arg1 = ops[2];
        arg2 = ops[3];
        lines[i] = create_op_line(address, label, op, arg1, arg2);
        free(ops);
        if (i + 2 == max) {
            lines = realloc(lines, max + (max / 2));
            max += (max / 2);
        }
        i++;
        address++;
        tok = strtok(base, "\n");
        base = tok;
    }
    free(tok);
    lines[i+1] = NULL;
    return lines;
}
