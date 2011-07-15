#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <math.h>
#include <errno.h>
#include "rml.h"

/* p_mkreal.c */
void *rml_prim_mkreal(double d)
{
  rml_uint_t nwords = RML_SIZE_DBL/RML_SIZE_INT + 1;
  struct rml_real *p = (struct rml_real*)rml_prim_alloc(nwords, 0);
  if (!p) /* return null */
    return NULL;
  
  rml_prim_set_real(p, d);
  p->header = RML_REALHDR;
  return RML_TAGPTR(p);
}

/* p_get_real.c */
#ifdef  RML_DBL_STRICT
double rml_prim_get_real(void *p)
{
  union rml_double_as_words u;
  u.data[0] = RML_REALDATA(p)[0];
  u.data[1] = RML_REALDATA(p)[1];
  return u.d;
}
#endif  /* RML_DBL_STRICT */

/* p_set_real.c */
#ifdef  RML_DBL_STRICT
void rml_prim_set_real(struct rml_real *p, double d)
{
  union rml_double_as_words u;
  u.d = d;
  p->data[0] = u.data[0];
  p->data[1] = u.data[1];
}
#endif  /* RML_DBL_STRICT */

/* real_abs.c */
RML_BEGIN_LABEL(RML__real_5fabs)
{
  double d = rml_prim_get_real(rmlA0);
  void *x = NULL;
  if( d < 0.0 )
  {
    x = rml_prim_mkreal(-d);
    RML_CHECK_POINTER(x, RML__real_5fabs, "RML.realAbs");

    rmlA0 = x;
  }
  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

/* real_add.c */
RML_BEGIN_LABEL(RML__real_5fadd)
{
  double d0 = rml_prim_get_real(rmlA0);
  double d1 = rml_prim_get_real(rmlA1);
  void* x = NULL;

  x = rml_prim_mkreal(d0 + d1);
  RML_CHECK_POINTER(x, RML__real_5fadd, "RML.realAdd");

  rmlA0 = x;
  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

/* real_atan.c */
RML_BEGIN_LABEL(RML__real_5fatan)
{
  void* x = rml_prim_mkreal(atan(rml_prim_get_real(rmlA0)));
  RML_CHECK_POINTER(x, RML__real_5fatan, "RML.realAtan");

  rmlA0 = x;
  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

/* real_cos.c */
RML_BEGIN_LABEL(RML__real_5fcos)
{
  rmlA0 = rml_prim_mkreal(cos(rml_prim_get_real(rmlA0)));
  RML_CHECK_POINTER(rmlA0, RML__real_5fcos, "RML.realCos");
  
  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

/* real_div.c */
RML_BEGIN_LABEL(RML__real_5fdiv)
{
  double d0 = rml_prim_get_real(rmlA0);
  double d1 = rml_prim_get_real(rmlA1);
  
  if( d1 == 0.0 )
    RML_TAILCALLK(rmlFC);
  
  rmlA0 = rml_prim_mkreal(d0 / d1);
  RML_CHECK_POINTER(rmlA0, RML__real_5fdiv, "RML.realDiv");

  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

/* real_eq.c */
RML_BEGIN_LABEL(RML__real_5feq)
{
  double d0 = rml_prim_get_real(rmlA0);
  double d1 = rml_prim_get_real(rmlA1);
  
  rmlA0 = (d0 == d1) ? RML_TRUE : RML_FALSE;
  
  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

/* real_exp.c */
RML_BEGIN_LABEL(RML__real_5fexp)
{
  rmlA0 = rml_prim_mkreal(exp(rml_prim_get_real(rmlA0)));
  RML_CHECK_POINTER(rmlA0, RML__real_5fexp, "RML.realExp");

  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

/* real_floor.c */
RML_BEGIN_LABEL(RML__real_5ffloor)
{
  rmlA0 = rml_prim_mkreal(floor(rml_prim_get_real(rmlA0)));
  RML_CHECK_POINTER(rmlA0, RML__real_5ffloor, "RML.realFloor");

  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

/* real_ceil.c */
RML_BEGIN_LABEL(RML__real_5fceil)
{
  rmlA0 = rml_prim_mkreal(ceil(rml_prim_get_real(rmlA0)));
  RML_CHECK_POINTER(rmlA0, RML__real_5fceil, "RML.realCeil");

  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

/* real_ge.c */
RML_BEGIN_LABEL(RML__real_5fge)
{
  double d0 = rml_prim_get_real(rmlA0);
  double d1 = rml_prim_get_real(rmlA1);
  
  rmlA0 = (d0 >= d1) ? RML_TRUE : RML_FALSE;
  
  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

/* real_gt.c */
RML_BEGIN_LABEL(RML__real_5fgt)
{
  double d0 = rml_prim_get_real(rmlA0);
  double d1 = rml_prim_get_real(rmlA1);
  
  rmlA0 = (d0 > d1) ? RML_TRUE : RML_FALSE;
  
  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

/* real_int.c */
RML_BEGIN_LABEL(RML__real_5fint)
{
  double d0 = floor(rml_prim_get_real(rmlA0));
  rml_sint_t i0 = RML_TAGFIXNUM((rml_sint_t)d0);
  if( (double)RML_UNTAGFIXNUM(i0) == d0 ) 
  {
    rmlA0 = RML_IMMEDIATE(i0);
    RML_TAILCALLK(rmlSC);
  } 
  else
    RML_TAILCALLK(rmlFC);
}
RML_END_LABEL

/* real_le.c */
RML_BEGIN_LABEL(RML__real_5fle)
{
  double d0 = rml_prim_get_real(rmlA0);
  double d1 = rml_prim_get_real(rmlA1);
  
  rmlA0 = (d0 <= d1) ? RML_TRUE : RML_FALSE;
  
  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

/* real_ln.c */
RML_BEGIN_LABEL(RML__real_5fln)
{
  double d0 = rml_prim_get_real(rmlA0);
  
  if( d0 > 0.0 ) 
  {
    rmlA0 = rml_prim_mkreal(log(d0));
    RML_CHECK_POINTER(rmlA0, RML__real_5fln, "RML.realLn");

    RML_TAILCALLK(rmlSC);
  } 
  else
    RML_TAILCALLK(rmlFC);
}
RML_END_LABEL

/* real_lt.c */
RML_BEGIN_LABEL(RML__real_5flt)
{
  double d0 = rml_prim_get_real(rmlA0);
  double d1 = rml_prim_get_real(rmlA1);
  
  rmlA0 = (d0 < d1) ? RML_TRUE : RML_FALSE;
  
  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

/* real_max.c */
RML_BEGIN_LABEL(RML__real_5fmax)
{
  if( rml_prim_get_real(rmlA1) > rml_prim_get_real(rmlA0) )
    rmlA0 = rmlA1;
  
  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

/* real_min.c */
RML_BEGIN_LABEL(RML__real_5fmin)
{
  if( rml_prim_get_real(rmlA1) < rml_prim_get_real(rmlA0) )
    rmlA0 = rmlA1;
  
  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

/* real_mod.c */
RML_BEGIN_LABEL(RML__real_5fmod)
{
  double d0 = rml_prim_get_real(rmlA0);
  double d1 = rml_prim_get_real(rmlA1);
  if( d1 == 0.0 )
    RML_TAILCALLK(rmlFC);
  
  rmlA0 = rml_prim_mkreal(fmod(d0, d1));
  RML_CHECK_POINTER(rmlA0, RML__real_5fmod, "RML.realMod");

  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

/* real_mul.c */
RML_BEGIN_LABEL(RML__real_5fmul)
{
  double d0 = rml_prim_get_real(rmlA0);
  double d1 = rml_prim_get_real(rmlA1);
  
  rmlA0 = rml_prim_mkreal(d0 * d1);
  RML_CHECK_POINTER(rmlA0, RML__real_5fmul, "RML.realMul");
  
  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

/* real_ne.c */
RML_BEGIN_LABEL(RML__real_5fne)
{
  double d0 = rml_prim_get_real(rmlA0);
  double d1 = rml_prim_get_real(rmlA1);
  
  rmlA0 = (d0 != d1) ? RML_TRUE : RML_FALSE;
  
  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

/* real_neg.c */
RML_BEGIN_LABEL(RML__real_5fneg)
{
  rmlA0 = rml_prim_mkreal(-rml_prim_get_real(rmlA0));
  RML_CHECK_POINTER(rmlA0, RML__real_5fneg, "RML.realNeg");

  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

/* real_pow.c */
RML_BEGIN_LABEL(RML__real_5fpow)
{
  double d0 = rml_prim_get_real(rmlA0);
  double d1 = rml_prim_get_real(rmlA1);
  
  rmlA0 = rml_prim_mkreal(pow(d0, d1));
  RML_CHECK_POINTER(rmlA0, RML__real_5fpow, "RML.realPow");
  
  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

/* real_sin.c */
RML_BEGIN_LABEL(RML__real_5fsin)
{
  rmlA0 = rml_prim_mkreal(sin(rml_prim_get_real(rmlA0)));
  RML_CHECK_POINTER(rmlA0, RML__real_5fsin, "RML.realSin");

  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

/* real_sqrt.c */
RML_BEGIN_LABEL(RML__real_5fsqrt)
{
  double d0 = rml_prim_get_real(rmlA0);
  if( d0 >= 0.0 ) 
  {
    rmlA0 = rml_prim_mkreal(sqrt(d0));
    RML_CHECK_POINTER(rmlA0, RML__real_5fsqrt, "RML.realSqrt");

    RML_TAILCALLK(rmlSC);
  } 
  else
    RML_TAILCALLK(rmlFC);
}
RML_END_LABEL

/* real_str.c */
RML_BEGIN_LABEL(RML__real_5fstring)
{
  /* 64-bit (1+11+52) double: -d.[15 digits]E-[4 digits] = ~24 digits max.
   * Add safety margin. */
  static char buffer[32];
  struct rml_string *res;
  double r = rml_prim_get_real(rmlA0);
  // fprintf(stderr, "\nrealString(%g)\n", r);
  if (isinf(r) && r < 0) {
    res = rml_prim_mkstring(4, 0);
    RML_CHECK_POINTER(res, RML__real_5fstring, "RML.realString");
    strcpy(res->data, "-inf");  /* this also sets the ending '\0' */
  } else if (isinf(r)) {
    res = rml_prim_mkstring(3, 0);
    RML_CHECK_POINTER(res, RML__real_5fstring, "RML.realString");
    strcpy(res->data, "inf");  /* this also sets the ending '\0' */
  } else if (isnan(r)) {
    res = rml_prim_mkstring(3, 0);
    RML_CHECK_POINTER(res, RML__real_5fstring, "RML.realString");
    strcpy(res->data, "NaN");  /* this also sets the ending '\0' */
  } else {
    char* endptr;
    int ix = snprintf(buffer, 32, "%.15g", r);
    long ignore;
    if (ix < 0)
      RML_TAILCALLK(rmlFC);
    errno = 0;
    /* If it looks like an integer, we need to append .0 so it looks like real */
    ignore = strtol(buffer,&endptr,10);
    if (errno == 0 && *endptr == '\0') {
      if (ix > 30)
        RML_TAILCALLK(rmlFC);
      buffer[ix++] = '.';
      buffer[ix++] = '0';
      buffer[ix] = '\0';
    }
  }
  res = rml_prim_mkstring(strlen(buffer), 0);
  RML_CHECK_POINTER(res, RML__real_5fstring, "RML.realString");
  strcpy(res->data, buffer);  /* this also sets the ending '\0' */

  rmlA0 = RML_TAGPTR(res);
  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

/* real_sub.c */
RML_BEGIN_LABEL(RML__real_5fsub)
{
  double d0 = rml_prim_get_real(rmlA0);
  double d1 = rml_prim_get_real(rmlA1);
  
  rmlA0 = rml_prim_mkreal(d0 - d1);
  RML_CHECK_POINTER(rmlA0, RML__real_5fsub, "RML.realSub");

  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

RML_BEGIN_LABEL(RML__real_5fasin)
{
  rmlA0 = rml_prim_mkreal(asin(rml_prim_get_real(rmlA0)));
  RML_CHECK_POINTER(rmlA0, RML__real_5fasin, "RML.realAsin");

  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

RML_BEGIN_LABEL(RML__real_5facos)
{
  rmlA0 = rml_prim_mkreal(acos(rml_prim_get_real(rmlA0)));
  RML_CHECK_POINTER(rmlA0, RML__real_5facos, "RML.realAcos");

  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

RML_BEGIN_LABEL(RML__real_5fatan2)
{
  rmlA0 = rml_prim_mkreal(atan2(rml_prim_get_real(rmlA0),rml_prim_get_real(rmlA1)));
  RML_CHECK_POINTER(rmlA0, RML__real_5fatan2, "RML.realAtan2");

  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

RML_BEGIN_LABEL(RML__real_5fcosh)
{
  rmlA0 = rml_prim_mkreal(cosh(rml_prim_get_real(rmlA0)));
  RML_CHECK_POINTER(rmlA0, RML__real_5fcosh, "RML.realCosh");

  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

RML_BEGIN_LABEL(RML__real_5flog)
{
  rmlA0 = rml_prim_mkreal(log(rml_prim_get_real(rmlA0)));
  RML_CHECK_POINTER(rmlA0, RML__real_5flog, "RML.realLog");

  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

RML_BEGIN_LABEL(RML__real_5flog10)
{
  rmlA0 = rml_prim_mkreal(log10(rml_prim_get_real(rmlA0)));
  RML_CHECK_POINTER(rmlA0, RML__real_5flog10, "RML.realLog10");

  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

RML_BEGIN_LABEL(RML__real_5fsinh)
{
  rmlA0 = rml_prim_mkreal(sinh(rml_prim_get_real(rmlA0)));
  RML_CHECK_POINTER(rmlA0, RML__real_5fsinh, "RML.realSinh");

  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

RML_BEGIN_LABEL(RML__real_5ftanh)
{
  rmlA0 = rml_prim_mkreal(tanh(rml_prim_get_real(rmlA0)));
  RML_CHECK_POINTER(rmlA0, RML__real_5ftanh, "RML.realTanh");

  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL


