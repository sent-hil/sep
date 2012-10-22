#include <stdio.h>

char output[1000];

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

void parse(char *input) {
  int index        = 0;
  int input_index  = 0;
  int word_index   = 0;
  int output_index = 0;
  char word[100];
  extern char output[];

  while (input[input_index] != '\0') {
    if (is_keys(input[input_index])) {
      if (word_index > 0) {
        for (index = 0; index <= word_index; index++) {
          output[output_index] = word[index];
          output_index++;
        }

        word_index = 0;
      }

      output[output_index] = input[input_index];
      output_index++;
    }
    else if (is_delimiter(input[input_index])) {
      output[output_index] = input[input_index];
      output_index++;

      if (word_index > 0) {
        for (index = 0; index <= word_index; index++) {
          output[output_index] = word[index];
          output_index++;
        }

        word_index = 0;
      }
    }
    else {
      word[word_index] = input[input_index];
      word_index++;
    }

    input_index++;
  }
}

int main () {
  int index = 0;
  extern char output[];

  parse("(define)");

  while (output[index] != '\0') {
    printf("%c", output[index]);
    index++;
  }

  return 0;
}
