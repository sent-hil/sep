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

int isdelimiter(int input) {
  return input == EOF  ||
         input == '\n' ||
         input == ';'  ||
         input == ' '
         ;
}

int main () {
  int input;
  long num = 0;

  while ((input = getc(stdin)) != EOF) {
    if (isdelimiter(input) && num > 0) {
      printf("%ld\n", num);
      num = 0;
    }

    if (isdigit(input)) {
      num = (num * 10) + (input - '0');
    }
  }
}
