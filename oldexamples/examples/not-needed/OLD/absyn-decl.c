/* module Absyn */
#include "rml.h"

extern void RML_5finit(void);

void Absyn_5finit(void)
{
	static int done = 0;
	if( done ) return;
	done = 1;
	RML_5finit();
}
