#include <string.h>
#include <stdio.h>
#include "rml.h"

#define RML_MAX(x,y) ( (x) > (y) ? (x) : (y) )

/* 1024 global roots */
void         *rml_global_roots_trail[1024] = {0};
rml_uint_t    rml_global_roots_trail_size = 1024;
rml_uint_t    rml_global_roots_trail_index_max = 0;

/* forward my external roots */
void rml_roots_gc(struct rml_xgcstate *state)
{
  if (rml_global_roots_trail_index_max > 0) /* if not zero */
    rml_roots_gc_callback(state, rml_global_roots_trail, rml_global_roots_trail_index_max*sizeof(void*));
}

RML_BEGIN_LABEL(RML__set_5fglobal_5froot)
{
  rml_uint_t i = RML_UNTAGFIXNUM(rmlA0);
  
  if (rml_trace_enabled)
  {
    fprintf(stderr, "RML.setGlobalRoot\n"); fflush(stderr);
  }
  
  if (i >= rml_global_roots_trail_size)
    RML_TAILCALLK(rmlFC);
  
  rml_global_roots_trail[i] = rmlA1;
  
  /* remember the max */
  rml_global_roots_trail_index_max = RML_MAX(rml_global_roots_trail_index_max, i+1);
  
  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

RML_BEGIN_LABEL(RML__get_5fglobal_5froot)
{
  rml_uint_t i = RML_UNTAGFIXNUM(rmlA0);
  
  if (rml_trace_enabled)
  {
    fprintf(stderr, "RML.getGlobalRoot\n"); fflush(stderr);
  }
  
  if ((i > (rml_global_roots_trail_index_max-1)) || /* index bigger than the ones already added */
      (i >= rml_global_roots_trail_size))           /* index bigger than our roots max */
    RML_TAILCALLK(rmlFC);
  
  rmlA0 = rml_global_roots_trail[i];
  
  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

