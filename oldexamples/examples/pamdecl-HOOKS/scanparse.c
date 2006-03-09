/* Glue to call parser (and thus scanner) from RML */
 
#include <stdio.h>
#include <errno.h>
#include "rml.h"
 
/* Provide error reporting function for yacc */
 
yyerror(char *s)
{
  extern int yylineno;
  fprintf(stderr,"Error: bad syntax on line %d.\n",yylineno);
}
 
/* The yacc parser will deposit the syntax tree here */
 
void *absyntree;
 
/* No init for this module */
 
void ScanParse_5finit(void) {}
 
/* The glue function */
 
RML_BEGIN_LABEL(ScanParse__scanparse)
{
    void *a0 = rmlA0;
    if( !freopen(RML_STRINGDATA(a0), "r", stdin) ) 
	{
		fprintf(stderr, "freopen %s failed: %s\n",
		RML_STRINGDATA(a0), strerror(errno));
		RML_TAILCALLK(rmlFC);
    }
    if( yyparse() != 0 )  
	{
		fprintf(stderr,"Fatal: parsing failed!\n");
		RML_TAILCALLK(rmlFC);
	}
	rmlA0=absyntree;
	RML_TAILCALLK(rmlSC);
}
RML_END_LABEL
