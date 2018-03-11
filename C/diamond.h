#include <string.h>
#define MAX_LETTER (26)
#define MAX_ROW (MAX_LETTER*2-1)
#define MAX_COL (MAX_LETTER*2)
static int max_output = 0;
static char output[MAX_COL][MAX_ROW]; 

void diamond(char letter) {
    max_output = 0;
    if (letter == 'A')
        strcpy(output[max_output++], "A");
    else {
        strcpy(output[max_output++], " A ");
        strcpy(output[max_output++], "B B");
        strcpy(output[max_output++], output[0]);
    
    }
}
