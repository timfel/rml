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
  union rml_double_as_words u = {0};
  u.data[0] = RML_REALDATA(p)[0];
  u.data[1] = RML_REALDATA(p)[1];
  return u.d;
}
#endif  /* RML_DBL_STRICT */

/* p_set_real.c */
#ifdef  RML_DBL_STRICT
void rml_prim_set_real(struct rml_real *p, double d)
{
  union rml_double_as_words u = {0};
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

#include "dtoa.c"

#define    to_char(n)    ((n) + '0')

#define MAXEXPDIG 6

static int
exponent(char *p0, int expo)
{
    char *p, *t;
    char expbuf[MAXEXPDIG];

    p = p0;
    *p++ = 'e';
    if (expo < 0) {
        expo = -expo;
        *p++ = '-';
    }
    else
        *p++ = '+';
    t = expbuf + MAXEXPDIG;
    if (expo > 9) {
        do {
            *--t = to_char(expo % 10);
        } while ((expo /= 10) > 9);
        *--t = to_char(expo);
        for (; t < expbuf + MAXEXPDIG; *p++ = *t++)
            ;
    }
    else {
        /*
         * Exponents for decimal floating point conversions
         * (%[eEgG]) must be at least two characters long,
         * whereas exponents for hexadecimal conversions can
         * be only one character long.
         */
    *p++ = '0';
        *p++ = to_char(expo);
    }
    return (p - p0);
}

/*
 * Generate reals like %.16g but platform-independent
 * Does not check for inf/NaN in the default mode since realString
 * handles them in a more efficient manner (static data, no allocation)
 */
static struct rml_string* dtostr(double d)
{
  const int prec = 16 /* 1 more than mathematically relevant */;
  int signflag,i,totalsz;
  int expt,expsz=0,ndig;
  char *cp,*cporig,*dtoaend;
  char expbuf[MAXEXPDIG];
  struct rml_string *retval;
  char *res;
  *expbuf = 0;
  cporig = dtoa(d,1,prec,&expt,&signflag,&dtoaend);
  cp = cporig;
    ndig = dtoaend - cp;
  /*
   * Allocate the string on GC'ed heap directly
   * We just need to calculate the exact length of the string first :)
   */
  if (expt == 0) {
    totalsz = signflag+2+ndig;
  } else if (expt == ndig || (expt > 0 && expt < prec && expt > ndig)) {
    totalsz = signflag+expt+2;
  } else if (expt > 0 && expt < prec && expt > ndig) {
    totalsz = signflag+expt+2;
  } else if (expt > 0 && expt < prec) {
    totalsz = signflag+ndig+1;
  } else if (expt <= 0 && ndig+expt > -prec) {
    totalsz = signflag-expt+ndig+2;
  } else {
    totalsz = signflag;
    if (expt && ndig == 1) totalsz += ndig;
    else if (expt == 1 || ndig == 1) totalsz += ndig+2;
    else totalsz += ndig+1;
    if (expt!=1) {
      /* Yup, this is then used later ;) */
      expsz = exponent(expbuf,expt == 0 ? expt : expt - 1);
      totalsz += expsz;
    }
  }
  retval = rml_prim_mkstring(totalsz,0);
  res = retval->data;
  *res = '\0';

  if (signflag) *res++ = '-';
  if (expt == 0) {
    *res++ = '0';
    *res++ = '.';
    strcpy(res,cp);
    res += ndig;
  } else if (expt == ndig) {
    strcpy(res,cp);
    res += ndig;
    *res++ = '.';
    *res++ = '0';
  } else if (expt > 0 && expt < prec && expt > ndig) {
    strcpy(res,cp);
    res += ndig;
    for (i=ndig;i<expt;i++) {
      *res++ = '0';
    }
    *res++ = '.';
    *res++ = '0';
  } else if (expt > 0 && expt < prec) {
    for (i=0;i<expt;i++) {
      *res++ = *cp++;
    }
    *res++ = '.';
    strcpy(res,cp);
    res += ndig-expt;
  } else if (expt <= 0 && ndig+expt > -prec) {
    *res++ = '0';
    *res++ = '.';
    for (i=0;i<-expt;i++)
      *res++ = '0';
    strcpy(res,cp);
    res += ndig;
  } else {
    if (expt == 0) {
      *res++ = '0';
      *res++ = '.';
    } else {
      *res++ = *cp++;
      if (expt && ndig > 1) *res++ = '.';
      if (expt == 1 && ndig == 1) {
        *res++ = '.';
        *res++ = '0';
      }
    }
    strcpy(res,cp);
    res += ndig-1;
    if (expt) {
      strncpy(res,expbuf,expsz);
      res += expsz;
    }
  }
  *res = 0;
  freedtoa(cporig);
  return retval;
}

#undef MAXEXPDIG

#if defined(_MSC_VER)
#include <float.h>
#define isnan _isnan
#define isinf !_finite
#endif

static const RML_DEFSTRINGLIT(_RML_LIT_NEG_INF,4,"-inf");
static const RML_DEFSTRINGLIT(_RML_LIT_POS_INF,3,"inf");
static const RML_DEFSTRINGLIT(_RML_LIT_NAN,3,"NaN");


struct rml_string* _rml_old_realString(double  r)
{
  /* NOTE: The OMC runtime uses the same code as this function.
   * If you update one, you must update the other or the testsuite might break
   *
   * 64-bit (1+11+52) double: -d.[15 digits]E-[4 digits] = ~24 digits max.
   * Add safety margin in case some C runtime is trigger happy. */
  struct rml_string *str;
  char buffer[32];
  char* endptr;
  int ix = snprintf(buffer, 32, "%.16g", r);
  /* If it looks like an integer, we need to append .0 so it looks like real */
  endptr = buffer;
  while (isdigit(*endptr)) endptr++;
  if (0 == *endptr) {
    *endptr++ = '.';
    *endptr++ = '0';
    *endptr++ = '\0';
  } else if ('E' == *endptr) {
    *endptr = 'e';
  }
  str = rml_prim_mkstring(strlen(buffer), 0);
  strcpy(str->data, buffer);	/* this also sets the ending '\0' */
  return str;
}


/* real_str.c */
RML_BEGIN_LABEL(RML__real_5fstring)
{
  double r = rml_prim_get_real(rmlA0);
  if (isinf(r) && r < 0)
    rmlA0 = RML_REFSTRINGLIT(_RML_LIT_NEG_INF);
  else if (isinf(r))
    rmlA0 = RML_REFSTRINGLIT(_RML_LIT_POS_INF);
  else if (isnan(r))
    rmlA0 = RML_REFSTRINGLIT(_RML_LIT_NAN);
  else {
#if 1 /* defined(__MINGW32__)  || defined(_MSC_VER) */
    struct rml_string *res = _rml_old_realString(r);
#else
    struct rml_string *res = dtostr(r);
#endif
    /* fprintf(stderr, "REALsTRING: %g to %s...", r, res->data); */
    RML_CHECK_POINTER(res, RML__real_5fstring, "RML.realString");
    rmlA0 = RML_TAGPTR(res);
  }
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


