#include <stdlib.h>
#include <stdio.h>

int main()
{ 
   char *z = "1";
   double zr = atof(z);
   perror("bugger!");
   printf("%f", zr);
}
