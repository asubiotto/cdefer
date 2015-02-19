#include "defer.h"

/**
 * Executes the Clang block passed as argument.
 */
void cleanup_dfunc(void (^*dfunc)(void)) {
    (*dfunc)();
}
