#include <stdio.h>

long *stack[1000];
int stack_index = 0;

enum {
  NUMBER, STRING, VARIABLE, LINKEDLIST
};

typedef struct link_list_class {
  int type;
  struct number_class *num_obj;
  struct char_class *char_obj;
  struct link_list_class *first;
  struct link_list_class *last;
} link_list_class;

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

int read_variable_or_string(int input, link_list_class link_list_obj) {
  int index = 0;
  int i = 0;
  char_class char_obj;

  while (input = getc(stdin)) {
    if (is_delimiter(input) || is_quote(input)) {
      for (i = 0; i < index; i++) {
        printf("%c", char_obj.value[i]);
      }

      printf("\n");

      link_list_obj.char_obj = &char_obj;

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

    if (is_delimiter(input)) {
      string[i++] = '\0';
      break;
    }

    string[index++] = input;
  }

  return string;
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

number_class read_number(int first_number) {
  int input;
  number_class num_obj;

  while (input = getc(stdin)) {
    if (isdigit(input)) {
      num_obj.value = (num_obj.value * 10) + (input - '0');
    }

    if (is_delimiter(input)) {
      break;
    }
  }

  printf("%ld\n", num_obj.value);

  return num_obj;
}

int read(void) {
  int input;
  link_list_class link_list_obj;
  link_list_class open_obj;

  input = getc(stdin);

  if (isdigit(input)) {
    link_list_obj.type = NUMBER;
    return_obj = read_number(input);
  }
  else if (is_quote(input)) {
    link_list_obj.type = STRING;
    read_variable_or_string(input, link_list_obj);
  }
  else if (is_open_pair(input)) {
    read_pair(input);
  }
  else {
    link_list_obj.type = VARIABLE;
    read_variable_or_string(input, link_list_obj);
  }

  open_obj.last = &return_obj;
}

int main () {
  while (1) {
    read();
  }

  return 0;
}
