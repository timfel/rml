/* int_eq.c */
#include "rml.h"

RML_BEGIN_LABEL(RML__int_5feq)
{
    rmlA0 = RML_PRIM_INT_EQ(rmlA0, rmlA1);
    RML_TAILCALLK(rmlSC);
}
RML_END_LABEL
