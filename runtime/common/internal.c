/* defines.c */
#include <stdio.h>
#include <string.h>
#include "rml.h"

char rml_debug_enabled  = 0;
char rml_trace_enabled  = 0;
char rml_string_sharing = 0;
char rml_stack_overflow = 0;

/* p_nil.c */
const struct rml_header rml_prim_nil  = { RML_NILHDR };
void* rml_prim_nil_tagged = RML_TAGPTR(&rml_prim_nil);
/* p_none.c */
const struct rml_header rml_prim_none = { RML_NONEHDR };
void* rml_prim_none_tagged = RML_TAGPTR(&rml_prim_none);

/* p_unwind.c */
void rml_prim_unwind_(void **saveTP)    /* PRE: rmlTP < saveTP */
{
    void **TP = rml_state_TP;
    do { RML_GETHDR(*TP) = RML_UNBOUNDHDR; } while( ++TP < saveTP );
    rml_state_TP = TP;
}

RML_BEGIN_LABEL(RML__if_5fexp)
{
    if (RML_UNTAGFIXNUM(rmlA0))
        rmlA0 = rmlA1;
    else
        rmlA0 = rmlA2;
    RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

/* misc_tick.c */
RML_BEGIN_LABEL(RML__tick)
{
    static rml_sint_t counter;
    rmlA0 = RML_IMMEDIATE(RML_TAGFIXNUM(counter));
    ++counter;
    RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

/* misc_unique.c */
#define RML_COUNTERS_MAX 50
rml_sint_t counters[RML_COUNTERS_MAX] = {0};
RML_BEGIN_LABEL(RML__unique)
{
  rml_uint_t index = RML_UNTAGFIXNUM(rmlA0);
  if (index >= RML_COUNTERS_MAX)
    RML_TAILCALLK(rmlSC);
  
  rmlA0 = RML_IMMEDIATE(RML_TAGFIXNUM(counters[index]));
  ++(counters[index]);
  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

void rmldb_var_print(void *p)
{
    /* printf("[%p]", p); */
    if (!p) { printf ("NIL"); fflush(stdout); return; }
    if( RML_ISIMM(p) ) 
    {
        printf ("%ld", (long)RML_UNTAGFIXNUM(p));    
    } 
    else 
    {
        rml_uint_t phdr = RML_GETHDR(p);            
        if( phdr == RML_REALHDR ) 
        {
            printf ("%f", rml_prim_get_real(p));
            fflush(stdout);
        } else 
            if( RML_HDRISSTRING(phdr) ) 
            {
                printf ("\"%s\"", RML_STRINGDATA(p));
                fflush(stdout);
                /* use if neccesarry RML_HDRSTRLEN(phdr) */
            } else 
                if( RML_HDRISSTRUCT(phdr) ) 
                {
                    rml_uint_t slots = RML_HDRSLOTS(phdr);
                    rml_uint_t constr = RML_HDRCTOR(phdr);
                    void **pp = NULL;
                    if (slots == 0)
                    {
		        printf ("{S(%ld)[%ld]=NIL}", (long)constr, (long)slots);
                        fflush(stdout);
                        return;
                    }
                    
                    printf ("S(%ld)[%ld](", (long)constr, (long)slots);

                    pp = RML_STRUCTDATA(p);
                    fflush(stdout);
                    // function definition
                    if ((constr == 64 || constr==13) &&
                        slots > 1000000) return;
                    if( slots != 0 )
                    {
                        // printf ("\n\t"); 
                        while( --slots > 0 )
                        {
                            rmldb_var_print(*pp++);
                            printf (",");
                            fflush(stdout);
                        }
                        p = *pp; 
                        rmldb_var_print(*pp); printf (")"); fflush(stdout);
                        // goto tail_recur_debug;  
                    }                        
                } 
                else 
                {
                    printf ("UNKNOWN"); fflush(stdout);
                }
    }
}

