#include <stdio.h>

#include "defer.h"

int main(void) {
    puts("First");
    defer(puts("order."));
    defer(puts("LIFO"));
    defer(puts("in"));
    defer(puts("executed"));
    defer(puts("are"));
    defer(puts("These"));
    puts("Second");
    return 0;
}
