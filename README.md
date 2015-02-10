# defer
Golang-like functionality to defer function calls in C.

For example:
```c
#include <defer.h>
#include <pthread.h>

pthread_mutex_t m;

int main(void) {
  pthread_mutex_init(&m, NULL)
  pthread_mutex_lock(&m)
  
  defer(pthread_mutex_unlock(&m))
  // m is still locked until end of current scope.
}
```
