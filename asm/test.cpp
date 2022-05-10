#include <stdio.h>

extern "C" int find_word (int a, int b, int c);

int main () {
    // rprintf ("%%");
    printf ("%d", find_word (1, 2, 3));
}