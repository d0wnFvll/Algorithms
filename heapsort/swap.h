#ifndef SWAP_H_
#define SWAP_H_

#define swap(a, b) \
    do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while(0)

#endif // SWAP_H_

