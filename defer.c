#include <stdio.h>

void cleanup_dfunc(void (^*dfunc)(void)) {
    (*dfunc)();
}

#define _CONCAT_(x, y) x##y
#define CONCAT(x, y) _CONCAT_(x, y)

/*
 * CONCAT(__dfpt_, __COUNTER__) is a pseudo-unique variable name as it
 * concatenates __dfpt_ with a counter (preprocessor variable).
 * TODO(asubiotto): Find a better way to do this.
 */
#define defer(func)                                                            \
    void (^CONCAT(__dfpt_, __COUNTER__))(void) __attribute__((cleanup(cleanup_dfunc))) = ^ {(func);}

/*
 * TODO(asubiotto): This is a temporary demonstration. Clean up and put in a .h
 * file as well as write tests.
 */
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
