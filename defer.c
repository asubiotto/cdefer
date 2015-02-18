#include "defer.h"

/**
 * Executes the block Clang block argument.
 */
void cleanup_dfunc(void (^*dfunc)(void)) {
    (*dfunc)();
}
