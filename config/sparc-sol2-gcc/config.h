/* config.h for SPARC / Solaris 2.x / gcc */

/* the following section was generated by repchk */
typedef int rml_sint_t;
typedef unsigned int rml_uint_t;
#define RML_LOG2_SIZE_INT 2
#define RML_SIZE_INT 4
#define RML_SIZE_DBL 8
#define RML_DBL_PAD
#define RML_DBL_STRICT
/* end of repchk-generated section */

#define	RML_CLOCK_TIMES

#define	RML_ALLOCA_BUILTIN

#define rml_setjmp	setjmp
#define rml_longjmp	longjmp

#ifdef	RML_PLAIN
#define RML_YOUNG_SIZE	(92*1024)
#endif
#ifdef	RML_SWITCH
#define RML_YOUNG_SIZE	(72*1024)
#endif
#ifdef	RML_PUSHY
#define RML_YOUNG_SIZE	(124*1024)
#endif
#ifdef	RML_WARPED
#define RML_YOUNG_SIZE	(72*1024)
#endif

#ifdef	RML_PLAIN
#define RML_STATE_JOIN
#define RML_STATE_APTR
#endif
#ifdef	RML_SWITCH
#define RML_STATE_JOIN
#define RML_STATE_LPTR
#endif

#define RML_GCCGOTO
