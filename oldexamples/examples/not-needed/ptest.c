#include <stdio.h>
#include "parser.h"
#include "rml.h"
#include "defs.h"
#include "rmldump.h"
#include "absyn-decl.h"


yyerror(char *s) 
{ 
  static  int yylineno; 
  fprintf(stderr,"Syntax error at or near line %d.\n",yylineno); 
}

extern int yydebug;

int main()
{
  /* debug the damn parser -- comment this to not output the parser debug */
  yydebug = 1;
  
  if (yyparse() != 0)
  {     
    fprintf(stderr,"Parsing failed!\n");
    exit(1);
  }

  Absyn_5finit();
  RMLDump_5finit();

  rml_state_ARGS[0]= absyntree;
  printf("Trying to dump...\n\n");
  if (!rml_prim_once(RML_LABPTR(RMLDump__dump)))
  {
    fprintf(stderr,"RMLDump.dump failed.\n");
    //exit(2);
  }
  
  return 0;  
}
