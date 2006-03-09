/* module TCode */
#include "rml.h"
#include <stdlib.h>
#include <stdio.h>
RML_DEFINE_MODULE("TCode")

extern void RML_5finit(void);

void TCode_5finit(void)
{
	static int done = 0;
	if( done ) return;
	done = 1;
	RML_5finit();
}
