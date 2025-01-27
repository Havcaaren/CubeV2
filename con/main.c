#include <stdio.h>
#include <stdlib.h>

#include "util.h"
#include "compiler.h"

int main(const int argc, char** argv) {
    if (argc < 2) {
        printf("No input file\n");
        return -1;
    }

    char *fl = read_file(argv[1]);
    fl = remove_comments(fl);
    fl = remove_empty_lines(fl);

    printf("%s", fl);

    OP_LINE **A = parse_file(fl);
    int i = 0;
    while (A[i] != NULL) {
        printf("%d, ", A[i]->address);
        if (A[i]->address_label != NULL) {
            printf("%s, ", A[i]->address_label);
        }
        if (A[i]->op != NULL) {
            printf("%s, ", A[i]->op);
        }
        i++;
    }

    free(fl);
    return 0;
}
