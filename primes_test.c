#include "stdio.h"

// from primes.c
extern int *build_sieve(int max);
extern int *is_prime(int num);
extern void *free_sieve();

#define MAX 10000000

int main(int argc, char **argv) {
  if(!build_sieve(MAX)) {
    puts("error: couldn't allocate sieve");
  }

  free_sieve();
  return 0;
}
