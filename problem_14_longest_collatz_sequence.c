#include <stdio.h>

#define MAX_MEMOIZE 1000000

int lengths[MAX_MEMOIZE];

int collatz_length(int start) {
  long int n = start;
  int length = 1;

  while(n != 1) {
    if(n < MAX_MEMOIZE && lengths[n] != -1) {
      length += lengths[n];
      break;

    } else {
      length++;

      if(n % 2 == 0) {
        n = n / 2;
      } else {
        n = 3 * n + 1;
      }
    } // end memoized check
  } // end while

  if(start < MAX_MEMOIZE) { lengths[start] = length - 1; }
  return length;
}

int main(int argc, char **argv) {
  int i;
  for(i = 0; i < MAX_MEMOIZE; i++) { lengths[i] = -1; }


  int len, max_start, max_len = 0;
  for(i = 1; i <= 1000000; i++) {
    len = collatz_length(i);

    if(len > max_len) { 
      max_len = len; 
      max_start = i;
    }
  }

  printf("%d\n", max_start);
}
