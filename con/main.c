#include <stdio.h>
#include <stdlib.h>

#include "util.h"
#include "compiler.h"

int main(const int argc, char **argv) {
    if (argc < 2) {
        printf("No input file\n");
        return -1;
    }

    char *fl = read_file(argv[1]);
    fl = remove_comments(fl);
    fl = remove_empty_lines(fl);

    char **a = split_to_array(fl);
    int i = 0;
    while (a[i] != NULL) {
        printf("%s\n", a[i]);
        i++;
    }

    PAIR *arr = process_file(a);
    print_code_line(arr);
    free(fl);
    return 0;
}
