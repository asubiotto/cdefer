# defer
Golang-like functionality to defer function calls in C.

For example:
```c
#include <defer.h>
#include <pthread.h>

pthread_mutex_t m = PTHREAD_MUTEX_INITIALIZER;

int main(void) {
  pthread_mutex_lock(&m)
  
  defer(pthread_mutex_unlock(&m))
  // m is still locked until end of current scope.
}
```
