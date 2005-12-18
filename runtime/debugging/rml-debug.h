
/* please LEAVE this line here */
#define _RMLDB_DEFINED_  /* fix this */
#ifdef _RMLDB_DEFINED_ /*  put these only in the debug version */
/***********************************************************
 [ rml-debug.h ] 
  - Adrian Pop, adrpo@ida.liu.se, http://www.ida.liu.se/~adrpo
  - creation 2002-10
    + interface for rml debugging 
    + this file contains all the functions for debugging 
	+ all things in this file start with rmldb_
  - last modified 2005-01-18
************************************************************/

#ifndef _RML_DEBUG_H_
#define _RML_DEBUG_H_

#include <stdio.h>

/* adrpo some useful defines. */
#define RMLDB_PROMPT "rmldb@>"
#define RMLDB_RUN    0
#define RMLDB_STEP   1
#define RMLDB_NEXT   2
#define RMLDB_FAST   3 /* no livevars, no backtrace, just very fast debugging (breakpoints) */

#define RMLDB_REPEAT_PARSE   0  /* repeat the command parse */
#define RMLDB_BREAK_PARSE    1  /* exit the parse cycle and continue with the execution */

#define RMLDB_SHOW  1
#define RMLDB_HIDE  0

#define RMLDB_VAR_IN 0
#define RMLDB_VAR_OUT 1

#define RMLDB_LIVEVARS_ON  1
#define RMLDB_LIVEVARS_OFF 0

#define RMLDB_MAX_BREAKPOINTS 100
#define RMLDB_MAX_STRING  1000

#define RMLDB_MAX_DISPLAY_VARS 100

#define rmldb_sprintf printf

/* debugger typedefs */

typedef struct rmldb_range_db
{
  int sl;
  int sc;
  int el;
  int ec;
} rmldb_range_db_t;

typedef struct rmldb_ex_loc
{
   char file[RMLDB_MAX_STRING];
   rmldb_range_db_t range;
   char relation[RMLDB_MAX_STRING];
   char goal[RMLDB_MAX_STRING];
   unsigned long SP;
} rmldb_current_execution_loc_t;

typedef struct rmldb_stack_node
{
   char relation_name[RMLDB_MAX_STRING];
   int depth;
   rmldb_current_execution_loc_t loc;
   struct rmldb_stack_node *prev;
   struct rmldb_stack_node *next;
} rmldb_stack_node_t;

typedef struct rmldb_call_node
{
   char relation_name[RMLDB_MAX_STRING];
   int depth;
   rmldb_current_execution_loc_t loc;
   struct rmldb_call_node *prev;
   struct rmldb_call_node *next;
} rmldb_call_node_t;

typedef struct rmldb_var_node
{
   void* var_name;
   void* var;
   int depth;
   struct rmldb_var_node *prev;
   struct rmldb_var_node *next;
} rmldb_var_node_t;

/* types */

typedef struct rmldb_str
{
   char *name;
   int depth;
   struct rmldb_str *prev;
   struct rmldb_str *next;
} rmldb_str_t;

typedef struct rmldb_str_list
{
	rmldb_str_t* list_start;
	rmldb_str_t* list_end;
} rmldb_str_list_t;

/*
    excerpt from rml.grm
    datatype ident	= IDENT of string
    type tyvar		= ident
    datatype longid	= LONGID of ident option * ident
    datatype ty	= VARty of tyvar
				| CONSty of ty list * longid
				| TUPLEty of ty list
				| RELty of ty list * ty list
%nonterm ty of Absyn.ty
	   | tuple_ty of Absyn.ty list
	   | ty_sans_star of Absyn.ty
	   | ty_comma_seq2 of Absyn.ty list
	   | seq_ty of Absyn.ty list
*/

/* define type ahead, as is it mutually recursive
 * with type components 
 */
struct rmldb_type;

typedef struct rmldb_LISTty
{
   int length;
   struct rmldb_type* list_start; 
   struct rmldb_type* list_end;
} rmldb_LISTty_t;

typedef struct rmldb_VARty { char* id; } rmldb_VARty_t;

typedef struct rmldb_CONSty 
{ 
	rmldb_LISTty_t* list;
	char* id;
} rmldb_CONSty_t;

typedef struct rmldb_TUPLEty 
{ 
	rmldb_LISTty_t* list;
} rmldb_TUPLEty_t;

typedef struct rmldb_RELty 
{ 
	rmldb_LISTty_t* list1;
	rmldb_LISTty_t* list2;
} rmldb_RELty_t;


typedef enum rmldb_tyKind 
{
	RMLDB_eNORMAL,
	RMLDB_eLISTty,
	RMLDB_eVARty,
	RMLDB_eCONSty,
	RMLDB_eTUPLEty,
	RMLDB_eRELty
} rmldb_tyKind_t;

typedef struct rmldb_type
{
   rmldb_tyKind_t kind; /* selects the stufs in the union or no union at all */
   union component_t
   {
	 rmldb_LISTty_t*  l;
	 rmldb_VARty_t*   v;
	 rmldb_CONSty_t*  c;
	 rmldb_TUPLEty_t* t;
	 rmldb_RELty_t*   r;
   } component;

   /* these are used in rmldb_LISTty */
   int depth;
   struct rmldb_type *prev;
   struct rmldb_type *next;
} rmldb_type_t;

typedef struct rmldb_type_db
{
   char *file;
   char *name;
   rmldb_range_db_t* range;
   rmldb_type_t *type;
   int depth;
   struct rmldb_type_db *prev;
   struct rmldb_type_db *next;
} rmldb_type_db_t;

typedef struct rmldb_var_db
{
   char *file;
   rmldb_range_db_t *range;
   rmldb_range_db_t *clause_range; /* for val declarations this will be set to range */
   char *relation; /* for val declarations this will be set to "_VAL_DELCLARATION_" */
   char *name;
   rmldb_type_db_t* type_db;

   int depth;
   struct rmldb_var_db *prev;
   struct rmldb_var_db *next;
} rmldb_var_db_t;

typedef struct rmldb_con_db
{
   char *file;
   int constructor;
   int is_transparent;
   rmldb_range_db_t* range;
   char *name;
   rmldb_type_db_t* type_db;

   int depth;
   struct rmldb_con_db *prev;
   struct rmldb_con_db *next;
} rmldb_con_db_t;

typedef struct rmldb_relation_db
{
   char *file;
   rmldb_range_db_t* range;
   char *name;
   rmldb_type_db_t* type_db;

   int depth;
   struct rmldb_relation_db *prev;
   struct rmldb_relation_db *next;
} rmldb_relation_db_t;

/* adrpo - debugger global variables */ 
extern int   rmldb_execution_type;
extern int   rmldb_execution_startup_type;
extern int   rmldb_show;
extern int   rmldb_last_command; /* need to know if we should start running or get more commands from the debugger */
extern char* rmldb_command;
extern int   rmldb_max_backtrace_entries;
extern int   rmldb_max_callchain_entries;
extern int   rmldb_depth_of_variable_print;
extern int   rmldb_max_string_variable_print;
extern int   rmldb_print_livevars_each_step; /* print the current livevars each step */
/* this filter is set on the relations you want to make the 
   program to stop (like a breakpoint, but with string matching)  */
extern char  rmldb_relation_filter[RMLDB_MAX_BREAKPOINTS][RMLDB_MAX_STRING];
extern int   rmldb_number_of_filters; /* of course, the number of filters. */
extern char  rmldb_display_vars[RMLDB_MAX_DISPLAY_VARS][RMLDB_MAX_STRING];
extern int   rmldb_number_of_display_vars; /* of course, the number active display vars. */
extern char* rmldb_ttyname;
/* location of current execution point */
extern       rmldb_current_execution_loc_t rmldb_current_execution_loc;

/* init/help/exit */
extern int  rmldb_init(void);
extern int  rmldb_end(void);
extern void rmldb_show_help(void);
extern int  rmldb_quit(char *line);

/* breakpoints */
extern void rmldb_add_relation_filter(char *);
extern void rmldb_del_relation_filter(char *);
extern void rmldb_show_breakpoints(void);
extern void rmldb_clear_breakpoints(void);


extern void rmldb_debug_add_var(int direction, void* var_name, void* var);
extern void rmldb_clear_debug_vars(void);
extern void rmldb_print_variable(char* var_name);
extern unsigned long rmldb_var_sizeof(void *p);
extern void rmldb_print_sizeof_variable(char* var_name);
extern void rmldb_print_debug_vars(void);
extern void rmldb_set_print_debug_vars(int flag);
extern void rmldb_display_variable(char* var_name);
extern void rmldb_undisplay_variable(char* var_name);
extern void rmldb_print_displayvars(void);
extern void rmldb_show_displayvars(void);
extern void rmldb_clear_displayvars(void);
extern void rmldb_view_variable(char* var_name);

extern unsigned long rmldb_stack_pointer_to_ulong(void* stackPointer);

/* stack (backtrace) */
extern void rmldb_backtrace_push(char *rname, rmldb_current_execution_loc_t loc);
extern void rmldb_backtrace_pop(void);
extern void rmldb_backtrace_print(char* filter);
extern void rmldb_backtrace_send(char* filter);
extern void rmldb_set_max_backtrace(char *maxbt);

/* call chain */
extern void rmldb_callchain_push(char *rname, rmldb_current_execution_loc_t loc);
extern void rmldb_callchain_pop(void);
extern void rmldb_callchain_print(char* filter);
extern void rmldb_backtrace_send(char* filter);
extern void rmldb_set_max_callchain(char *maxcallchain);

/* settings */
extern void rmldb_set_depth(char* depth);
extern void rmldb_set_maxstring(char* maxstr);
extern void rmldb_print_settings(void);
extern void rmldb_set_output(char *);

/* variables in relations and variables in val declarations */
extern rmldb_var_db_t*      rmldb_var_db_start;
extern rmldb_var_db_t*      rmldb_var_db_end;
/* types */
extern rmldb_type_db_t*     rmldb_type_db_start;
extern rmldb_type_db_t*     rmldb_type_db_end;
/* datatype constructors */
extern rmldb_con_db_t*      rmldb_con_db_start;
extern rmldb_con_db_t*      rmldb_con_db_end;
/* relations */
extern rmldb_relation_db_t* rmldb_relation_db_start;
extern rmldb_relation_db_t* rmldb_relation_db_end;

extern int  rmldb_load_db(char* programdb_file);
extern void rmldb_print_type_info_id(char* name, FILE* out);
extern void rmldb_print_type_constructor(char* constructor_name, FILE* out);
extern void rmldb_print_type_constructors(char* type_name, FILE* out);
extern void rmldb_print_type(rmldb_type_t* type, int detailed, FILE* out);
extern void rmldb_print_type_list(rmldb_LISTty_t* list, int detailed, char* separator, FILE* out);
extern rmldb_type_db_t* rmldb_get_type(char* var_name);
extern rmldb_var_db_t* rmldb_get_var(char* var_name);
extern char* rmldb_get_con_name(rmldb_type_t *type, int constructor);
extern rmldb_con_db_t* rml_get_con(rmldb_type_t *type, int constructor);
extern int rmldb_is_type_transparent(rmldb_type_t *type);
extern void rmldb_str_list_print(rmldb_str_list_t* list);
extern void rmldb_str_list_free(rmldb_str_list_t* list);
extern void rmldb_type_list_to_list(rmldb_LISTty_t* list, rmldb_str_list_t* lst);
extern void rmldb_type_to_list(rmldb_type_t *type, rmldb_str_list_t* list);
extern int rmldb_str_list_get_size(rmldb_str_list_t* list);
extern char* rmldb_str_list_get_index(rmldb_str_list_t* list, int index);
extern rmldb_LISTty_t* rmldb_get_type_components(rmldb_con_db_t* con_db);
extern rmldb_type_t* rmldb_get_type_component(rmldb_type_t* type, int constr, int index);
extern rmldb_type_t* rmldb_get_type_comp_from_con(rmldb_LISTty_t* type, int index);
extern void rmldb_var_show(void *p, rmldb_type_t* type, int depth);
extern void rmldb_var_send(void *p, rmldb_type_t* type, int depth);
extern void rmldb_open_socket(void);
extern void rmldb_close_socket(void);
extern void rmldb_socket_outln(char* msg);
extern void rmldb_socket_out(char* msg);
extern void rmldb_type_list_to_sock(rmldb_LISTty_t* list, int detailed, char* separator);
extern void rmldb_type_to_sock(rmldb_type_t *type, int detailed);


/* ---- components ---- */
/* create a list from two tys */
extern rmldb_LISTty_t* rmldb_make_rmldb_LISTty(rmldb_type_t* type1, rmldb_type_t* type2);
/* appends ty in front of the list */
extern rmldb_LISTty_t* rmldb_make_cons_rmldb_LISTty(rmldb_type_t* type, rmldb_LISTty_t* list);
/* make a VARty */
extern rmldb_VARty_t* rmldb_make_rmldb_VARty(char* id);
/* make a CONSty */
extern rmldb_CONSty_t* rmldb_make_rmldb_CONSty(rmldb_LISTty_t* list, char* id);
/* make a TUPLEty */
extern rmldb_TUPLEty_t* rmldb_make_rmldb_TUPLEty(rmldb_LISTty_t* list);
/* make a RELty */
extern rmldb_RELty_t* rmldb_make_rmlRELty(rmldb_LISTty_t* list1, rmldb_LISTty_t* list2);

/* makes a type from a component, and casts it according to kind */
extern rmldb_type_t* rmldb_make_rmldb_type(rmldb_tyKind_t kind, void* component);

extern rmldb_str_t* rmldb_make_rmldb_str(char* name);

extern rmldb_var_db_t* rmldb_make_rmldb_var_db(
		char* file,
		rmldb_range_db_t* range,
		rmldb_range_db_t* clause_range,
		char* relation,
		char* name,
		rmldb_type_db_t* type_db);

extern rmldb_con_db_t* rmldb_make_rmldb_con_db(
		char* file,
		rmldb_range_db_t* range,
		char* name,
		rmldb_type_db_t* type_db,
		int constructor);

extern rmldb_type_db_t* rmldb_make_rmldb_type_db(
		char* file,
		rmldb_range_db_t* range,
		char* name);

extern rmldb_type_db_t* rmldb_make_rmldb_type_db_t(
		rmldb_type_t *type);

extern rmldb_relation_db_t* rmldb_make_rmldb_relation_db(
		char* file,
		rmldb_range_db_t* range,
		char* name,
		rmldb_type_db_t* type_db);

extern void rmldb_type_list_push_front(
					rmldb_type_t **start_node, 
				    rmldb_type_t **end_node, 
					rmldb_type_t *node);

extern void rmldb_type_list_push_back(
					rmldb_type_t **start_node, 
				    rmldb_type_t **end_node, 
					rmldb_type_t *node);

extern void rmldb_str_list_add(
					rmldb_str_t **start_node, 
				    rmldb_str_t **end_node, 
					rmldb_str_t *node);

extern void rmldb_var_db_add(
					rmldb_var_db_t **start_node, 
				    rmldb_var_db_t **end_node, 
					rmldb_var_db_t *node);

extern void rmldb_con_db_add(
					rmldb_con_db_t **start_node, 
				    rmldb_con_db_t **end_node, 
					rmldb_con_db_t *node);

extern void rmldb_type_db_add(
					rmldb_type_db_t **start_node, 
				    rmldb_type_db_t **end_node, 
					rmldb_type_db_t *node);

extern void rmldb_relation_db_add(
					rmldb_relation_db_t **start_node, 
				    rmldb_relation_db_t **end_node, 
					rmldb_relation_db_t *node);

/* program database stream */
extern FILE* aarmldbin; /* the stream we need to parse from the rmldebugger */
extern int   aarmldberror(char*);
extern int   aarmldbparse(void);
extern int   aarmldbdebug;
extern int   aarmldb_lineno;

/* comand stream */
extern FILE* aain; /* the stream we need to parse from the rmldebugger */
extern int   aaerror(char*);
extern int   aaparse(void);
extern int   aadebug;

int  rmldb_open_new_file(void);
void rmldb_use_quit (int);
int  rmldb_parse(void);

#endif /* _RML_DEBUG_H_  */

#endif /* _RMLDB_DEFINED_ */
/* please LEAVE this line here */
