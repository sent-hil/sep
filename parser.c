#include <stdio.h>

long *stack[1000];
int stack_index = 0;

enum {
  NUMBER, STRING, VARIABLE
};

typedef struct basic_class {
  int type;
  int value;
} basic_class;

typedef struct number_class {
  int type;
  long value;
} number_class;

typedef struct char_class {
  int type;
  char value[100];
} char_class;

typedef struct pair_class {
  struct basic_class left;
  struct basic_class right;
} pair_class;

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

int read_variable_or_string(int input, char_class char_obj) {
  int index = 0;
  int i = 0;

  while (input = getc(stdin)) {
    if (is_delimiter(input) || is_quote(input)) {
      for (i = 0; i < index; i++) {
        printf("%c", char_obj.value[i]);
      }

      printf("\n");

      break;
    }

    char_obj.value[index++] = input;
  }
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

int read_number(int first_number, number_class num_obj) {
  int input;
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
  number_class number_obj;
  char_class char_obj;

  input = getc(stdin);

  if (isdigit(input)) {
    number_obj.type = NUMBER;
    read_number(input, number_obj);
  }
  else if (is_quote(input)) {
    char_obj.type = STRING;
    read_variable_or_string(input, char_obj);
  }
  else if (is_open_pair(input)) {
    read_pair(input);
  }
  else {
    char_obj.type = VARIABLE;
    read_variable_or_string(input, char_obj);
  }
}

int main () {
  while (1) {
    read();
  }

  return 0;
}
