#include <stdio.h>

/*define various identifiers*/
typedef enum {
  NUMBER
} object_type;

/*define the object that will hold the parser stuff*/
typedef struct object {
  object_type type;
  long data;
} object;

/*write number to stdout*/
object write(object obj) {
  printf("[%ld, %d]\n\n", obj.data, obj.type);
}

int main () {
  int input;
  int input_index;
  long num = 0;

  object input_object;

  while ((input = getc(stdin)) != EOF || input != '\n') {
    if (isdigit(input)) {
      num = (num * 10) + (input - '0');
    }

    if (input == ' ' || input == '\n') {
      input_object.type = NUMBER;
      input_object.data = num;

      write(input_object);

      num = 0;
    }
  }

  return 0;
}
