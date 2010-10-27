#include <stdio.h>
#include <string.h>
#include "rml.h"

/* p_clock.c
 * Extremely system dependent implementation of a simple
 * timer facility, analogous to ANSI-C's clock().
 */
#ifdef RML_CLOCK_RUSAGE
#include <sys/time.h>
#include <sys/resource.h>
extern int getrusage(int, struct rusage*);

unsigned long rml_prim_clock(void)
{
    struct rusage ru;
    unsigned long usecs;
    double scale;

    (void)getrusage(RUSAGE_SELF, &ru);
    usecs = ru.ru_utime.tv_sec * 1000000 + ru.ru_utime.tv_usec
      + ru.ru_stime.tv_sec * 1000000 + ru.ru_stime.tv_usec;
    scale = (double)RML_CLOCKS_PER_SEC / 1000000.0;
    return (unsigned long)((double)usecs * scale);
}
#endif

#ifdef RML_CLOCK_TIMES
#include <sys/times.h>
#include <limits.h>
#include <time.h>    /* for glibc2 */
#include <unistd.h> /* for sysconf */
extern clock_t times(struct tms*);

unsigned long rml_prim_clock(void)
{
    struct tms tms;
    double scale;

    (void)times(&tms);
#ifdef CLK_TCK
    scale = (double)RML_CLOCKS_PER_SEC / (double)CLK_TCK;
#else /* use new sysconf(_SC_CLK_TCK) */
    scale = (double)RML_CLOCKS_PER_SEC / (double)sysconf(_SC_CLK_TCK);
#endif
    return (unsigned long)((double)(tms.tms_utime + tms.tms_stime) * scale);
}
#endif

/* misc_clock.c */
#ifdef RML_CLOCK_PARIX
#include <sys/time.h>

unsigned long rml_prim_clock(void)
{
    double scale = (double)RML_CLOCKS_PER_SEC / (double)CLOCK_TICK;
    return (unsigned long)((double)TimeNow() * scale);
}
#endif

#ifdef RML_CLOCK_ANSIC
#include <time.h>

unsigned long rml_prim_clock(void)
{
    double scale = (double)RML_CLOCKS_PER_SEC / (double)CLOCKS_PER_SEC;
    return (unsigned long)((double)clock() * scale);
}
#endif


RML_BEGIN_LABEL(RML__clock)
{
    rmlA0 = rml_prim_mkreal((double)rml_prim_clock() / (double)RML_CLOCKS_PER_SEC);
    RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

/* misc_print.c */
RML_BEGIN_LABEL(RML__print)
{
    void *str = rmlA0;
    fwrite(RML_STRINGDATA(str), RML_HDRSTRLEN(RML_GETHDR(str)), 1, stdout);
    fflush(stdout);
    RML_TAILCALLK(rmlSC);
}
RML_END_LABEL


RML_BEGIN_LABEL(RML__enable_5ftrace)
{
  rml_trace_enabled = 1;
  if (rml_trace_enabled)
  {
    fprintf(stderr, "enableTrace\n"); fflush(stderr);
  }
  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL

RML_BEGIN_LABEL(RML__disable_5ftrace)
{
  if (rml_trace_enabled)
  {
    fprintf(stderr, "disableTrace\n"); fflush(stderr);
  }
  rml_trace_enabled = 0;
  RML_TAILCALLK(rmlSC);
}
RML_END_LABEL



