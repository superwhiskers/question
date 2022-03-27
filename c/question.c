#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// initial character array size
size_t INITIAL_ARRAY_SIZE = 2000;

// simple join-string-by-delimiter utility function in c
// the use of strcpy and strcat is safe here because the destination buffer is guaranteed to be big
// enough for the string to fit in.
char* join(char** sarr, int sarr_count, char* delim) {
  // allocate initial memory buffer so it can be freed
  char* result = malloc(1);
  char* result_tmp;
  size_t delimsize = sizeof(delim);

  for (int i = 0; i < sarr_count; i++) {
    result_tmp = result;
    if (i == sarr_count - 1) {
      result = malloc(sizeof(result_tmp) + sizeof(sarr[i]));
      strcpy(result, result_tmp);
      strcat(result, sarr[i]);

    } else {
      result = malloc(sizeof(result_tmp) + sizeof(sarr[i]) + delimsize);
      strcpy(result, result_tmp);
      strcat(result, sarr[i]);
      strcat(result, delim);
    }

    free(result_tmp);
  }

  return result;
}

// implementation of the question function in c
char* question(char* prompt, char** valid, int valid_count) {
  char* input = malloc(INITIAL_ARRAY_SIZE * sizeof(char));
  size_t read = 0;
  char* joined_valid;
  if (valid_count != 0) {
    joined_valid = join(valid, valid_count, ", ");
  }

  for (;;) {
    printf("%s\n", prompt);
    if (valid_count != 0) {
      printf("(%s)", joined_valid);
    }
    printf(": ");

    read = getline(&input, &INITIAL_ARRAY_SIZE, stdin);

    if (read == EOF) {
      putchar('\n');
      break;
    }

    input[read - 1] = '\0';

    if (read == 0) {
      break;
    }

    for (int i = 0; i < valid_count; i++) {
      if (strcmp(valid[i], input) == 0) {
        goto _question_end;
      }
    }

    printf("\"%s\" is not a valid answer\n", input);
  }

// don't shame me for using goto here. this is the only valid use case for it
_question_end:
  if (joined_valid != 0) {
    free(joined_valid);
  }
  return input;
}

int main() {
  free(question("foo", (char*[]){ "bar", "baz" }, 2));
  return 0;
}
