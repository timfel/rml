/* file main.c */
/* Main program for the small exp1 evaluator */

#include <stdio.h>
#include "rml.h"
#include "exp1.h"

typedef void * rml_t;
rml_t absyntree;

yyerror(char *s)
{
  extern int yylineno;
  fprintf(stderr,"Syntax error at or near line %d.\n",yylineno);
}
extern unsigned long rml_young_size;

main()
{
  int res;

  /* do some logs here */
  rml_flag_log = 1;
  rml_flag_gclog = 1;
  rml_flag_no_stack_check = 0;
  rml_young_size = 8;

  /* Initialize the RML modules */
  printf("[Init]\n");
  exp1_5finit();

  /* Parse the input into an abstract syntax tree (in RML form)
     using yacc and lex */

  printf("[Parse]\n");
  if (yyparse() !=0)
  {
    fprintf(stderr,"Parsing failed!\n");
    exit(1);
  }

  /* Evalute it using the RML relation "eval" */

  printf("[Eval]\n");
  rml_state_ARGS[0]= absyntree;
  if (!rml_prim_once(RML_LABPTR(exp1__eval)) )
  {
    fprintf(stderr,"Evaluation failed!\n");
    exit(2);
  }

  /* Present result */

  res=RML_UNTAGFIXNUM(rml_state_ARGS[0]);
  printf("Result: %d\n", res);
}

