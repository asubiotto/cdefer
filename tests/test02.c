#include <stdio.h>
#include <stdlib.h>

#include "defer.h"

int main(void) {
    __block int *i = malloc(sizeof(int));
    *i = 3;
    char *t = "Fifth";

    puts("First");
    defer(free(i));
    defer(puts("Sixth"));
    defer(printf("should be 4 i: %d\n", *i));
    defer(puts(t));
    defer(puts("Fourth"));
    defer(^void() { (*i)++; }());
    defer(printf("should be 3 i: %d\n", *i));
    defer(puts("Third"));
    puts("Second");
    return 0;
}
