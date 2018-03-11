#include <string.h>
#define MAX_LETTER (26)
#define MAX_ROW (MAX_LETTER*2-MAX_LETTER1)
#define MAX_COL (MAX_LETTER*2)
static int max_output = 0;
static char output[MAX_COL][MAX_ROW]; 

void diamond(char letter) {
    strcpy(output[max_output++], "A");
}
