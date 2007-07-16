/* ccall.c */
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include "rml.h"
extern int yyparse(void);
extern void *yylval;

#if defined(RML_PLAIN) || defined(RML_SWITCH)

void Parse_5finit(void) {}

RML_BEGIN_LABEL(Parse__parse)
{
#ifdef BENCH
    rml_uint_t clock_before_parse = rml_prim_clock();
#endif
    void *a0 = rmlA0;
    if( !freopen(RML_STRINGDATA(a0), "r", stdin) ) {
	fprintf(stderr, "freopen %s failed: %s\n",
		RML_STRINGDATA(a0), strerror(errno));
	RML_TAILCALLK(rmlFC);
    }
    if( yyparse() != 0 )
	RML_TAILCALLK(rmlFC);
    rmlA0 = yylval;
#ifdef BENCH
    rml_clock_start += (rml_prim_clock() - clock_before_parse);
#endif
    RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

#ifdef BENCH
RML_BEGIN_LABEL(RML__print)
{
    RML_TAILCALLK(rmlSC);
}
RML_END_LABEL
#endif

#endif	/* PLAIN || SWITCH */


