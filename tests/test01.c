#include <stdio.h>

#include "defer.h"

int main(void) {
    puts("First");
    defer(puts("Eighth"));
    defer(puts("Seventh"));
    defer(puts("Sixth"));
    defer(puts("Fifth"));
    defer(puts("Fourth"));
    defer(puts("Third"));
    puts("Second");
    return 0;
}
