#include <stdlib.h>
#include <stdio.h>
#include <string.h>

/*
  list stuff
*/

typedef struct {
  int x, y;
} neighbor;

union list_payload {
  int integer;
  char *string;
  neighbor nbr;
  void *ptr;
};

struct list_node {
  struct list_node *next;
  union list_payload payload;
};

typedef struct _list {
  struct list_node *head;
  int length;
} list;

list *new_list() {
  list *l = malloc(sizeof(list));
  if(!l) return l;
  l->head = NULL;
  l->length = 0;
  return l;
}

void list_push(list *l, union list_payload p) {
  struct list_node *node = malloc(sizeof(struct list_node));
  if(!node) return;
  node->payload = p;
  node->next = l->head;
  l->head = node;
  l->length += 1;
}

int list_pop(list *l, union list_payload *p) {
  struct list_node *popped;

  if(l->length == 0) {
    return 0;
  } else {
    popped = l->head;
    l->head = popped->next;
    *p = popped->payload;
    free(popped);
    l->length -= 1;
    return 1;
  }
}

void list_push_int(list *l, int x) {
  union list_payload p;
  p.integer = x;
  list_push(l, p);
}

int list_pop_int(list *l, int *x) {
  union list_payload p;
  if(list_pop(l, &p)) {
    *x = p.integer;
    return 1;
  } else {
    return 0;
  }
}

void list_push_neighbor(list *l, neighbor nbr) {
  union list_payload p;
  p.nbr = nbr;
  list_push(l, p);
}

int list_pop_neighbor(list *l, neighbor *nbr) {
  union list_payload p;
  if(list_pop(l, &p)) {
    *nbr = p.nbr;
    return 1;
  } else {
    return 0;
  }
}

void list_push_string(list *l, char *s) {
  union list_payload p;
  p.string = s;
  list_push(l, p);
}

int list_pop_string(list *l, char **s) {
  union list_payload p;
  if(list_pop(l, &p)) {
    *s = p.string;
    return 1;
  } else {
    return 0;
  }
}

void list_push_void(list *l, void *v) {
  union list_payload p;
  p.ptr = v;
  list_push(l, p);
}

int list_pop_void(list *l, void **v) {
  union list_payload p;
  if(list_pop(l, &p)) {
    *v = p.string;
    return 1;
  } else {
    return 0;
  }
}

int str2int(char *str) {
  int i, len = strlen(str);
  int sum = 0;
  for(i = 0; i < len; i++) {
    sum *= 10;
    sum += str[i] - 48;
  }
  return sum;
}

/*
  loading the matrix
*/

// this is not my best work
int **load_matrix(const char *filename, int *w, int *h) {
  int i, j, k, **matrix;
  char *line_buf, *tok;
  FILE *f = fopen(filename, "r");
  list *bufs = new_list(), *lines = new_list(), *line;

  if(!f) return NULL;

  line_buf = malloc(sizeof(char) * 1024);
  while(fgets(line_buf, 1024, f)) {
    list_push_string(bufs, line_buf); // so we can free it later
    line = new_list();

    tok = strtok(line_buf, ",\n");
    while(tok) {
      list_push_string(line, tok);
      tok = strtok(NULL, ",\n");
    }

    line_buf = malloc(sizeof(char) * 1024);
    list_push_void(lines, line);
  }

  free(line_buf); // the last one we alloc'd won't be used

  // ok, now we're ready to allocate our final arrays
  *w = -1;
  *h = lines->length;
  i = *h - 1;
  while(list_pop_void(lines, &line)) {
    if(*w == -1) {
      *w = line->length;
      matrix = malloc(sizeof(int *) * *w);

      for(k = 0; k < *h; k++) {
        matrix[k] = malloc(sizeof(int) * *h);
      }
    }

    j = *w - 1;
    while(list_pop_string(line, &tok) && j >= 0) {
      matrix[j][i] = str2int(tok);
      j--;
    }

    free(line);
    i--;
  }

  free(lines);

  // free all the line buffers we allocated
  while(list_pop_string(bufs, &line_buf)) {
    free(line_buf);
  }

  free(bufs);

  return matrix;
}

/*
  helper functions
*/

list *neighbors(int x, int y) {
  list *nbrs = new_list();
  list_push_neighbor(nbrs, (neighbor){x + 1, y});
  list_push_neighbor(nbrs, (neighbor){x, y + 1});
  return nbrs;
}

int main(int argc, char **argv) {
  int i, j, w, h, **matrix = load_matrix("p081_matrix.txt", &w, &h);

  for(j = 0; j < h; j++) {
    for(i = 0; i < w; i++) {
      printf("%d ", matrix[i][j]);
    }
    puts("");
  }

  return 0;
}
