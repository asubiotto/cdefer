# defer
Golang-like functionality to defer function calls in C.

## Example

```c
#include <cdefer/defer.h>
#include <pthread.h>

pthread_mutex_t m = PTHREAD_MUTEX_INITIALIZER;

int main(void) {
    pthread_mutex_lock(&m);
  
    defer(pthread_mutex_unlock(&m));
    // m is still locked until end of current scope.
    // ...
}
```

To change state, you have to do something like this:

```c
int main(void) {
    __block int i = 3; // needs __block tag :(

    defer(printf("i should be 4: %d\n", i));
    defer(^void() { i++ }());
}
```

## Installation

### Linux

Run

    sudo apt-get install clang && sudo apt-get install libblocksruntime-dev

then proceed to OS X instructons.

### OS X

Simply running

    git clone https://github.com/asubiotto/cdefer.git && cd cdefer && make install

allows you to `#include <cdefer/defer.h>` from anywhere (assuming proper permisions on
`/usr/local/lib` and `/usr/local/include`). To compile, simply pass gcc `-lcdefer`.

### Other

Otherwise, you can just download this source and run `make` which compiles the object code
and you can do whatever.

## Testing

Tests don't currently do anything other than show a working example, but any `.c` files in
`/tests` will run on `make test`.

## Misc

`make uninstall` and `make clean` will clean you right up.
