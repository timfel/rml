/* debug-print.c */
#include <stdio.h>
#include "rml.h"

RML_BEGIN_LABEL(RML__debug_5fprint)
{
	void *str = rmlA0;
	/*if (execution_type == RMLDB_STEP || rmldb_show == RMLDB_SHOW)*/
	{
		rmldb_sprintf ("%s=[", RML_STRINGDATA(str));
		rmldb_var_print(rmlA1);
		rmldb_sprintf ("]\n");
	}
	RML_TAILCALLK(rmlSC);
}
RML_END_LABEL
