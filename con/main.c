#include <stdio.h>
#include <stdlib.h>

#include "util.h"


int main(void) {
    char *fl = read_file("../input.txt");
    fl = remove_comments(fl);
    fl = remove_empty_lines(fl);


    printf("%s", fl);

    free(fl);
    return 0;
}
