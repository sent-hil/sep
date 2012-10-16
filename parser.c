#include <stdio.h>

/*identifiers*/
typedef enum {
  NUMBER, STRING
} object_type;

/*basic object that other objects inherit from*/
typedef struct object {
  object_type type;
  long data;
} object;

/*number object*/
typedef struct number_object {
  object obj;
  long data;
} number_object;

/*string object*/
typedef struct string_object {
  object obj;
  char data[1000];
} string_object;

int isdigit(int input);

int isdelimiter(int input) {
  return input == EOF  ||
         input == '\n' ||
         input == ';'  ||
         input == ' '
         ;
}

int isstring(int input) {
  return input == '"';
}

int main () {
  int input;
  int next_input;
  int string_index = 0;
  int index = 0;
  int string_open = 0;
  long num = 0;

  number_object number_obj;
  string_object string_obj;

  while ((input = getc(stdin)) != EOF) {
    if (isdelimiter(input) && num > 0) {
      num = 0;
      printf("%ld\n", number_obj.data);

      for (index = 0; index < string_index; index++) {
        printf("%c\n", string_obj.data[index]);
      }

      string_index = 0;
    }

    if (isdigit(input)) {
      num = (num * 10) + (input - '0');
      number_obj.data = num;
    }

    if (isstring(input)) {
      printf("%c", string_obj.data[string_index]);

      if ((next_input = getc(stdin)) == isstring(input)) {
        string_index = 0;
        string_open  = 0;
        continue;
      }
      ungetc(input, stdin);

      string_obj.data[string_index++] = input;
      printf("", string_obj.data[string_index]);
    }
  }

  return 0;
}
