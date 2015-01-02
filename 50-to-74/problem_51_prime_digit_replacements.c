#include "stdlib.h"
#include "stdio.h"
#include "math.h"

// from primes.c
extern int *build_sieve(int max);
extern int *is_prime(int num);
extern void *free_sieve();

#define MAX_PRIME 1000000

// conversion from int to str and back

int str2int(char *str) {
  int result;
  sscanf(str, "%d", &result);
  return result;
}

#define BUF_LEN (log10(MAX_PRIME) + 2)

char *int2str(int num) {
  char *result = malloc(BUF_LEN * sizeof(char));
  sprintf(result, "%d", num);
  return result;
}

// permuting masks

typedef struct _digit_tree {
  int *digit;
  struct _digit_tree *left, *right;
} digit_tree;

int **digit_masks(int n_digits) {
  int n_masks = pow(2, n_digits);
  int **masks = malloc(n_masks * sizeof(int *));
}

void make_digit_tree(int depth, digit_tree *tree) {
  if(depth > 0) {
    tree -> left = malloc(sizeof(digit_tree));
    tree -> left -> digit = 0;
    tree -> right = malloc(sizeof(digit_tree));
    tree -> right -> digit = 1;

}

// main function

int main(int argc, char **argv) {
  if(!build_sieve(MAX_PRIME)) {
    puts("memory allocation failure");
    return 0;
  }



  return 0;
}
