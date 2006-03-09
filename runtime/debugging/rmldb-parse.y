%{

#include "rml.h"

extern int aalex(void);

#define YYDEBUG 1
#define YYERROR_VERBOSE                  /* Have this defined to give better
                                            error messages. Using it causes
					    some bison warnings at compiler
					    compile time, however. Use as you
					    wish. Not mandatory. */
%}


/* The different semantic values that can be returned within the AST. 
 */
%union 
{
  int   v_int;
  float v_float;
  char *to_print;
  char *id;
}

/* uncomment this shit on linux and comment it on solaris
   damn incompatibilities
*/
/* %name-prefix="aa" */

/* Here are return types for all productions that return nodes (ie, the
   return type of the bison $$ construct).
   (hint: maybe $$ has the type YYSTYPE?). */
%token T_EOF T_ERROR T_EOL T_HELP 
%token T_BREAKPOINT T_SET T_SETTINGS T_RUN T_STEP T_CLEAR 
%token T_QUIT T_ON T_OFF T_DEPTH T_SHOW T_STATUS T_END T_DEBUGPARSER
%token T_OUTPUT T_LIVEVARS T_PRINT T_SIZEOF T_DISPLAY T_UNDISPLAY T_GRAPH T_FAST
%token T_MAXBT T_BACKTRACE T_FILTERED_BACKTRACE
%token T_GRAPH_BACKTRACE T_GRAPH_FILTERED_BACKTRACE
%token T_MAXSTR T_PRINT_TYPE T_NEXT 
%token T_MAXCALLCHAIN T_CALLCHAIN T_FILTERED_CALLCHAIN
%token T_GRAPH_CALLCHAIN T_GRAPH_FILTERED_CALLCHAIN
%token <char *>T_ID

%start command
%%

command:  
T_BREAKPOINT T_ON T_ID T_EOL
{
#ifdef RML_DEBUG
  /* set On the filter on this relation */
  rmldb_add_relation_filter(aalval.id);
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
}
| T_BREAKPOINT T_OFF T_ID T_EOL
{
#ifdef RML_DEBUG
  /* set Off the filter on this relation */
  rmldb_del_relation_filter(aalval.id);
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
}
| T_SET T_STEP T_ON T_EOL
{
#ifdef RML_DEBUG
  rmldb_execution_type = RMLDB_STEP;
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
}
| T_SET T_STEP T_OFF T_EOL
{
#ifdef RML_DEBUG
  rmldb_execution_type = RMLDB_RUN;
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
}
| T_STEP T_EOL
{
#ifdef RML_DEBUG
  rmldb_last_command = RMLDB_BREAK_PARSE;
  rmldb_execution_type = RMLDB_STEP;
#endif /* RML_DEBUG */
  YYACCEPT;
}
/*
| T_EOL
{
#ifdef RML_DEBUG
  rmldb_last_command = RMLDB_BREAK_PARSE;
  rmldb_execution_type = RMLDB_STEP;
#endif 
  YYACCEPT;
}
*/
| T_NEXT T_EOL
{
#ifdef RML_DEBUG
  rmldb_last_command = RMLDB_BREAK_PARSE;
  rmldb_execution_type = RMLDB_NEXT;  
#endif /* RML_DEBUG */
  YYACCEPT;
}
| T_RUN T_EOL
{
#ifdef RML_DEBUG
  rmldb_execution_type = RMLDB_RUN;
  rmldb_last_command = RMLDB_BREAK_PARSE;
  rmldb_show = RMLDB_HIDE;
#endif /* RML_DEBUG */
  YYACCEPT;
}
| T_BACKTRACE T_EOL
{
#ifdef RML_DEBUG
  rmldb_backtrace_print(NULL);
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
}
| T_FILTERED_BACKTRACE T_ID T_EOL
{
#ifdef RML_DEBUG
  rmldb_backtrace_print(aalval.id);
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;   
}
| T_GRAPH_BACKTRACE T_EOL
{
#ifdef RML_DEBUG
  rmldb_backtrace_send(NULL);
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
}
| T_GRAPH_FILTERED_BACKTRACE T_ID T_EOL
{
#ifdef RML_DEBUG
  rmldb_backtrace_send(aalval.id);
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;   
}
| T_SET T_MAXBT T_ID T_EOL
{
#ifdef RML_DEBUG
  rmldb_set_max_backtrace(aalval.id);
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
}
| T_MAXBT T_ID T_EOL
{
#ifdef RML_DEBUG
  rmldb_set_max_backtrace(aalval.id);
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
}
| T_CALLCHAIN T_EOL
{
#ifdef RML_DEBUG
  rmldb_callchain_print(NULL);
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
}
| T_FILTERED_CALLCHAIN T_ID T_EOL
{
#ifdef RML_DEBUG
  rmldb_callchain_print(aalval.id);
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;   
}
| T_GRAPH_CALLCHAIN T_EOL
{
#ifdef RML_DEBUG
  rmldb_callchain_send(NULL);
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
}
| T_GRAPH_FILTERED_CALLCHAIN T_ID T_EOL
{
#ifdef RML_DEBUG
  rmldb_callchain_send(aalval.id);
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;   
}
| T_SET T_MAXCALLCHAIN T_ID T_EOL
{
#ifdef RML_DEBUG
  rmldb_set_max_callchain(aalval.id);
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
}
| T_MAXCALLCHAIN T_ID T_EOL
{
#ifdef RML_DEBUG
  rmldb_set_max_callchain(aalval.id);
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
}
| T_HELP T_EOL
{
#ifdef RML_DEBUG
  rmldb_show_help(); 
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
}
| T_QUIT T_EOL
{
#ifdef RML_DEBUG
  printf("end the program\n");
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  rml_exit(2);
}
| T_SET T_DEPTH T_ID T_EOL
{
#ifdef RML_DEBUG
  rmldb_set_depth(aalval.id);
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
}
| T_DEPTH T_ID T_EOL
{
#ifdef RML_DEBUG
  rmldb_set_depth(aalval.id);
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
}
| T_SET T_MAXSTR T_ID T_EOL
{
#ifdef RML_DEBUG
  rmldb_set_maxstr(aalval.id);
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
}
| T_MAXSTR T_ID T_EOL
{
#ifdef RML_DEBUG
  rmldb_set_maxstr(aalval.id);
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
}
| T_SETTINGS T_EOL
{
#ifdef RML_DEBUG
  rmldb_print_settings();
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
}
| T_SHOW T_EOL
{
#ifdef RML_DEBUG
  rmldb_show_breakpoints();
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
}
| T_CLEAR T_EOL
{
#ifdef RML_DEBUG
  rmldb_clear_breakpoints();
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
}
| T_STATUS T_EOL
{
#ifdef RML_DEBUG
  rmldb_show_status();
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
}
| T_OUTPUT T_ID T_EOL
{
#ifdef RML_DEBUG
  rmldb_set_output(aalval.id);
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
}
| T_PRINT T_ID T_EOL
{
#ifdef RML_DEBUG
  rmldb_last_command = RMLDB_REPEAT_PARSE;
  rmldb_print_variable(aalval.id);
#endif /* RML_DEBUG */
  YYACCEPT;
}
| T_PRINT_TYPE T_ID T_EOL
{
#ifdef RML_DEBUG
  rmldb_last_command = RMLDB_REPEAT_PARSE;
  rmldb_print_type_info_id(aalval.id, stdout);
#endif /* RML_DEBUG */
  YYACCEPT;
}
| T_SIZEOF T_ID T_EOL
{
#ifdef RML_DEBUG
  rmldb_last_command = RMLDB_REPEAT_PARSE;
  rmldb_print_sizeof_variable(aalval.id);
#endif /* RML_DEBUG */
  YYACCEPT;
}
| T_LIVEVARS T_EOL
{
#ifdef RML_DEBUG
  rmldb_last_command = RMLDB_REPEAT_PARSE;
  rmldb_print_vars();
#endif /* RML_DEBUG */
  YYACCEPT;
}
| T_SET T_LIVEVARS T_ON T_EOL
{
#ifdef RML_DEBUG
  rmldb_last_command = RMLDB_REPEAT_PARSE;
  rmldb_set_print_vars(RMLDB_LIVEVARS_ON);
#endif /* RML_DEBUG */
  YYACCEPT;
}
| T_LIVEVARS T_ON T_EOL
{
#ifdef RML_DEBUG
  rmldb_last_command = RMLDB_REPEAT_PARSE;
  rmldb_set_print_vars(RMLDB_LIVEVARS_ON);
#endif /* RML_DEBUG */
  YYACCEPT;
}
| T_SET T_LIVEVARS T_OFF T_EOL
{
#ifdef RML_DEBUG
  rmldb_last_command = RMLDB_REPEAT_PARSE;
  rmldb_set_print_vars(RMLDB_LIVEVARS_OFF);
#endif /* RML_DEBUG */
  YYACCEPT;
}
| T_LIVEVARS T_OFF T_EOL
{
#ifdef RML_DEBUG
  rmldb_last_command = RMLDB_REPEAT_PARSE;
  rmldb_set_print_vars(RMLDB_LIVEVARS_OFF);
#endif /* RML_DEBUG */
  YYACCEPT;
}
| T_DISPLAY T_EOL
{
#ifdef RML_DEBUG
  rmldb_last_command = RMLDB_REPEAT_PARSE;
  rmldb_show_displayvars();
#endif /* RML_DEBUG */
  YYACCEPT;
}
| T_DISPLAY T_ID T_EOL
{
#ifdef RML_DEBUG
  rmldb_last_command = RMLDB_REPEAT_PARSE;
  rmldb_display_variable(aalval.id);
#endif /* RML_DEBUG */
  YYACCEPT;
}
| T_UNDISPLAY T_EOL
{
#ifdef RML_DEBUG
  rmldb_last_command = RMLDB_REPEAT_PARSE;
  rmldb_clear_displayvars();
#endif /* RML_DEBUG */
  YYACCEPT;	
}
| T_UNDISPLAY T_ID T_EOL
{
#ifdef RML_DEBUG
  rmldb_last_command = RMLDB_REPEAT_PARSE;
  rmldb_undisplay_variable(aalval.id);
#endif /* RML_DEBUG */
  YYACCEPT;
}
| T_FAST T_EOL
{
#ifdef RML_DEBUG
  printf("Entering in fast debug mode, no backtrace generation, no live variables.\n");
  printf("Only verifying breakpoints, if they exist. \n");
  printf("Hit CTRL+C to enter again in Step execution mode when you want.\n");
  rmldb_last_command = RMLDB_BREAK_PARSE;
  rmldb_execution_type = RMLDB_FAST;
  rmldb_show = RMLDB_HIDE;
#endif /* RML_DEBUG */
  YYACCEPT;
}
| T_GRAPH T_ID T_EOL
{
#ifdef RML_DEBUG
  rmldb_last_command = RMLDB_REPEAT_PARSE;
  rmldb_view_variable(aalval.id);
#endif /* RML_DEBUG */
  YYACCEPT;
}
| T_DEBUGPARSER T_ON T_EOL
{
#ifdef RML_DEBUG
  aadebug = 1;
#endif /* RML_DEBUG */
  YYACCEPT;
}
| T_DEBUGPARSER T_OFF T_EOL
{
#ifdef RML_DEBUG
  aadebug = 0;
#endif /* RML_DEBUG */
  YYACCEPT;
}
;

%%

int aaerror(char *s) 
{
  fprintf(stderr, "%s or command not recognized\n", s);
  return -1;
}
