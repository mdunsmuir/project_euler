#include <stdio.h>

char *rev_string(char *str) {
  int i = 0, j;
  char temp;

  if(!str || str[0] == 0) {
    return str;
  }

  for(j = 0; str[j + 1] != 0; j++);

  while(i < j) {
    temp = str[i];
    str[i] = str[j];
    str[j] = temp;

    i++;
    j--;
  }

  return str;
}

int main(int argc, char **argv) {
  if(argc != 2) {
    puts("must give an argument!");
  } else {
    puts(rev_string(argv[1]));
  }
}
