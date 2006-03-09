/* module Exp1 */
#include "rml.h"
#include <stdlib.h>
#include <stdio.h>
RML_DEFINE_MODULE("Exp1")

extern void RML_5finit(void);

void Exp1_5finit(void)
{
	static int done = 0;
	if( done ) return;
	done = 1;
	RML_5finit();
	rmldb_load_db("testin.rdb");
}
