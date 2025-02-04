#ifndef CUBE_UTIL_H
#define CUBE_UTIL_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <string.h>
#include <stdbool.h>

char *read_file(const char *fp);

void output_file(const char *fp, size_t len);

char *remove_comments(char *fp);

char *remove_empty_lines(char *fp);

char *split_prep(char *fp);

char **split_to_array(char *fp);

#endif //CUBE_UTIL_H
