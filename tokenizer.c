#include <stdio.h>

int is_keys(int input) {
  return input == '(' ||
         input == ')'
         ;
}

int is_delimiter(int input) {
  return input == '\n' ||
         input == ' '
         ;
}

char parse(char *input) {
  int input_index = 0;
  int current_index = 0;
  int output_index = 0;
  char current[10];
  char output[10];

  while (input_index < sizeof(input)) {
    if (input[input_index] == '\0') {
      break;
    }

    if (is_keys(input[input_index])) {
      output[output_index] = input[input_index];
      output_index++;
    }
    else if (is_delimiter(input[input_index])) {
      output[output_index] = input[input_index];
      output_index++;
    }
    else {
      current[current_index] = input[input_index];
      current_index++;
    }

    input_index++;
  }

  return *output;
}

int main () {
  char output[10];
  *output = parse("()");

  return 0;
}
