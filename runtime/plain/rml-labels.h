/*
 * rml-labels.h
 * for plain 'dispatching labels'
 */

typedef void *rml_labptr_t;
#define RML_LABPTR(LABEL)  ((void*)LABEL)
#define RML_LABVAL(LABEL)  RML_IMMEDIATE(LABEL)

#ifdef  RML_STATE_APTR

#define RML_FORWARD_LABEL(LABEL)  void *LABEL(struct rml_state*)
#define RML_BEGIN_LABEL(LABEL)  void *LABEL(struct rml_state *rmlState)
#define RML_END_LABEL    /*empty*/

#ifdef  RML_CRAP_RISC_CC
#define RML_APPLY(LABVAL)  ((*(void*(*)())(LABVAL))(rmlState))
#else  /*!RML_CRAP_RISC_CC*/
#define RML_APPLY(LABVAL)  ((*(void*(*)(struct rml_state*))(LABVAL))(rmlState))
#endif  /*RML_CRAP_RISC_CC*/

#else  /*!RML_STATE_APTR*/

#ifdef  RML_STATE_LPTR

#define RML_FORWARD_LABEL(LABEL)  void *LABEL(void)
#define RML_BEGIN_LABEL(LABEL)  void *LABEL(void) { struct rml_state *rmlState = &rml_state;
#define RML_END_LABEL    }
#define RML_APPLY(LABVAL)  ((*(void*(*)(void))(LABVAL))())

#else  /*!RML_STATE_LPTR*/

#define RML_FORWARD_LABEL(LABEL)  void *LABEL(void)
#define RML_BEGIN_LABEL(LABEL)  void *LABEL(void)
#define RML_END_LABEL    /*empty*/
#define RML_APPLY(LABVAL)  ((*(void*(*)(void))(LABVAL))())

#endif  /*RML_STATE_LPTR*/
#endif  /*RML_STATE_APTR*/

#ifdef  RML_MORE_LOGGING
#define RML_DEFINE_MODULE(MODULE)  static const char module[] = MODULE;
#define RML_TAILCALL(LABVAL,NARGSIGNORED) return (rml_nrArgs = NARGSIGNORED, rml_latest_module = module, rml_latest_known = 0, (void*)LABVAL)
#define RML_TAILCALLQ(LABEL,NARGSIGNORED) return (rml_nrArgs = NARGSIGNORED, rml_latest_module = module, rml_latest_known = 1, RML_LABVAL(LABEL))
#else  /*!RML_MORE_LOGGING*/
#define RML_DEFINE_MODULE(MODULE)  /*empty*/
#define RML_TAILCALL(LABVAL,NARGSIGNORED) return /*(rml_nrArgs = NARGSIGNORED, */(void*)LABVAL/*)*/
#define RML_TAILCALLQ(LABEL,NARGSIGNORED) return /*(rml_nrArgs = NARGSIGNORED, */ RML_LABVAL(LABEL)/*)*/
#endif  /*RML_MORE_LOGGING*/
#define RML_TAILCALLK(KONT)  RML_TAILCALL(RML_FETCH((KONT)),1)

extern void *rml_prim_gcalloc(rml_uint_t, rml_uint_t);
#define RML_ALLOC_TRACE(VAR,NWORDS,NARGS,UNUSEDLABEL,LABEL_STRING) \
  do{\
    void* x =  (void*)rml_young_next; \
    (VAR) = (void*)rml_young_next; \
    if((rml_young_next = (void**)(VAR)+(NWORDS)) >= rml_young_limit) \
      x = rml_prim_gcalloc((NWORDS),(NARGS)); \
    if (x == NULL) { \
      rml_trace_enabled = 1; \
      fprintf(stderr, "NOT ENOUGH MEMORY function: %s address: %p trace: %d\n", \
        LABEL_STRING, UNUSEDLABEL, rml_trace_enabled); fflush(stderr); RML_TAILCALLK(rmlFC); fflush(stderr); \
    } \
    else { \
      (VAR) = x; \
    } \
  } while(0)

#define RML_ALLOC(VAR,NWORDS,NARGS) \
  do{\
    (VAR) = (void*)rml_young_next; \
    if((rml_young_next = (void**)(VAR)+(NWORDS)) >= rml_young_limit) \
      (VAR) = rml_prim_gcalloc((NWORDS),(NARGS)); \
  } while(0)

#ifdef RML_TRACE /* we have RML_TRACE defined */

#define RML_CHECK_POINTER(VAR, UNUSEDLABEL, LABEL_STRING) \
  if ((VAR) == NULL) { \
    rml_trace_enabled = 1; \
    fprintf(stderr, "NOT ENOUGH MEMORY function: %s address: %p trace: %d\n", \
      LABEL_STRING, UNUSEDLABEL, rml_trace_enabled); fflush(stderr); RML_TAILCALLK(rmlFC); \
  }

#else /* nothing */

#define RML_CHECK_POINTER(VAR, UNUSEDLABEL, LABEL_STRING) 

#endif




