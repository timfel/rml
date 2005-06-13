/* debug-push-vars.c */
#include <stdio.h>
#include "rml.h"

/* all functions depend on 
#ifndef _RMLDB_DEFINED_   
they will call SC directly and their code will be only in -g -pg lib version 
*/

RML_BEGIN_LABEL(RML__debug_5fpush_5fvars)
{
#ifndef _RMLDB_DEFINED_
	RML_TAILCALLK(rmlSC);
#else
	if (rmldb_execution_type == RMLDB_FAST) RML_TAILCALLK(rmlSC);
	/* one big tuple here with all the params */
	rmldb_sprintf ("\n-------------\n");
	rmldb_var_print(rmlA0);
	rmldb_sprintf ("\n-------------\n");
	RML_TAILCALLK(rmlSC);
#endif
}
RML_END_LABEL

/* these functions add:
 * rmlAX   variable name
 * rmlAX+1 variable
 * to the formal parameter list of next goal */

RML_BEGIN_LABEL(RML__debug_5fpush_5fin01)
{
#ifndef _RMLDB_DEFINED_
	RML_TAILCALLK(rmlSC);
#else
	if (rmldb_execution_type == RMLDB_FAST) RML_TAILCALLK(rmlSC); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA0, rmlA1); 
	RML_TAILCALLK(rmlSC);
#endif
}RML_END_LABEL


RML_BEGIN_LABEL(RML__debug_5fpush_5fin02)
{
#ifndef _RMLDB_DEFINED_
	RML_TAILCALLK(rmlSC);
#else
	if (rmldb_execution_type == RMLDB_FAST) RML_TAILCALLK(rmlSC);
	rmldb_add_var(RMLDB_VAR_IN, rmlA0, rmlA1); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA2, rmlA3); 
	RML_TAILCALLK(rmlSC);
#endif
}RML_END_LABEL

RML_BEGIN_LABEL(RML__debug_5fpush_5fin03)
{
#ifndef _RMLDB_DEFINED_
	RML_TAILCALLK(rmlSC);
#else
	if (rmldb_execution_type == RMLDB_FAST) RML_TAILCALLK(rmlSC);
	rmldb_add_var(RMLDB_VAR_IN, rmlA0, rmlA1); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA2, rmlA3); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA4, rmlA5); 
	RML_TAILCALLK(rmlSC);
#endif
}RML_END_LABEL

RML_BEGIN_LABEL(RML__debug_5fpush_5fin04)
{
#ifndef _RMLDB_DEFINED_
	RML_TAILCALLK(rmlSC);
#else
	if (rmldb_execution_type == RMLDB_FAST) RML_TAILCALLK(rmlSC);
	rmldb_add_var(RMLDB_VAR_IN, rmlA0, rmlA1); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA2, rmlA3); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA4, rmlA5); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA6, rmlA7); 
	RML_TAILCALLK(rmlSC);
#endif
}RML_END_LABEL

RML_BEGIN_LABEL(RML__debug_5fpush_5fin05)
{
#ifndef _RMLDB_DEFINED_
	RML_TAILCALLK(rmlSC);
#else
	if (rmldb_execution_type == RMLDB_FAST) RML_TAILCALLK(rmlSC);
	rmldb_add_var(RMLDB_VAR_IN, rmlA0, rmlA1); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA2, rmlA3); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA4, rmlA5); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA6, rmlA7); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA8, rmlA9); 
	RML_TAILCALLK(rmlSC);
#endif
}RML_END_LABEL

RML_BEGIN_LABEL(RML__debug_5fpush_5fin06)
{
#ifndef _RMLDB_DEFINED_
	RML_TAILCALLK(rmlSC);
#else
	if (rmldb_execution_type == RMLDB_FAST) RML_TAILCALLK(rmlSC);
	rmldb_add_var(RMLDB_VAR_IN, rmlA0, rmlA1); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA2, rmlA3); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA4, rmlA5); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA6, rmlA7); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA8, rmlA9); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA10, rmlA11); 
	RML_TAILCALLK(rmlSC);
#endif
}RML_END_LABEL

RML_BEGIN_LABEL(RML__debug_5fpush_5fin07)
{
#ifndef _RMLDB_DEFINED_
	RML_TAILCALLK(rmlSC);
#else
	if (rmldb_execution_type == RMLDB_FAST) RML_TAILCALLK(rmlSC);
	rmldb_add_var(RMLDB_VAR_IN, rmlA0, rmlA1); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA2, rmlA3); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA4, rmlA5); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA6, rmlA7); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA8, rmlA9); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA10, rmlA11); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA12, rmlA13); 
	RML_TAILCALLK(rmlSC);
#endif
}RML_END_LABEL

RML_BEGIN_LABEL(RML__debug_5fpush_5fin08)
{
#ifndef _RMLDB_DEFINED_
	RML_TAILCALLK(rmlSC);
#else
	if (rmldb_execution_type == RMLDB_FAST) RML_TAILCALLK(rmlSC);
	rmldb_add_var(RMLDB_VAR_IN, rmlA0, rmlA1); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA2, rmlA3); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA4, rmlA5); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA6, rmlA7); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA8, rmlA9); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA10, rmlA11); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA12, rmlA13); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA14, rmlA15); 
	RML_TAILCALLK(rmlSC);
#endif
}RML_END_LABEL

RML_BEGIN_LABEL(RML__debug_5fpush_5fin09)
{
#ifndef _RMLDB_DEFINED_
	RML_TAILCALLK(rmlSC);
#else
	if (rmldb_execution_type == RMLDB_FAST) RML_TAILCALLK(rmlSC);
	rmldb_add_var(RMLDB_VAR_IN, rmlA0, rmlA1); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA2, rmlA3); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA4, rmlA5); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA6, rmlA7); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA8, rmlA9); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA10, rmlA11); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA12, rmlA13); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA14, rmlA15); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA16, rmlA17); 
	RML_TAILCALLK(rmlSC);
#endif
}RML_END_LABEL

RML_BEGIN_LABEL(RML__debug_5fpush_5fin10)
{
#ifndef _RMLDB_DEFINED_
	RML_TAILCALLK(rmlSC);
#else
	if (rmldb_execution_type == RMLDB_FAST) RML_TAILCALLK(rmlSC);
	rmldb_add_var(RMLDB_VAR_IN, rmlA0, rmlA1); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA2, rmlA3); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA4, rmlA5); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA6, rmlA7); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA8, rmlA9); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA10, rmlA11); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA12, rmlA13); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA14, rmlA15); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA16, rmlA17); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA18, rmlA19); 
	RML_TAILCALLK(rmlSC);
#endif
}RML_END_LABEL

RML_BEGIN_LABEL(RML__debug_5fpush_5fin11)
{
#ifndef _RMLDB_DEFINED_
	RML_TAILCALLK(rmlSC);
#else
	if (rmldb_execution_type == RMLDB_FAST) RML_TAILCALLK(rmlSC);
	rmldb_add_var(RMLDB_VAR_IN, rmlA0, rmlA1); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA2, rmlA3); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA4, rmlA5); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA6, rmlA7); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA8, rmlA9); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA10, rmlA11); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA12, rmlA13); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA14, rmlA15); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA16, rmlA17); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA18, rmlA19); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA20, rmlA21); 
	RML_TAILCALLK(rmlSC);
#endif
}RML_END_LABEL

RML_BEGIN_LABEL(RML__debug_5fpush_5fin12)
{
#ifndef _RMLDB_DEFINED_
	RML_TAILCALLK(rmlSC);
#else
	if (rmldb_execution_type == RMLDB_FAST) RML_TAILCALLK(rmlSC);
	rmldb_add_var(RMLDB_VAR_IN, rmlA0, rmlA1); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA2, rmlA3); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA4, rmlA5); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA6, rmlA7); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA8, rmlA9); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA10, rmlA11); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA12, rmlA13); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA14, rmlA15); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA16, rmlA17); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA18, rmlA19); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA20, rmlA21); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA22, rmlA23); 
	RML_TAILCALLK(rmlSC);
#endif
}RML_END_LABEL

RML_BEGIN_LABEL(RML__debug_5fpush_5fin13)
{
#ifndef _RMLDB_DEFINED_
	RML_TAILCALLK(rmlSC);
#else
	if (rmldb_execution_type == RMLDB_FAST) RML_TAILCALLK(rmlSC);
	rmldb_add_var(RMLDB_VAR_IN, rmlA0, rmlA1); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA2, rmlA3); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA4, rmlA5); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA6, rmlA7); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA8, rmlA9); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA10, rmlA11); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA12, rmlA13); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA14, rmlA15); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA16, rmlA17); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA18, rmlA19); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA20, rmlA21); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA22, rmlA23); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA24, rmlA25); 
	RML_TAILCALLK(rmlSC);
#endif
}RML_END_LABEL

RML_BEGIN_LABEL(RML__debug_5fpush_5fin14)
{
#ifndef _RMLDB_DEFINED_
	RML_TAILCALLK(rmlSC);
#else
	if (rmldb_execution_type == RMLDB_FAST) RML_TAILCALLK(rmlSC);
	rmldb_add_var(RMLDB_VAR_IN, rmlA0, rmlA1); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA2, rmlA3); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA4, rmlA5); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA6, rmlA7); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA8, rmlA9); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA10, rmlA11); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA12, rmlA13); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA14, rmlA15); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA16, rmlA17); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA18, rmlA19); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA20, rmlA21); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA22, rmlA23); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA24, rmlA25); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA26, rmlA27); 
	RML_TAILCALLK(rmlSC);
#endif
}RML_END_LABEL

RML_BEGIN_LABEL(RML__debug_5fpush_5fin15)
{
#ifndef _RMLDB_DEFINED_
	RML_TAILCALLK(rmlSC);
#else
	if (rmldb_execution_type == RMLDB_FAST) RML_TAILCALLK(rmlSC);
	rmldb_add_var(RMLDB_VAR_IN, rmlA0, rmlA1); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA2, rmlA3); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA4, rmlA5); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA6, rmlA7); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA8, rmlA9); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA10, rmlA11); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA12, rmlA13); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA14, rmlA15); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA16, rmlA17); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA18, rmlA19); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA20, rmlA21); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA22, rmlA23); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA24, rmlA25); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA26, rmlA27); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA28, rmlA29); 
	RML_TAILCALLK(rmlSC);
#endif
}RML_END_LABEL

RML_BEGIN_LABEL(RML__debug_5fpush_5fin16)
{
#ifndef _RMLDB_DEFINED_
	RML_TAILCALLK(rmlSC);
#else
	if (rmldb_execution_type == RMLDB_FAST) RML_TAILCALLK(rmlSC);
	rmldb_add_var(RMLDB_VAR_IN, rmlA0, rmlA1); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA2, rmlA3); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA4, rmlA5); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA6, rmlA7); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA8, rmlA9); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA10, rmlA11); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA12, rmlA13); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA14, rmlA15); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA16, rmlA17); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA18, rmlA19); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA20, rmlA21); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA22, rmlA23); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA24, rmlA25); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA26, rmlA27); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA28, rmlA29); 
	rmldb_add_var(RMLDB_VAR_IN, rmlA30, rmlA31); 
	RML_TAILCALLK(rmlSC);
#endif
}RML_END_LABEL

/* these functions add:
 * rmlAX variable name
 * rmlAX+1 variable
 * to the result list of last goal */

RML_BEGIN_LABEL(RML__debug_5fpush_5fout01)
{
#ifndef _RMLDB_DEFINED_
	RML_TAILCALLK(rmlSC);
#else
	if (rmldb_execution_type == RMLDB_FAST) RML_TAILCALLK(rmlSC);
	rmldb_add_var(RMLDB_VAR_OUT, rmlA0, rmlA1); 
	RML_TAILCALLK(rmlSC);
#endif
}RML_END_LABEL

RML_BEGIN_LABEL(RML__debug_5fpush_5fout02)
{
#ifndef _RMLDB_DEFINED_
	RML_TAILCALLK(rmlSC);
#else
	if (rmldb_execution_type == RMLDB_FAST) RML_TAILCALLK(rmlSC);
	rmldb_add_var(RMLDB_VAR_OUT, rmlA0, rmlA1); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA2, rmlA3); 
	RML_TAILCALLK(rmlSC);
#endif
}RML_END_LABEL

RML_BEGIN_LABEL(RML__debug_5fpush_5fout03)
{
#ifndef _RMLDB_DEFINED_
	RML_TAILCALLK(rmlSC);
#else
	if (rmldb_execution_type == RMLDB_FAST) RML_TAILCALLK(rmlSC);
	rmldb_add_var(RMLDB_VAR_OUT, rmlA0, rmlA1); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA2, rmlA3); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA4, rmlA5); 
	RML_TAILCALLK(rmlSC);
#endif
}RML_END_LABEL

RML_BEGIN_LABEL(RML__debug_5fpush_5fout04)
{
#ifndef _RMLDB_DEFINED_
	RML_TAILCALLK(rmlSC);
#else
	if (rmldb_execution_type == RMLDB_FAST) RML_TAILCALLK(rmlSC);
	rmldb_add_var(RMLDB_VAR_OUT, rmlA0, rmlA1); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA2, rmlA3); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA4, rmlA5); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA6, rmlA7); 
	RML_TAILCALLK(rmlSC);
#endif
}RML_END_LABEL

RML_BEGIN_LABEL(RML__debug_5fpush_5fout05)
{
#ifndef _RMLDB_DEFINED_
	RML_TAILCALLK(rmlSC);
#else
	if (rmldb_execution_type == RMLDB_FAST) RML_TAILCALLK(rmlSC);
	rmldb_add_var(RMLDB_VAR_OUT, rmlA0, rmlA1); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA2, rmlA3); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA4, rmlA5); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA6, rmlA7); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA8, rmlA9); 
	RML_TAILCALLK(rmlSC);
#endif
}RML_END_LABEL

RML_BEGIN_LABEL(RML__debug_5fpush_5fout06)
{
#ifndef _RMLDB_DEFINED_
	RML_TAILCALLK(rmlSC);
#else
	if (rmldb_execution_type == RMLDB_FAST) RML_TAILCALLK(rmlSC);
	rmldb_add_var(RMLDB_VAR_OUT, rmlA0, rmlA1); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA2, rmlA3); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA4, rmlA5); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA6, rmlA7); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA8, rmlA9); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA10, rmlA11); 
	RML_TAILCALLK(rmlSC);
#endif
}RML_END_LABEL

RML_BEGIN_LABEL(RML__debug_5fpush_5fout07)
{
#ifndef _RMLDB_DEFINED_
	RML_TAILCALLK(rmlSC);
#else
	if (rmldb_execution_type == RMLDB_FAST) RML_TAILCALLK(rmlSC);
	rmldb_add_var(RMLDB_VAR_OUT, rmlA0, rmlA1); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA2, rmlA3); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA4, rmlA5); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA6, rmlA7); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA8, rmlA9); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA10, rmlA11); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA12, rmlA13); 
	RML_TAILCALLK(rmlSC);
#endif
}RML_END_LABEL

RML_BEGIN_LABEL(RML__debug_5fpush_5fout08)
{
#ifndef _RMLDB_DEFINED_
	RML_TAILCALLK(rmlSC);
#else
	if (rmldb_execution_type == RMLDB_FAST) RML_TAILCALLK(rmlSC);
	rmldb_add_var(RMLDB_VAR_OUT, rmlA0, rmlA1); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA2, rmlA3); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA4, rmlA5); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA6, rmlA7); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA8, rmlA9); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA10, rmlA11); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA12, rmlA13); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA14, rmlA15); 
	RML_TAILCALLK(rmlSC);
#endif
}RML_END_LABEL

RML_BEGIN_LABEL(RML__debug_5fpush_5fout09)
{
#ifndef _RMLDB_DEFINED_
	RML_TAILCALLK(rmlSC);
#else
	if (rmldb_execution_type == RMLDB_FAST) RML_TAILCALLK(rmlSC);
	rmldb_add_var(RMLDB_VAR_OUT, rmlA0, rmlA1); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA2, rmlA3); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA4, rmlA5); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA6, rmlA7); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA8, rmlA9); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA10, rmlA11); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA12, rmlA13); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA14, rmlA15); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA16, rmlA17); 
	RML_TAILCALLK(rmlSC);
#endif
}RML_END_LABEL

RML_BEGIN_LABEL(RML__debug_5fpush_5fout10)
{
#ifndef _RMLDB_DEFINED_
	RML_TAILCALLK(rmlSC);
#else
	if (rmldb_execution_type == RMLDB_FAST) RML_TAILCALLK(rmlSC);
	rmldb_add_var(RMLDB_VAR_OUT, rmlA0, rmlA1); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA2, rmlA3); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA4, rmlA5); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA6, rmlA7); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA8, rmlA9); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA10, rmlA11); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA12, rmlA13); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA14, rmlA15); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA16, rmlA17); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA18, rmlA19); 
	RML_TAILCALLK(rmlSC);
#endif
}RML_END_LABEL

RML_BEGIN_LABEL(RML__debug_5fpush_5fout11)
{
#ifndef _RMLDB_DEFINED_
	RML_TAILCALLK(rmlSC);
#else
	if (rmldb_execution_type == RMLDB_FAST) RML_TAILCALLK(rmlSC);
	rmldb_add_var(RMLDB_VAR_OUT, rmlA0, rmlA1); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA2, rmlA3); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA4, rmlA5); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA6, rmlA7); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA8, rmlA9); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA10, rmlA11); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA12, rmlA13); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA14, rmlA15); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA16, rmlA17); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA18, rmlA19); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA20, rmlA21); 
	RML_TAILCALLK(rmlSC);
#endif
}RML_END_LABEL

RML_BEGIN_LABEL(RML__debug_5fpush_5fout12)
{
#ifndef _RMLDB_DEFINED_
	RML_TAILCALLK(rmlSC);
#else
	if (rmldb_execution_type == RMLDB_FAST) RML_TAILCALLK(rmlSC);
	rmldb_add_var(RMLDB_VAR_OUT, rmlA0, rmlA1); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA2, rmlA3); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA4, rmlA5); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA6, rmlA7); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA8, rmlA9); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA10, rmlA11); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA12, rmlA13); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA14, rmlA15); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA16, rmlA17); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA18, rmlA19); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA20, rmlA21); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA22, rmlA23); 
	RML_TAILCALLK(rmlSC);
#endif
}RML_END_LABEL

RML_BEGIN_LABEL(RML__debug_5fpush_5fout13)
{
#ifndef _RMLDB_DEFINED_
	RML_TAILCALLK(rmlSC);
#else
	if (rmldb_execution_type == RMLDB_FAST) RML_TAILCALLK(rmlSC);
	rmldb_add_var(RMLDB_VAR_OUT, rmlA0, rmlA1); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA2, rmlA3); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA4, rmlA5); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA6, rmlA7); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA8, rmlA9); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA10, rmlA11); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA12, rmlA13); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA14, rmlA15); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA16, rmlA17); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA18, rmlA19); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA20, rmlA21); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA22, rmlA23); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA24, rmlA25); 
	RML_TAILCALLK(rmlSC);
#endif
}RML_END_LABEL

RML_BEGIN_LABEL(RML__debug_5fpush_5fout14)
{
#ifndef _RMLDB_DEFINED_
	RML_TAILCALLK(rmlSC);
#else
	if (rmldb_execution_type == RMLDB_FAST) RML_TAILCALLK(rmlSC);
	rmldb_add_var(RMLDB_VAR_OUT, rmlA0, rmlA1); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA2, rmlA3); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA4, rmlA5); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA6, rmlA7); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA8, rmlA9); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA10, rmlA11); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA12, rmlA13); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA14, rmlA15); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA16, rmlA17); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA18, rmlA19); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA20, rmlA21); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA22, rmlA23); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA24, rmlA25); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA26, rmlA27); 
	RML_TAILCALLK(rmlSC);
#endif
}RML_END_LABEL

RML_BEGIN_LABEL(RML__debug_5fpush_5fout15)
{
#ifndef _RMLDB_DEFINED_
	RML_TAILCALLK(rmlSC);
#else
	if (rmldb_execution_type == RMLDB_FAST) RML_TAILCALLK(rmlSC);
	rmldb_add_var(RMLDB_VAR_OUT, rmlA0, rmlA1); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA2, rmlA3); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA4, rmlA5); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA6, rmlA7); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA8, rmlA9); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA10, rmlA11); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA12, rmlA13); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA14, rmlA15); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA16, rmlA17); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA18, rmlA19); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA20, rmlA21); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA22, rmlA23); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA24, rmlA25); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA26, rmlA27); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA28, rmlA29); 
	RML_TAILCALLK(rmlSC);
#endif
}RML_END_LABEL

RML_BEGIN_LABEL(RML__debug_5fpush_5fout16)
{
#ifndef _RMLDB_DEFINED_
	RML_TAILCALLK(rmlSC);
#else
	if (rmldb_execution_type == RMLDB_FAST) RML_TAILCALLK(rmlSC);
	rmldb_add_var(RMLDB_VAR_OUT, rmlA0, rmlA1); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA2, rmlA3); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA4, rmlA5); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA6, rmlA7); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA8, rmlA9); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA10, rmlA11); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA12, rmlA13); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA14, rmlA15); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA16, rmlA17); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA18, rmlA19); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA20, rmlA21); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA22, rmlA23); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA24, rmlA25); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA26, rmlA27); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA28, rmlA29); 
	rmldb_add_var(RMLDB_VAR_OUT, rmlA30, rmlA31); 
	RML_TAILCALLK(rmlSC);
#endif
}RML_END_LABEL
