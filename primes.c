#include "stdlib.h"

int sieve_max;
int *sieve = NULL;

int *build_sieve(int max) {
  // if we've already built a sieve, free it to make room
  if(sieve) {
    free(sieve);
  }

  sieve = calloc(max - 1, sizeof(int));
  if(!sieve) {
    return sieve;
  }

  sieve_max = max;

  int i = 2;
  while(i <= max / 2) {
    // if this has already been marked as non-prime, ignore it
    if(!sieve[i - 1]) {
      for(int mul = 2; i * mul <= max; mul++) {
        sieve[(mul * i) - 1] = 1;
      }
    }

    i++;
  }

  return sieve;
}

int is_prime(int num) {
  if(num > 1 && num <= sieve_max && sieve) {
    return !sieve[num - 1];
  } else {
    return 0;
  }
}

void free_sieve() {
  free(sieve);
}
