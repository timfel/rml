/* ccall.c */
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include "rml.h"
#include "yacclib.h"

extern int yyparse(void);
extern rml_value_t* yylval;

#if defined(RML_PLAIN) || defined(RML_SWITCH)

void Parse_5finit(void) {}

RML_BEGIN_LABEL(Parse__parse)
{
#ifdef BENCH
    rml_uint_t clock_before_parse = rml_prim_clock();
#endif
    void *a0 = rmlA0;
    if( !freopen(RML_STRINGDATA(a0), "r", stdin) ) 
	{
	fprintf(stderr, "freopen %s failed: %s\n",
		RML_STRINGDATA(a0), strerror(errno));
	RML_TAILCALLK(rmlFC);
    }
	rml_state_nrArgs = 1;
    if( yyparse() != 0 )
	RML_TAILCALLK(rmlFC);
	rmlA0 = RML_GET_AND_FREE(yylval); 
	/* no more external roots please */
	CLEAR_EXTERNAL_ROOTS;
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

#ifdef RML_PUSHY

void Parse_5finit(void) {}

RML_DEFINE_LABEL1(Parse__parse)
{
#ifdef BENCH
    rml_uint_t clock_before_parse = rml_prim_clock();
#endif
    if( !freopen(RML_STRINGDATA(A0), "r", yyin) ) {
	fprintf(stderr, "freopen %s failed: %s\n",
		RML_STRINGDATA(A0), strerror(errno));
	RML_RETURN0(FC);
    }
    if( yyparse() != 0 )
		RML_RETURN0(FC);
#ifdef BENCH
    rml_clock_start += (rml_prim_clock() - clock_before_parse);
#endif
    RML_RETURN1(SC, RML_GET_AND_FREE(yylval));
}

#ifdef BENCH
RML_DEFINE_LABEL1(RML__print)
{
    RML_RETURN0(SC);
}
#endif

#endif	/* RML_PUSHY */

#ifdef RML_WARPED

void **Parse__parse;

void Parse_5finit(void)
{
    static int done;
    if( done ) return;
    done = 1;
    rml_5finit();
    Absyn_5finit();
    Parse__parse = &&entry_Parse__parse;
#ifdef BENCH
    RML__print = &&entry_noop_print;
#endif
    return;

  entry_Parse__parse:
    {
#ifdef BENCH
	static rml_uint_t clock_before_parse;
	clock_before_parse = rml_prim_clock();
#endif
	if( !freopen(RML_STRINGDATA(rmlA0), "r", yyin) ) {
	    fprintf(stderr, "freopen %s failed: %s\n",
		    RML_STRINGDATA(rmlA0), strerror(errno));
	    goto *(void**)RML_FETCH(rmlFC);
	}
	if( yyparse() != 0 )
	    goto *(void**)RML_FETCH(rmlFC);
	rmlA0 = RML_GET_AND_FREE(yylval);
	CLEAR_EXTERNAL_ROOTS;
#ifdef BENCH
	rml_clock_start += (rml_prim_clock() - clock_before_parse);
#endif
	goto *(void**)RML_FETCH(rmlSC);
    }

#ifdef BENCH
  entry_noop_print:
    goto *(void**)RML_FETCH(rmlSC);
#endif
}

#endif	/* RML_WARPED */
