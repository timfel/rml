/* module RMLTry */
#include "rml.h"
#include <stdlib.h>
#include <stdio.h>
RML_DEFINE_MODULE("RMLTry")

extern void RML_5finit(void);

void RMLTry_5finit(void)
{
	static int done = 0;
	if( done ) return;
	done = 1;
	RML_5finit();
}