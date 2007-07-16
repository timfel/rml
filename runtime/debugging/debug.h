/******************************************************************************
 * @author Adrian Pop [adrpo@ida.liu.se, http://www.ida.liu.se/~adrpo]
 * Copyright (c) 2002-2007, Adrian Pop [adrpo@ida.liu.se],
 * Programming Environments Laboratory (PELAB),
 * Department of Computer and Information Science (IDA), 
 * Link�pings University (LiU). 
 * All rights reserved.
 *
 * http://www.ida.liu.se/~adrpo/license/
 */
/***********************************************************
 [ debug.h ] 
  - Adrian Pop, adrpo@ida.liu.se, http://www.ida.liu.se/~adrpo
  - creation 2002-10
    + interface for rml debugging 
    + this file contains all the functions for debugging 
	+ all things in this file start with rmldb_
  - last modified 2005-12-27
************************************************************/
#ifndef _RML_DEBUG_H_
#define _RML_DEBUG_H_
/* all these functions depends on RML_DEBUG macro */
/************************************************************/

#ifdef RML_DEBUG

#include <stdio.h>
#include <string.h>

/* this file will be included in the generated rml.h */
/* adrpo some useful defines. */
#define RMLDB_SUCCESS  1
#define RMLDB_FAILURE -1

#define RMLDB_PROMPT "rml+mmc db@>"
#define RMLDB_RUN    		0
#define RMLDB_STEP   		1
#define RMLDB_STEP_OVER		2
#define RMLDB_STEP_RETURN	3
#define RMLDB_BREAKPOINT	4
#define RMLDB_TRACE_CALLS	5

#define RMLDB_VAR_IN 0
#define RMLDB_VAR_OUT 1

extern int   rmldb_execution_type;
extern int   rmldb_execution_startup_type;
extern int   rmldb_last_command; /* need to know if we should start running or get more commands from the debugger */
extern int   rmldb_depth_of_variable_print;
extern int   rmldb_max_string_variable_print;
/* location of current execution point */
extern       rmldb_current_execution_loc_t rmldb_current_execution_loc;

/* init/help/exit */
extern int  rmldb_init(void);
extern int  rmldb_end(void);
extern void rmldb_exit(int status);
extern int  rmldb_quit(char *line);

/* breakpoints */
extern int rmldb_handle_breakpoint_request(rmldb_command_type* cmd);

/* variables */
extern int rmdlb_handle_variable_request(rmldb_command_type* cmd);

/* stack */
extern int rmdlb_handle_stack_request(rmldb_command_type* cmd);
extern int rmldb_push_stack_frame(
			char* file, 
			int charStart, int charEnd, 
			int startLine, int startColumn, int endLine, int endColumn,					  
			char* function,
			char* call);
extern int rmldb_pop_stack_frame(char gototype);

#endif /* RML_DEBUG */

#endif /* _RML_DEBUG_H_  */

