/* value.c */
#include <stdio.h>
#include "rml.h"

RML_BEGIN_LABEL(RML__value_5fconstructor)
{
  /* if the value is immediate, we return it */
  if (RML_ISIMM(rmlA0))
    RML_TAILCALLK(rmlSC);
  /* otherwise we return the header constructor */
  rmlA0 = RML_IMMEDIATE(RML_TAGFIXNUM(RML_HDRCTOR(RML_GETHDR(rmlA0))));
  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

RML_BEGIN_LABEL(RML__value_5fslots)
{
  /* if the value is immediate, we return 0 */
  if (RML_ISIMM(rmlA0))
  {
    rmlA0 = RML_IMMEDIATE(RML_TAGFIXNUM(0));
    RML_TAILCALLK(rmlSC);
  }
  /* otherwise we return the header slots */
  rmlA0 = RML_IMMEDIATE(RML_TAGFIXNUM(RML_HDRSLOTS(RML_GETHDR(rmlA0))));
  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

RML_BEGIN_LABEL(RML__value_5feq)
{
  rmlA0 = RML_PRIM_VAL_EQ(rmlA0, rmlA1);
  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

RML_BEGIN_LABEL(RML__value_5fmatch)
{
  rmlA0 = RML_PRIM_VAL_MATCH(rmlA0, rmlA1);
  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

/*
 * implements polymorphic equality for RML
 * This is the reason why reference nodes must
 * still be distinguishable from all other values.
 */
#if defined(_MSC_VER)
/* #define inline __inline */
#else // Linux & MinGW
#define inline inline
#endif

inline void *rml_prim_equal(void *p, void *q)
{
  tail_recur:
    /* INV: ISIMM(p) <==> ISIMM(q) */
  if( p == q ) {
    /* Identical objects are always equal. */
    return RML_TRUE;
  } else if( RML_ISIMM(p) ) {
    /* Different immediate values. */
    return RML_FALSE;
  } else {
    /* Non-identical boxed values. */
    rml_uint_t phdr = RML_GETHDR(p);
    rml_uint_t qhdr = RML_GETHDR(q);

    if( phdr == qhdr ) {
      if( phdr == RML_REALHDR ) {
        return (rml_prim_get_real(p) == rml_prim_get_real(q))
            ? RML_TRUE
            : RML_FALSE;
      } else if( RML_HDRISSTRING(phdr) ) {
               if( !memcmp(RML_STRINGDATA(p), RML_STRINGDATA(q), RML_HDRSTRLEN(phdr)) )
                 return RML_TRUE;
               else
                 return RML_FALSE;
             } else if( RML_HDRISSTRUCT(phdr) ) {
                      rml_uint_t slots = RML_HDRSLOTS(phdr);
                      void **pp = RML_STRUCTDATA(p);
                      void **qq = RML_STRUCTDATA(q);
                      if( slots == 0 )
                        return RML_TRUE;
                      while ( --slots > 0)
                      {
                        if( rml_prim_equal(*pp++, *qq++) == RML_FALSE )
                          return RML_FALSE;
                      } /* end while */
                      p = *pp;
                      q = *qq;
                      goto tail_recur;
                    } else {
                      /* Non-identical reference nodes. */
                      return RML_FALSE;
                    }
             } else {
               /* Different sized strings, different constructors of some datatype,
                * or reference nodes with different instantiation states.
                */
               return RML_FALSE;
             }
  }
}
