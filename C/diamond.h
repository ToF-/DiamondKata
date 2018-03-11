#include <string.h>
#define MAX_ROW (26)
static int max_output = 0;
static char output[MAX_ROW+1][MAX_ROW]; 

void diamond(char letter) {
    strcpy(output[max_output++], "A");
}
