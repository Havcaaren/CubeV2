#include <stdio.h>
#include <stdlib.h>

#include "util.h"


int main(const int argc, char** argv) {
    if (argc < 2) {
        printf("No input file\n");
        return -1;
    }

    char *fl = read_file(argv[1]);
    fl = remove_comments(fl);
    fl = remove_empty_lines(fl);

    //printf("%s", fl);

    line_list* lt = process_file_to_list(fl);
    line_list* it = lt;
    while (it->next != NULL) {
        printf("Num: %d, %s\n", it->node->number, it->node->org);
        it = it->next;
    }

    free_list(lt);


    free(fl);
    return 0;
}
