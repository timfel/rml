/* config.h for Intel x86_64 / Linux / gcc */

/* the following section was generated by repchk */
typedef long rml_sint_t;
typedef unsigned long rml_uint_t;
#define RML_LOG2_SIZE_INT 3
#define RML_SIZE_INT 8
#define RML_SIZE_DBL 8
/* end of repchk-generated section */

#define	RML_CLOCK_TIMES

#define	RML_ALLOCA_BUILTIN

#define rml_setjmp	setjmp
#define rml_longjmp	longjmp

#ifdef	RML_PLAIN
#define RML_YOUNG_SIZE	(72*1024)
#endif
#ifdef	RML_SWITCH
#define RML_YOUNG_SIZE	(72*1024)
#endif

#ifdef	RML_PLAIN
#define RML_STATE_JOIN
#define RML_STATE_APTR
#endif
#ifdef	RML_SWITCH
#define RML_STATE_JOIN
#define RML_STATE_APTR
#endif

#define RML_GCCGOTO
#define RML_GCCGOTO_NOSHIFT
