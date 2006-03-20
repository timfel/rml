/* misc_print.c */
#include <stdio.h>
#include "rml.h"

RML_BEGIN_LABEL(RML__debug)
{
#ifdef RML_DEBUG
	/*
	   * A0=fileName:string
	   * A1=sline:int, A2=scolumn:int, A3=eline:int, A4=ecolumn:int
	   * A5=relation:string
	   * A6=goal:string
	*/
    int i;
    void *str = rmlA0;
    void *strrel = rmlA5; void *strgoal = rmlA6; 
    char s[RMLDB_MAX_STRING] = ""; 
    snprintf(s, RMLDB_MAX_STRING, "%s:%d.%d.%d.%d within[%s] -> [%s]", 
				RML_STRINGDATA(str),		/* file */ 
				RML_UNTAGFIXNUM(rmlA1),		/* start line */
				RML_UNTAGFIXNUM(rmlA2),		/* start column */
				RML_UNTAGFIXNUM(rmlA3),		/* end line */
				RML_UNTAGFIXNUM(rmlA4),     /* end column */
				RML_STRINGDATA(strrel),     /* relation */
				RML_STRINGDATA(strgoal)     /* goal (term) */
				);	

	if (rmldb_execution_type == RMLDB_TRACE_CALLS ||
		rmldb_execution_type == RMLDB_TRACE_ALL)
	{
		if (rmldb_execution_type == RMLDB_TRACE_CALLS)
		{
			rmldb_sprintf("%s\n",s);
			rmldb_clear_vars();
			RML_TAILCALLK(rmlSC);
		}

		char b[RMLDB_MAX_STRING] = "";
		/* updating the execution location -- needed for type reconstruction */
		snprintf(rmldb_current_execution_loc.file, RMLDB_MAX_STRING, "%s", RML_STRINGDATA(str)); 
        snprintf(rmldb_current_execution_loc.relation, RMLDB_MAX_STRING, "%s", RML_STRINGDATA(strrel));
        snprintf(rmldb_current_execution_loc.goal, RMLDB_MAX_STRING, "%s", RML_STRINGDATA(strgoal));
		rmldb_current_execution_loc.range.sl = RML_UNTAGFIXNUM(rmlA1),	/* start line */
		rmldb_current_execution_loc.range.sc = RML_UNTAGFIXNUM(rmlA2),	/* start column */
		rmldb_current_execution_loc.range.el = RML_UNTAGFIXNUM(rmlA3),	/* end line */
		rmldb_current_execution_loc.range.ec = RML_UNTAGFIXNUM(rmlA4),   /* end column */
		rmldb_current_execution_loc.SP = rmldb_stack_pointer_to_ulong(rml_state_SP); 

        rmldb_sprintf ("\n%s", RML_STRINGDATA(str));    
        rmldb_sprintf (":"); rmldb_sprintf ("%d", RML_UNTAGFIXNUM(rmlA1));
        rmldb_sprintf ("."); rmldb_sprintf ("%d", RML_UNTAGFIXNUM(rmlA2));
        rmldb_sprintf ("@%s", RML_STRINGDATA(strrel));
        rmldb_sprintf ("@%s", RML_STRINGDATA(strgoal));
        /* this is for emacs-mode */
        snprintf(b, RMLDB_MAX_STRING, "\n@%s:%d.%d.%d.%d within[%s] -> [%s]\n", 
				RML_STRINGDATA(str),		/* file */ 
				RML_UNTAGFIXNUM(rmlA1),		/* start line */
				RML_UNTAGFIXNUM(rmlA2),		/* start column */
				RML_UNTAGFIXNUM(rmlA3),		/* end line */
				RML_UNTAGFIXNUM(rmlA4),     /* end column */
				RML_STRINGDATA(strrel),     /* relation */
				RML_STRINGDATA(strgoal)     /* goal (term) */
				);
        rmldb_sprintf("%s", b);
		rmldb_trace_vars();
		rmldb_clear_vars();
		RML_TAILCALLK(rmlSC);
	}

	/*
	printf("Here: %s\n-start-stack-\n", s);
	for (i = rml_stack_size; &rml_stack[i] >= (void**)rml_state_SP; i--)
	{
		printf("%.6d : ", i);
		rmldb_var_print(rml_stack[i]);
		printf("\n");
	}
	printf("-end-stack-");
	*/
    if (rmldb_number_of_filters != 0)
    {
        for (i = 0; i < rmldb_number_of_filters; i++)
            if (strstr(s, rmldb_relation_filter[i]) != NULL)
            {
                printf("\nBreakpoint [%d], on %s reached", i, rmldb_relation_filter[i]);
                rmldb_execution_type = RMLDB_STEP;
                rmldb_show = RMLDB_SHOW;
                break;
            }
    }

    if (rmldb_execution_type != RMLDB_FAST) 
	{
		/* if the stack shrinked, remove the last one */
		if (rmldb_stack_pointer_to_ulong(rml_state_SP) <= rmldb_current_execution_loc.SP)
			 rmldb_backtrace_pop();
	}
	/* printf("%s\n", s); */
	if (rmldb_execution_type == RMLDB_NEXT) /* do we jump over the goal? */
	{
		/* test if we reached back from where we started */
		if (rmldb_stack_pointer_to_ulong(rml_state_SP) <= 
			rmldb_current_execution_loc.SP) /* break */
			rmldb_execution_type = RMLDB_STEP;
	}
    /* test if we are stepping */
    if (rmldb_execution_type == RMLDB_STEP) /* do we step? */
    {
		char b[RMLDB_MAX_STRING] = "";
		/* updating the execution location -- needed for type reconstruction */
		snprintf(rmldb_current_execution_loc.file, RMLDB_MAX_STRING, "%s", RML_STRINGDATA(str)); 
        snprintf(rmldb_current_execution_loc.relation, RMLDB_MAX_STRING, "%s", RML_STRINGDATA(strrel));
        snprintf(rmldb_current_execution_loc.goal, RMLDB_MAX_STRING, "%s", RML_STRINGDATA(strgoal));
		rmldb_current_execution_loc.range.sl = RML_UNTAGFIXNUM(rmlA1),	/* start line */
		rmldb_current_execution_loc.range.sc = RML_UNTAGFIXNUM(rmlA2),	/* start column */
		rmldb_current_execution_loc.range.el = RML_UNTAGFIXNUM(rmlA3),	/* end line */
		rmldb_current_execution_loc.range.ec = RML_UNTAGFIXNUM(rmlA4),   /* end column */
		rmldb_current_execution_loc.SP = rmldb_stack_pointer_to_ulong(rml_state_SP); 

        rmldb_sprintf ("\n%s", RML_STRINGDATA(str));    
        rmldb_sprintf (":"); rmldb_sprintf ("%d", RML_UNTAGFIXNUM(rmlA1));
        rmldb_sprintf ("."); rmldb_sprintf ("%d", RML_UNTAGFIXNUM(rmlA2));
        rmldb_sprintf ("@%s", RML_STRINGDATA(strrel));
        rmldb_sprintf ("@%s", RML_STRINGDATA(strgoal));
        /* this is for emacs-mode */
        snprintf(b, RMLDB_MAX_STRING, "\n@%s:%d.%d.%d.%d within[%s] -> [%s]\n", 
				RML_STRINGDATA(str),		/* file */ 
				RML_UNTAGFIXNUM(rmlA1),		/* start line */
				RML_UNTAGFIXNUM(rmlA2),		/* start column */
				RML_UNTAGFIXNUM(rmlA3),		/* end line */
				RML_UNTAGFIXNUM(rmlA4),     /* end column */
				RML_STRINGDATA(strrel),     /* relation */
				RML_STRINGDATA(strgoal)     /* goal (term) */
				);
        rmldb_sprintf("%s", b);
		if (rmldb_print_livevars_each_step)
			rmldb_print_vars();
		rmldb_print_displayvars();
        /* parse a command */
        rmldb_parse();
    }
    /* add the next node in stack */
    if (rmldb_execution_type != RMLDB_FAST) 
	{
		rmldb_backtrace_push(s, rmldb_current_execution_loc);
		rmldb_callchain_push(s, rmldb_current_execution_loc);
	}
	if (rmldb_execution_type != RMLDB_FAST) rmldb_clear_vars();

#endif /* RML_DEBUG */

	RML_TAILCALLK(rmlSC);
}
RML_END_LABEL
