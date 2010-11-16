/* lvar_get.c */
#include <stdio.h>
#include "rml.h"

RML_BEGIN_LABEL(RML__lvar_5fget)
{
  if( RML_GETHDR(rmlA0) == RML_BOUNDHDR ) 
  {
    struct rml_struct *option = (struct rml_struct*)rml_prim_alloc(2, 1);
    RML_CHECK_POINTER(option, RML__lvar_5fget, "RML.lvarGet");

    option->header = RML_SOMEHDR;
    option->data[0] = RML_REFDATA(rmlA0);
    rmlA0 = RML_TAGPTR(option);
  } 
  else
    rmlA0 = rml_prim_none_tagged;
  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

/* lvar_new.c */
RML_BEGIN_LABEL(RML__lvar_5fnew)
{
  struct rml_ref *lvar = (struct rml_ref*)rml_prim_alloc(2, 0);
  RML_CHECK_POINTER(lvar, RML__lvar_5fnew, "RML.lvarNew");
    
  lvar->header = RML_UNBOUNDHDR;
  /* lvar->data need not be initialized */
  rmlA0 = RML_TAGPTR(lvar);
  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

/* lvar_set.c */
RML_BEGIN_LABEL(RML__lvar_5fset)
{
  void *lvar = rmlA0;
  if( RML_GETHDR(lvar) == RML_UNBOUNDHDR ) 
  {
    RML_GETHDR(lvar) = RML_BOUNDHDR;
    RML_REFDATA(lvar) = rmlA1;
    if( rmlTP == &rml_trail[0] ) 
    {
      (void)fprintf(stderr, "Trail overflow!\n");
      rml_exit(1);
    }
    *--rmlTP = lvar;
    RML_TAILCALLK(rmlSC);
  } 
  else
    RML_TAILCALLK(rmlFC);
}
RML_END_LABEL
