#include "compiler.h"

CODE_LINE *create_line_command(char *n, char *o) {
    CODE_LINE *s = malloc(sizeof(CODE_LINE));

    s->type = code_line_command;
    s->val.command.name = calloc(strlen(n) + 1, sizeof(char));
    strcpy(s->val.command.name, n);
    if (o != NULL) {
        s->val.command.ops = calloc(strlen(n) + 1, sizeof(char));
        strcpy(s->val.command.ops, o);
    }

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
    strcpy(s->val.instruction.a0, a0);

    return s;
}

CODE_LINE *create_line_op_2A(char *o, char *a0, char *a1) {
    CODE_LINE *s = malloc(sizeof(CODE_LINE));

    s->type = code_line_instruction_2A;
    s->val.instruction.op = calloc(strlen(o) + 1, sizeof(char));
    strcpy(s->val.instruction.op, o);
    s->val.instruction.a0 = calloc(strlen(a0) + 1, sizeof(char));
    strcpy(s->val.instruction.a0, a0);
    s->val.instruction.a1 = calloc(strlen(a1) + 1, sizeof(char));
    strcpy(s->val.instruction.a1, a1);

    return s;
}

CODE_LINE *create_line_op_3A(char *o, char *a0, char *a1, char *a2) {
    CODE_LINE *s = malloc(sizeof(CODE_LINE));

    s->type = code_line_instruction_3A;
    s->val.instruction.op = calloc(strlen(o) + 1, sizeof(char));
    strcpy(s->val.instruction.op, o);
    s->val.instruction.a0 = calloc(strlen(a0) + 1, sizeof(char));
    strcpy(s->val.instruction.a0, a0);
    s->val.instruction.a1 = calloc(strlen(a1) + 1, sizeof(char));
    strcpy(s->val.instruction.a1, a1);
    s->val.instruction.a2 = calloc(strlen(a2) + 1, sizeof(char));
    strcpy(s->val.instruction.a2, a2);

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

char *strip_label(char *l) {
    char *ret = calloc(strlen(l), sizeof(char));

    strcpy(ret, (l + 1));
    ret[strlen(ret) - 1] = '\0';
    free(l);

    return ret;
}

PAIR *process_file(char **fp) {
    int index = 0;
    int max = 10;
    CODE_LINE **arr = calloc(max, sizeof(CODE_LINE *));
    int ptr = 0;
    int address = 0;
    while (fp[ptr] != NULL) {
        char* base = calloc(strlen(fp[ptr]) + 1, sizeof(char));
        strcpy(base, fp[ptr]);
        if (fp[ptr][0] == '.') {
            if (strchr(fp[ptr], ':') != NULL) {
                arr[index] = create_line_label(strip_label(base), address);
                address++;
            } else {
                char *f1 = strtok(base, " ");
                char *f2 = strtok(NULL, "\n");
                arr[index] = create_line_command(f1, f2);
            }
        } else {
            char *op = strtok(base, " ");
            char *f1 = strtok(NULL, " ");
            char *f2 = strtok(NULL, " ");
            char *f3 = strtok(NULL, " ");
            if (f3 != NULL) {
                arr[index] = create_line_op_3A(op, f1, f2, f3);
            } else if (f2 != NULL) {
                arr[index] = create_line_op_2A(op, f1, f2);
            } else if (f1 != NULL) {
                arr[index] = create_line_op_1A(op, f1);
            } else {
                arr[index] = create_line_op_0A(op);
            }
            address++;
        }

        index++;
        ptr++;
        if (index + 1 == max) {
            max += max / 2;
            arr = realloc(arr, sizeof(CODE_LINE *) * max);
        }
    }
    PAIR *a = malloc(sizeof(PAIR));
    a->len = index;
    a->ptr = arr;
    return a;
}

void print_code_line(PAIR *lines) {
    CODE_LINE **it = (CODE_LINE**)(lines->ptr);

    for (int i = 0; i < lines->len; i ++) {
        switch ((*it)->type) {
            case code_line_command: {
                if ((*it)->val.command.ops == NULL) {
                    printf("Command: %s\n", (*it)->val.command.name);
                } else {
                    printf("Command: %s; ops: %s\n", (*it)->val.command.name, (*it)->val.command.ops);
                }
                break;
            }

            case code_line_instruction_0A: {
                printf("Instruction: %s\n", (*it)->val.instruction.op);
                break;
            }

            case code_line_instruction_1A: {
                printf("Instruction: %s; Val: %s\n", (*it)->val.instruction.op, (*it)->val.instruction.a0);
                break;
            }

            case code_line_instruction_2A: {
                printf("Instruction: %s; Val0: %s; Val1: %s\n", (*it)->val.instruction.op,
                        (*it)->val.instruction.a0,
                        (*it)->val.instruction.a1);
                break;
            }

            case code_line_instruction_3A: {
                printf("Instruction: %s; Val0: %s; Val1: %s; Val2: %s\n", (*it)->val.instruction.op,
                        (*it)->val.instruction.a0,
                        (*it)->val.instruction.a1,
                        (*it)->val.instruction.a2);
                break;
            }

            case code_line_label: {
                printf("Label: %s; Add: %d\n", (*it)->val.label.name, (*it)->val.label.address);
                break;
            }
        }
        it++;
    }
}
