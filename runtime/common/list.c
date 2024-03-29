#include <stdio.h>
#include "rml.h"

/* list_append.c */
RML_BEGIN_LABEL(RML__list_5fappend)
{
  rml_uint_t nelts;
  void *lst;

  /* count the number of elements in the first list */
  lst = rmlA0;
  nelts = 0;
  
  while( RML_GETHDR(lst) == RML_CONSHDR ) {
    lst = RML_CDR(lst);
    ++nelts;
  }

  /* cons up fresh copy of first list, tack on second list last */
  if( nelts == 0 )
    rmlA0 = rmlA1;
  else 
  {
    void **chunk = (void**)rml_prim_alloc(3*nelts, 2);
    RML_CHECK_POINTER(chunk, RML__list_5fappend, "RML.listAppend");
    
    lst = rmlA0;
    rmlA0 = RML_TAGPTR(chunk);
    do 
    {
      chunk[0] = RML_IMMEDIATE(RML_CONSHDR);
      chunk[1] = RML_CAR(lst);
      chunk[2] = RML_TAGPTR(chunk + 3);
      lst = RML_CDR(lst);
      chunk += 3;
    } while( --nelts != 0 );
    
    /* set the CDR of the last copied CONS to the second list */
    chunk[-1] = rmlA1;
  }

  /* return resulting list */
  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL


/* list-arr.c */
RML_BEGIN_LABEL(RML__list_5farray)
{
  rml_uint_t nelts = 0;

  /* first compute the length of the list */
  {
    void *lst = rmlA0;
    for(; RML_GETHDR(lst) == RML_CONSHDR; ++nelts, lst = RML_CDR(lst))
      ;
  }
  
  /* then allocate and initialize the vector */
  {
    struct rml_struct *vec = NULL;
    void *lst = NULL;
    void **vecp = NULL;

    vec = (struct rml_struct*)rml_prim_alloc(1+nelts, 1);
    RML_CHECK_POINTER(vec, RML__list_5farray, "RML.listArray");
    
    lst = rmlA0; /* re-read after alloc! */
    vecp = vec->data;
    vec->header = RML_STRUCTHDR(nelts, 0);
    rmlA0 = RML_TAGPTR(vec);
    for(; nelts > 0; --nelts, lst = RML_CDR(lst))
      *vecp++ = RML_CAR(lst);
    }
    RML_TAILCALLK(rmlSC);
}
RML_END_LABEL


/* list-delete.c */
RML_BEGIN_LABEL(RML__list_5fdelete)
{
  rml_sint_t nelts = RML_UNTAGFIXNUM(rmlA1);
  if( nelts < 0 )
    RML_TAILCALLK(rmlFC);
  else if( nelts == 0 ) 
  {
    if( RML_GETHDR(rmlA0) == RML_CONSHDR )
      rmlA0 = RML_CDR(rmlA0);
    else
      RML_TAILCALLK(rmlFC);
  } 
  else 
  { /* nelts > 0 */
    void **chunk = NULL;
    void *lst = NULL;
    
    chunk = (void**)rml_prim_alloc(3*nelts, 1);
    RML_CHECK_POINTER(chunk, RML__list_5fdelete, "RML.listDelete");
    
    lst = rmlA0;
    rmlA0 = RML_TAGPTR(chunk);
    for(;;) 
    {
      if( RML_GETHDR(lst) == RML_CONSHDR ) 
      {
        if( nelts == 0 ) 
        {
          chunk[-1] = RML_CDR(lst);
          break;
        } 
        else 
        {
          chunk[0] = RML_IMMEDIATE(RML_CONSHDR);
          chunk[1] = RML_CAR(lst);
          chunk[2] = RML_TAGPTR(chunk + 3);
          lst = RML_CDR(lst);
          chunk += 3;
          --nelts;
          continue;
        }
      } 
      else  /* NIL */
        RML_TAILCALLK(rmlFC);
    }
  }

  /* return resulting list */
  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL


/* list_length.c */
RML_BEGIN_LABEL(RML__list_5flength)
{
    void *lst = rmlA0;
    rml_uint_t len = 0;
    for(; RML_GETHDR(lst) == RML_CONSHDR; ++len, lst = RML_CDR(lst))
  ;
    rmlA0 = RML_IMMEDIATE(RML_TAGFIXNUM(len));
    RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

/* list-member.c */
RML_BEGIN_LABEL(RML__list_5fmember)
{
    void *x = rmlA0;
    void *ys = rmlA1;
    void *result = RML_FALSE;
    for(; RML_GETHDR(ys) == RML_CONSHDR; ys = RML_CDR(ys)) {
  if( rml_prim_equal(x, RML_CAR(ys)) != RML_FALSE ) {
      result = RML_TRUE;
      break;
  }
    }
    rmlA0 = result;
    RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

/* list-nth.c */
RML_BEGIN_LABEL(RML__list_5fnth)
{
    rml_sint_t i = RML_UNTAGFIXNUM(rmlA1);
    void *lst = rmlA0;
    for(; RML_GETHDR(lst) == RML_CONSHDR; --i, lst = RML_CDR(lst)) {
  if( i == 0 ) {
      rmlA0 = RML_CAR(lst);
      RML_TAILCALLK(rmlSC);
  }
    }
    RML_TAILCALLK(rmlFC);
}
RML_END_LABEL

/* list-get.c */
RML_BEGIN_LABEL(RML__list_5fget)
{
  rml_sint_t i = RML_UNTAGFIXNUM(rmlA1) - 1; /* list_get starts the index at 1 */
  void *lst = rmlA0;
  if (i < 0) 
    RML_TAILCALLK(rmlFC);
  
  for(; RML_GETHDR(lst) == RML_CONSHDR; --i, lst = RML_CDR(lst)) 
  {
    if ( i == 0 ) 
    {
      rmlA0 = RML_CAR(lst);
      RML_TAILCALLK(rmlSC);
    }
  }
  RML_TAILCALLK(rmlFC);
}
RML_END_LABEL

/* list-reverse.c */
RML_BEGIN_LABEL(RML__list_5freverse)
{
  void *a1;    /* cached A1 */
  struct rml_struct *cons;

  /* A1 := A0; A0 := NIL */
  a1 = rmlA0;
  rmlA0 = RML_TAGPTR(&rml_prim_nil);

  /* while CONSP(A1) do A0 := CONS(CAR(A1), A0); A1 := CDR(A1) end */
  while( RML_GETHDR(a1) == RML_CONSHDR ) 
  {
    rmlA1 = a1;
    
    cons = (struct rml_struct*)rml_prim_alloc(3, 2);
    RML_CHECK_POINTER(cons, RML__list_5freverse, "RML.listReverse");
    
    a1 = rmlA1; /* re-read after alloc */
    cons->header = RML_CONSHDR;
    cons->data[0] = RML_CAR(a1);
    cons->data[1] = rmlA0;
    rmlA0 = RML_TAGPTR(cons);
    a1 = RML_CDR(a1);
  }

  /* return A0 */
  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

/* list-str.c */
RML_BEGIN_LABEL(RML__list_5fstring)
{
  rml_uint_t len = 0;

  /* first compute the length of the list */
  {
    void *lst = rmlA0;
    for(; RML_GETHDR(lst) == RML_CONSHDR; ++len, lst = RML_CDR(lst))
      ;
  }
  /* then allocate and initialize the string */
  {
    struct rml_string *str = NULL;
    void *lst = NULL;
    unsigned char *s = NULL;
    
    str = rml_prim_mkstring(len, 1);  /* gets len+1 bytes */
    RML_CHECK_POINTER(str, RML__list_5fstring, "RML.listString");

    lst = rmlA0;
    s = (unsigned char*)str->data;
    rmlA0 = RML_TAGPTR(str);
    for(; len > 0; --len, lst = RML_CDR(lst))
        *s++ = RML_UNTAGFIXNUM(RML_CAR(lst));
    *s = '\0';
  }
  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

/* adrpo added string char list to string */
RML_BEGIN_LABEL(RML__string_5fchar_5flist_5fstring)
{
   RML_TAILCALLQ(RML__string_5fappend_5flist, 1);
}
RML_END_LABEL

/* list_vec.c */
RML_BEGIN_LABEL(RML__list_5fvector)
{
  rml_uint_t nelts = 0;

  /* first compute the length of the list */
  {
    void *lst = rmlA0;
    for(; RML_GETHDR(lst) == RML_CONSHDR; ++nelts, lst = RML_CDR(lst))
      ;
  }
  /* then allocate and initialize the vector */
  {
    struct rml_struct *vec = NULL;
    void *lst = NULL;
    void **vecp = NULL;

    vec = (struct rml_struct*)rml_prim_alloc(1+nelts, 1);
    RML_CHECK_POINTER(vec, RML__list_5fvector, "RML.listVector");
    
    lst = rmlA0; /* reread after alloc */
    vecp = vec->data;
    vec->header = RML_STRUCTHDR(nelts, 0);
    rmlA0 = RML_TAGPTR(vec);
    for(; nelts > 0; --nelts, lst = RML_CDR(lst))
      *vecp++ = RML_CAR(lst);
  }
  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

RML_BEGIN_LABEL(RML__list_5fappend_5funsafe)
{
  void *lst, *tmp;
  rml_uint_t idx = 0;
  struct rml_struct *p = NULL;
  lst = rmlA0;

  if (rml_trace_enabled)
  {
    fprintf(stderr, "listAppendUnsafe\n"); fflush(stderr);
  }

  /* the first list is empty */
  if (RML_GETHDR(rmlA0) != RML_CONSHDR)
  {
    rmlA0 = rmlA1; /* the first list was empty, return the second list. */
    RML_TAILCALLK(rmlSC);
  }
  /* the second list is empty */
  if (RML_GETHDR(rmlA1) != RML_CONSHDR)
  {
    rmlA0 = rmlA0; /* the second list was empty, return the first list. */
    RML_TAILCALLK(rmlSC);
  }

  /* find the end of the first list! */
  while( RML_GETHDR(lst) == RML_CONSHDR )
  {
    if (RML_GETHDR(tmp = RML_CDR(lst)) != RML_CONSHDR)
      break;
    else
      lst = tmp; /* move to next element */
  }

  p = RML_UNTAGPTR(lst);
  /* set the cdr of the last element in the first list to the first element in the second list */
  p->data[1] = rmlA1;
  for (idx = rml_array_trail_size; &rml_array_trail[idx] >= rmlATP; idx--)
    if (rml_array_trail[idx] == lst) /* if found, do not add again */
    {
      rmlA0 = rmlA0; /* return the pointer to the first list */
      /* return resulting list */
      RML_TAILCALLK(rmlSC);
    }
  /* add the address of the list element into the roots to be
   *  taken into consideration at the garbage collection time
   */
  if( rmlATP == &rml_array_trail[0] )
  {
    (void)fprintf(stderr, "Array Trail Overflow!\n");
    rml_exit(1);
  }
  *--rmlATP = lst;

  rmlA0 = rmlA0; /* return the pointer to the first list */
  /* return resulting list */
  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL


