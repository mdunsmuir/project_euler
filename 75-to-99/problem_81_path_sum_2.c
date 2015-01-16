#include <stdlib.h>
#include <stdio.h>
#include <string.h>

struct list {
  struct list *next;
  void *data;
};

int list_push(struct list **head, void *data) {
  struct list *temp = malloc(sizeof(struct list));
  if(!temp) return 0; // bad malloc?
  temp->data = data;
  temp->next = *head;
  *head = temp;
  return 1;
}

int list_pop(struct list **head, void **data) {
  struct list *temp;
  if(*head) {
    *data = (*head)->data;
    temp = *head;
    *head = temp->next;
    free(temp);
    return 1;
  } else {
    return 0;
  }
}

int list_length(struct list **head) {
  struct list *temp = *head;
  int i = 0;
  while(temp) {
    i++;
    temp = temp->next;
  }
  return i;
}

int main(int argc, char **argv) {
  struct list *head;
  int len, i, *d;
  void *v;

  for(i = 0; i < 10; i++) {
    d = malloc(sizeof(int));
    *d = i;
    list_push(&head, d);
  }

  len = list_length(&head);
  for(i = 0; i < len; i++) {
    list_pop(&head, &d);
    printf("%d\n", *d);
  }

  printf("%d\n", list_length(&head));

  return 0;
}
