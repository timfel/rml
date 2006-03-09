/* file main.c */
/* Main program for the small exp1 evaluator */

#include <stdio.h>
#include "rml.h"
#include "reducer.h"

typedef void * rml_t;
rml_t absyntree;

yyerror(char *s) {
   extern int yylineno;
   fprintf(stderr,"Syntax error at or near line %d.\n", yylineno);
}

main(int argc, char** argv) {
   int res;
   

   /* Initialize the RML modules */

   fprintf(stderr, "[Init]\n");
   reducer_5finit();

   
   /* Parse input into an RML abstract syntax tree using yacc and lex: */
   
   fprintf(stderr, "[Parse]\n");
   if (yyparse() !=0) {
      fprintf(stderr,"[Parsing failed!]\n");
      exit(1);
   }
  

   /* Execute it using the RML relation "exec" or "debug": */
   
   rml_state_ARGS[0]= absyntree;
   if (argc > 1) {
      printf("[Debug]\n");
      res = rml_prim_once(RML_LABPTR(reducer__debug));
   } else {
      printf("[Exec]\n");
      res = rml_prim_once(RML_LABPTR(reducer__exec));
   }
   if (!res) {
      fprintf(stderr, "[Evaluation failed!]\n");
      exit(2);
   }
}

