#include <stdio.h>
#include "diamond.h"

int main(int argc, char *argv[]) {
    diamond('A');
    for(int row=0; row < max_output; row ++)
        puts(output[row]);
    return 0;
}
