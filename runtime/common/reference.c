/* references.c */
#include <stdio.h>
#include "rml.h"

/* two references are equal or not */
RML_BEGIN_LABEL(RML__reference_5feq)
{
    rmlA0 = RML_PRIM_REF_EQ(rmlA0, rmlA1);
    RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

/*
 * adrpo: return the pointer of a value as integer
 */
RML_BEGIN_LABEL(RML__reference_5finteger)
{
  rmlA0 = RML_PRIM_REF_INT(rmlA0);
  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL


/* indexes from 1 */
RML_BEGIN_LABEL(RML__reference_5fupdate)
{
#ifndef NON_DESTRUCTIVE_ARRAY_IMPLEMENTATION
  rml_uint_t nelts = 0;
  void *arr = rmlA0;
  void *data;
  rml_uint_t idx = 0;
  rml_uint_t i = (rml_uint_t)RML_UNTAGFIXNUM(rmlA1) - 1;
  if( i >= RML_HDRSLOTS(RML_GETHDR(arr)) ) 
  {
    RML_TAILCALLK(rmlFC);
  } 

  /* update the reference in place */
  RML_STRUCTDATA(arr)[i] = rmlA2;
  /* IF the object updated is not immediate add 
    * the reference address to the roots to be swept for pointers
    * pointing in the newer generation
    */
  if (!RML_ISIMM(rmlA2))
  {
    /* also check here if the reference AND the element is in the young generation */
    /*
    printf("\n%p < %p < %p < %p\n", rml_young_region, RML_UNTAGPTR(rmlA0), RML_UNTAGPTR(rmlA2), rml_young_limit); 
    */
    /* check if both are in the young generation */
    /*
    if(RML_UNTAGPTR(rmlA0) - (void*)(rml_young_region) >= 0 &&
      (void*)(rml_young_limit) - RML_UNTAGPTR(rmlA0) > 0 && 
      RML_UNTAGPTR(rmlA2) - (void*)(rml_young_region) >= 0 &&
      (void*)(rml_young_limit) - RML_UNTAGPTR(rmlA2) > 0)
    {
      rmlA0 = arr;
      RML_TAILCALLK(rmlSC);
    }
    */
    /* also check here if the reference is not already in the trail */
    for (idx = rml_array_trail_size; &rml_array_trail[idx] >= rmlATP; idx--)
    if (rml_array_trail[idx] == rmlA0) /* if found, do not add again */
    {
      rmlA0 = arr;
      RML_TAILCALLK(rmlSC);
    }
    /* add the address of the reference into the roots to be
    taken into consideration at the garbage collection time */
    if( rmlATP == &rml_array_trail[0] ) 
    {
      (void)fprintf(stderr, "Array Trail Overflow!\n");
      rml_exit(1);
    }
    *--rmlATP = rmlA0;
  }
  rmlA0 = arr;
  RML_TAILCALLK(rmlSC);

#else /* non destructive reference implementation (using copy) */

  rml_uint_t nelts = 0;
  void *vec = rmlA0;
  void *data;
  rml_uint_t i = (rml_uint_t)RML_UNTAGFIXNUM(rmlA1) - 1;
  nelts = RML_HDRSLOTS(RML_GETHDR(vec));
  if( i >= nelts ) 
  {
    RML_TAILCALLK(rmlFC);
  } 
  else 
  {
    /* first copy the old reference */
    struct rml_struct *vec_new = (struct rml_struct*)rml_prim_alloc(1+nelts, 3);
    void **vecp = vec_new->data;
    rml_uint_t idx = 0;
    /* re-read after alloc, it may have been moved */
    vec = rmlA0;
    vec_new->header = RML_GETHDR(rmlA0); /* set the old header */
    rmlA0 = RML_TAGPTR(vec_new);
    for(idx=0; idx < nelts; idx++)
      *vecp++ = RML_STRUCTDATA(vec)[idx];
    RML_STRUCTDATA(rmlA0)[i] = rmlA2;
  }
  RML_TAILCALLK(rmlSC);

#endif
}
RML_END_LABEL

/* indexes from 0 */
RML_BEGIN_LABEL(RML__reference_5fsetnth)
{
#ifndef NON_DESTRUCTIVE_ARRAY_IMPLEMENTATION
  rml_uint_t nelts = 0;
  void *arr = rmlA0;
  void *data;
  rml_uint_t idx = 0;
  rml_uint_t i = (rml_uint_t)RML_UNTAGFIXNUM(rmlA1);
  if( i >= RML_HDRSLOTS(RML_GETHDR(arr)) ) 
  {
    RML_TAILCALLK(rmlFC);
  } 

  /* update the reference in place */
  RML_STRUCTDATA(arr)[i] = rmlA2;
  /* IF the object updated is not immediate add 
    * the reference address to the roots to be swept for pointers
    * pointing in the newer generation
    */
  if (!RML_ISIMM(rmlA2))
  {
    /* also check here if the reference AND the element is in the young generation */
    /*
    printf("\n%p < %p < %p < %p\n", rml_young_region, RML_UNTAGPTR(rmlA0), RML_UNTAGPTR(rmlA2), rml_young_limit); 
    */
    /* check if both are in the young generation */
    /*
    if(RML_UNTAGPTR(rmlA0) - (void*)(rml_young_region) >= 0 &&
      (void*)(rml_young_limit) - RML_UNTAGPTR(rmlA0) > 0 && 
      RML_UNTAGPTR(rmlA2) - (void*)(rml_young_region) >= 0 &&
      (void*)(rml_young_limit) - RML_UNTAGPTR(rmlA2) > 0)
    {
      rmlA0 = arr;
      RML_TAILCALLK(rmlSC);
    }
    */
    /* also check here if the reference is not already in the trail */
    for (idx = rml_array_trail_size; &rml_array_trail[idx] >= rmlATP; idx--)
    if (rml_array_trail[idx] == rmlA0) /* if found, do not add again */
    {
      rmlA0 = arr;
      RML_TAILCALLK(rmlSC);
    }
    /* add the address of the reference into the roots to be
    taken into consideration at the garbage collection time */
    if( rmlATP == &rml_array_trail[0] ) 
    {
      (void)fprintf(stderr, "Array Trail Overflow!\n");
      rml_exit(1);
    }
    *--rmlATP = rmlA0;
  }
  rmlA0 = arr;
  RML_TAILCALLK(rmlSC);

#else /* non destructive reference implementation (using copy) */

  rml_uint_t nelts = 0;
  void *vec = rmlA0;
  void *data;
  rml_uint_t i = (rml_uint_t)RML_UNTAGFIXNUM(rmlA1);
  nelts = RML_HDRSLOTS(RML_GETHDR(vec));
  if( i >= nelts ) 
  {
    RML_TAILCALLK(rmlFC);
  } 
  else 
  {
    /* first copy the old reference */
    struct rml_struct *vec_new = (struct rml_struct*)rml_prim_alloc(1+nelts, 3);
    void **vecp = vec_new->data;
    rml_uint_t idx = 0;
    /* re-read after alloc, it may have been moved */
    vec = rmlA0;
    vec_new->header = RML_GETHDR(rmlA0); /* set the old header */
    rmlA0 = RML_TAGPTR(vec_new);
    for(idx=0; idx < nelts; idx++)
      *vecp++ = RML_STRUCTDATA(vec)[idx];
    RML_STRUCTDATA(rmlA0)[i] = rmlA2;
  }
  RML_TAILCALLK(rmlSC);

#endif
}
RML_END_LABEL

/* sharing */
RML_BEGIN_LABEL(RML__reference_5fshare)
{
  rml_uint_t idx;
  void *a = NULL, *b = NULL;

  if( rmlSTP == &rml_share_trail[0][2] ) /* if we have no more place, don't bother */
    RML_TAILCALLK(rmlSC);

  if (rmlA0 == rmlA1) /* if they are equal, don't bother to share! */
    RML_TAILCALLK(rmlSC);

  if (RML_ISIMM(rmlA0) || RML_ISIMM(rmlA1)) /* if they are immediate, don't bother to share! */
    RML_TAILCALLK(rmlSC);

  /* a < b */
  if (rmlA0 < rmlA1)
  {
    a = rmlA0;
    b = rmlA1;
  }
  else
  {
    a = rmlA1;
    b = rmlA0;
  }

  /* if we have a, b in the share do not add it */
  for (idx = rml_share_trail_size; &rml_share_trail[idx][2] >= rmlSTP; idx--)
    if ( rml_share_trail[idx][1] == a && rml_share_trail[idx][2] == b )
      RML_TAILCALLK(rmlSC);

  /* store the equal references to be shared */
  *--rmlSTP = b;
  *--rmlSTP = a;
  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

