#ifndef DEFER_H
#define DEFER_H

#define _CONCAT_(x, y) x##y
#define CONCAT(x, y) _CONCAT_(x, y)

/**
 * CONCAT(__df_, __COUNTER__) is a pseudo-unique variable name as it
 * concatenates __df_ with a counter (preprocessor variable).
 */
#define defer(func)                             \
    void (^CONCAT(__df_, __COUNTER__))(void)    \
        __attribute__((cleanup(cleanup_dfunc))) \
            __attribute__((unused)) = ^{ (func); }

void cleanup_dfunc(void (^*dfunc)(void));

#endif // DEFER_H
