/* module FCode */
#include "rml.h"
#include <stdlib.h>
#include <stdio.h>
RML_DEFINE_MODULE("FCode")

extern void RML_5finit(void);

void FCode_5finit(void)
{
	static int done = 0;
	if( done ) return;
	done = 1;
	RML_5finit();
}
