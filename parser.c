#include <stdio.h>

/*define various identifiers*/
typedef enum {
  NUMBER
} object_type;


/*define the object that will hold the parser stuff*/
typedef struct object {
  object_type type;
  int data;
} object;

/*write number to stdout*/
object write(object obj) {
  printf("[%d, %d]\n\n", obj.data-'0', obj.type);
}

int main () {
  int input;
  object input_object;

  while ((input = getc(stdin)) != EOF || input != '\n') {
    if (isdigit(input)) {
      input_object.type = NUMBER;
      input_object.data = input;

      write(input_object);
    }
  }
  return 0;
}
