#include <stdio.h>

long *stack[1000];
int stack_index = 0;

typedef struct basic_object {
  char type[10];
  int value;
} basic_object;

typedef struct number_object {
  char type[10];
  long value;
} number_object;

typedef struct pair_object {
  struct basic_object left;
  struct basic_object right;
} pair_object;

int is_open_pair(int input) {
  return input == '(';
}

int is_close_pair(int input) {
  return input == ')';
}

int is_quote(int input) {
  return input == '"';
}

int is_delimiter(int input) {
  return input == EOF  ||
         input == '\n' ||
         input == ' '
         ;
}

int read_keyword_or_variable(int input) {
  char input_array[100];
}

int read_pair(int input) {
  char string[1000];
  int index = 0;
  int i = 0;

  while (input = getc(stdin)) {
    if (is_close_pair(input)) {
      for (i = 0; i < index; i++) {
        printf("%c", string[i]);
      }
      printf("\n");

      break;
    }

    string[index++] = input;
  }
}

int read_string(int input) {
  char string[1000];
  int index = 0;
  int i = 0;

  while (input = getc(stdin)) {
    if (is_quote(input)) {
      for (i = 0; i < index; i++) {
        printf("%c", string[i]);
      }
      printf("\n");

      break;
    }

    string[index++] = input;
  }
}

int read_number(int first_number) {
  int input;
  number_object num_obj;
  extern long *stack[];

  /*stack[stack_index] = &num_obj;*/
  num_obj.value = (first_number - '0');

  while (input = getc(stdin)) {
    if (isdigit(input)) {
      num_obj.value = (num_obj.value * 10) + (input - '0');
    }

    if (is_delimiter(input)) {
      break;
    }
  }

  printf("%ld\n", num_obj.value);
}

int read(void) {
  int input;

  input = getc(stdin);

  if (isdigit(input)) {
    read_number(input);
  }
  else if (is_quote(input)) {
    read_string(input);
  }
  else if (is_open_pair(input)) {
    read_pair(input);
  }
  else {
    read_keyword_or_variable(input);
  }
}

int main () {
  while (1) {
    read();
  }

  return 0;
}
