#include "rml.h"

/* bool_and.c */
RML_BEGIN_LABEL(RML__bool_5fand)
{
    rmlA0 = RML_PRIM_BOOL_AND(rmlA0, rmlA1);
    RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

/* bool_not.c */
RML_BEGIN_LABEL(RML__bool_5fnot)
{
    rmlA0 = RML_PRIM_BOOL_NOT(rmlA0);
    RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

/* bool_or.c */
RML_BEGIN_LABEL(RML__bool_5for)
{
    rmlA0 = RML_PRIM_BOOL_OR(rmlA0, rmlA1);
    RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

RML_BEGIN_LABEL(RML__bool_5feq)
{
    rmlA0 = RML_PRIM_INT_EQ(rmlA0, rmlA1);
    RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

static const RML_DEFSTRINGLIT(rml_true_str_literal,  4, "true");
static const RML_DEFSTRINGLIT(rml_false_str_literal, 5, "false");

RML_BEGIN_LABEL(RML__bool_5fstring)
{
    rmlA0 = (RML_UNTAGFIXNUM(rmlA0)) ? RML_REFSTRINGLIT(rml_true_str_literal) : 
                                       RML_REFSTRINGLIT(rml_false_str_literal);
    RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

