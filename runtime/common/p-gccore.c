/* p-gccore.c
 * A simple 2-generational copying compacting garbage collector for RML.
 *
 * There are two main memory areas:
 * -  The young region, where objects are initially allocated.
 * -  The older region, to which young objects are promoted if
 *  they survive a minor collection.
 *  The older region is split in two halves, current and reserve, and
 *  behaves roughly as in a conventional two-space copying collector.
 *  The size of any of these regions must be a multiple (2 or higher)
 *   of RML_YOUNG_SIZE, in order to guarantee that a minor collection of the
 *  young region cannot overflow the current region.
 *  If, after a minor collection, the available space in the current
 *  region is less than RML_YOUNG_SIZE, a major collection is performed to
 *  copy the live parts of the current region to the reserve region;
 *  then the current and reserve regions are swapped. Should less than
 *  RML_YOUNG_SIZE space be available after the major collection, then the
 *  objects are copied to new and larger older regions, and the original
 *  older regions are deallocated.
 *
 * The RML trail is used to register locations in the older region that may
 * refer to objects in the young region. The entire trail is always scanned.
 * (Eventually, the Uppsala Prolog collector [see PLILP'94], may be used.)

 2005-01-10 added by Adrian Pop, adrpo@ida.liu.se
 * The RML aray_trail is used to register locations in the older region that
 * may refer to objects in the young region. The entire arrays present in the
 * trail are scanned for the pointers into younger region.
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>  /* strerror() */
#include <errno.h>
#include <stdarg.h>
#include <assert.h>

/* #define RML_MORE_LOGGING */

#include "rml.h"
#include "z-ysize.h"
#include "p-gccore.h"

/* the young region */
unsigned long rml_young_size;
void **rml_young_region; /* void *rml_young_region[rml_young_size]; */

/* the older region */
unsigned long rml_older_size;
void **rml_current_region;
void **rml_current_next;
void **rml_reserve_region;

/* deal with external C heap */
#define RML_C_HEAP_REGION_SIZE  (1024*1024*4) /* 4 Mbytes */
rml_c_heap_region_t *rml_c_heap;
unsigned long rml_c_heap_region_total_size;
rml_uint_t rml_c_heap_collect_flag = 0;
unsigned long rml_c_heap_collect_count;
/*
 * A string cache for implementing string sharing
 * adrpo 2009-03-05
 */
#define RML_SHARED_STRING_MAX 100   /* share only strings less than this */
#define RML_STRING_CACHE_MAX 1000000 /* the maximum of strings kept in the cache between two garbage collections */
void* rml_string_cache[RML_STRING_CACHE_MAX];
unsigned long rml_string_cache_index = 0;
unsigned long rml_total_shared_strings = 0;
unsigned long rml_total_shared_strings_words = 0;

#define RML_EXIT_ON_FAILURE 0
#define RML_NO_EXIT_ON_FAILURE 1
/* 
 * if the second argument is != 0 the function will not 
 * exit even if it fails to allocate the desired memory
 */
static void **rml_alloc_core(rml_uint_t nslots, rml_uint_t do_not_exit) {
  unsigned long nbytes = nslots * sizeof(void*);
  void **p = NULL;
  p = malloc(nbytes);
  /* 
   * we should not exit if do_not_exit is set as 
   * we still might have a chance if we allocate 
   * less memory, but still enough.
   */
  if ( !p && !do_not_exit) 
  {
    fprintf(stderr, "malloc(%lu) failed!\n", nbytes); fflush(stderr);
#ifdef RML_TRACE /* we have RML_TRACE defined */
    return NULL; 
#else /* exit if RML_TRACE is not defined! */
    rml_exit(1);
#endif
  }
  return p;
}

static void rml_free_core(void **p, size_t nslots_unused) {
  free(p);
}

/* the roots */
#if  !defined(RML_STACK_SIZE)
#define RML_STACK_SIZE  (1024*1024*4) /* 4Mbytes stack */
#endif
unsigned long rml_stack_size;
void **rml_stack;
void **rmlSPMIN;

#if  !defined(RML_TRAIL_SIZE)
#define RML_TRAIL_SIZE  (64*1024)
#endif

unsigned long rml_trail_size;
/* stores the logical variables that were bound so that on back-tracking to unbound them */
void *rml_trail[RML_TRAIL_SIZE];

#if  !defined(RML_ARRAY_TRAIL_SIZE)
#define RML_ARRAY_TRAIL_SIZE  (1024*1024)
#endif
unsigned long rml_array_trail_size = 0;
/* stores the pointers from older to young (write barrier) */
void *rml_array_trail[RML_ARRAY_TRAIL_SIZE];

#if  !defined(RML_SHARE_TRAIL_SIZE)
#define RML_SHARE_TRAIL_SIZE  (1024*1024)
#endif
unsigned long rml_share_trail_size = 0;
/* stores references that can be shared because values they point to are semantically equal */
void *rml_share_trail[RML_SHARE_TRAIL_SIZE][2];

#ifdef  RML_STATE_JOIN

struct rml_state rml_state = { 0, /* SP */
0, /* FC */
0, /* SC */
&rml_trail[RML_TRAIL_SIZE], /* TP */
{ 0, }, /* ARGS[] */
0, /* &rml_young_region[0], *//* young_next */
0, /* &rml_young_region[rml_young_size], *//* young_limit; never changes */
&rml_array_trail[RML_ARRAY_TRAIL_SIZE], /* ATP */
&rml_share_trail[RML_SHARE_TRAIL_SIZE][2], /* STP */
0 /* nrArgs */
};

#else  /*!RML_STATE_JOIN*/

void *rmlSP;
void *rmlFC;
void *rmlSC;
void **rmlTP = &rml_trail[RML_TRAIL_SIZE];
void *rmlARGS[RML_NUM_ARGS];
void **rml_young_next; /*  = &rml_young_region[0]; */
void **rml_young_limit; /* = &rml_young_region[rml_young_size]; */
void **rmlATP = &rml_array_trail[RML_ARRAY_TRAIL_SIZE];
void **rmlSTP = &rml_share_trail[RML_SHARE_TRAIL_SIZE][2];
rml_uint_t rml_nrArgs = 0; /* number of arguments passed on the stack */

#endif  /*RML_STATE_JOIN*/

/* misc */
char rml_flag_bench;
char rml_flag_gclog;
unsigned long rml_clock_start;
unsigned long rml_gc_start_clock;
unsigned long rml_gc_end_clock;
double rml_gc_total_time;
char rml_flag_log;
char rml_flag_no_stack_check;
unsigned long rml_minorgc_count;
unsigned long rml_majorgc_count;
unsigned long rml_call_count;
/* adrpo added 2004-11-10 */
unsigned long rml_allocated_from_c;
/* adrpo added 2004-11-02 */
unsigned long rml_heap_expansions_count;
unsigned long rml_heap_shrinkings_count;
#ifdef  RML_MORE_LOGGING
const char *rml_latest_module;
unsigned char rml_latest_known;
unsigned long rml_intra_calls;
unsigned long rml_intra_known_calls;
unsigned long rml_inter_calls;
unsigned long rml_inter_known_calls;
#endif  /*RML_MORE_LOGGING*/

#if defined(__GNUC__)
#define INLINE __inline__
#elif defined(_MSC_VER)
/* Visual C++ */
# ifndef INLINE
#  define INLINE __inline
# endif
#else
#define INLINE /*empty*/
#endif

/*
 * function to check if this pointer is allocated
 * in the managed C heap
 */
static INLINE int rml_is_allocated_on_c_heap(void** p) {
  rml_c_heap_region_t* current = rml_c_heap;
  while (current != NULL) {
    if (p >= current->region && p <= current->next) {
      /* bingo, we have a hit */
      return 1;
    }
    current = current->next_region;
  }
  return 0;
}

/*
 * function to allocate the managed C heap
 */
rml_c_heap_region_t* rml_alloc_c_heap_region(rml_uint_t nslots) {
  rml_c_heap_region_t *tmp = NULL;
  tmp = (rml_c_heap_region_t*)malloc(sizeof(rml_c_heap_region_t));
  tmp->region = rml_alloc_core(nslots, RML_EXIT_ON_FAILURE);
  tmp->size = nslots;
  tmp->limit = tmp->region + nslots;
  tmp->next = tmp->region;
  tmp->next_region = NULL;
  return tmp;
}

/*
 * function to free the managed C heap
 */
void rml_free_c_heap_region() {
  rml_c_heap_region_t* current = rml_c_heap, *tmp = NULL;
  /* if we haven't use it at all, don't free it */
  if (rml_c_heap->region == rml_c_heap->next)
    return;
  ++rml_c_heap_collect_count;
  while (current != NULL) {
    rml_free_core(current->region, current->size);
    tmp = current;
    current = current->next_region;
    free(tmp);
  }
  /* allocate a new C managed heap for the next round */
  rml_c_heap = rml_alloc_c_heap_region(RML_C_HEAP_REGION_SIZE);
  rml_c_heap_region_total_size = 0;
  rml_string_cache_index = 0;
}

/*
 * function to init the garbage collector
 */
void rml_gcinit(void) {
  rml_gc_total_time = 0;
  rml_gc_start_clock = rml_prim_clock();

  if (rml_stack_size == 0)
    rml_stack_size = RML_STACK_SIZE;
  rml_array_trail_size = RML_ARRAY_TRAIL_SIZE;
  rml_trail_size = RML_TRAIL_SIZE;
  rml_stack = rml_alloc_core(rml_stack_size, RML_EXIT_ON_FAILURE);
  rmlSPMIN = &rml_stack[rml_stack_size];
  rml_state_SP = &rml_stack[rml_stack_size];
  rml_state_FC = &rml_stack[rml_stack_size];
  rml_state_SC = &rml_stack[rml_stack_size];

  /* adrpo added 2004-11-22 */
  if (rml_young_size == 0)
    rml_young_size = RML_YOUNG_SIZE;
  rml_young_region = rml_alloc_core(rml_young_size, RML_EXIT_ON_FAILURE);
  rml_state_young_next = rml_young_region;
  rml_state_young_limit = rml_young_region + rml_young_size;
  /* printf("\nyoung: %p < %p < old: ", rml_state_young_next, rml_state_young_limit); */
  rml_older_size = 4*rml_young_size; /* RML_YOUNG_SIZE */
  rml_current_region = rml_alloc_core(rml_older_size, RML_EXIT_ON_FAILURE);
  rml_current_next = rml_current_region;
  rml_reserve_region = NULL; /* rml_alloc_core(rml_older_size, RML_EXIT_ON_FAILURE); */
  /* adrpo added 2008-08-28 */
  /* deal with C allocated data */
  rml_c_heap_collect_count = 0;
  rml_allocated_from_c = 0;
  rml_c_heap = rml_alloc_c_heap_region(RML_C_HEAP_REGION_SIZE);
  rml_c_heap_region_total_size = 0;

  rml_gc_end_clock = rml_prim_clock();
  rml_gc_total_time += (double)(rml_gc_end_clock - rml_gc_start_clock) / (double)RML_CLOCKS_PER_SEC;
}

void rmldb_show_status(void) {
#ifdef _RMLDB_DEFINED_
  int status = 0;
  if( rml_flag_log )
  {
    fprintf(stderr, "[HEAP:\t%lu minor collections, %lu major collections, %lu words currently in use]\n",
        rml_minorgc_count,
        rml_majorgc_count,
        (unsigned long)(rml_state_young_next - rml_young_region)
        + (unsigned long)(rml_current_next - rml_current_region)
        + (unsigned long)rml_c_heap_region_total_size);
    fprintf(stderr, "[HEAP:\t%lu words allocated to young, %lu words allocated to current, %lu heap expansions/shrinkings performed]\n",
        (unsigned long)rml_young_size, /* RML_YOUNG_SIZE, */
        (unsigned long)rml_older_size,
        (unsigned long)(rml_heap_expansions_count),
    (unsigned long)(rml_heap_shrinkings_count));
    fprintf(stderr, "[HEAP: \t%lu words allocated into managed C heap (from mk_* functions), collected %lu times, remaining uncollected %lu words]\n",
        rml_allocated_from_c, rml_c_heap_collect_count, rml_c_heap_region_total_size);
    fprintf(stderr, "[HEAP: \t%lu strings totaling %lu words where shared]\n",
        rml_total_shared_strings, rml_total_shared_strings_words);
    fprintf(stderr, "[HEAP:\t%#.2f seconds wasted while doing GC]\n", rml_gc_total_time);
    fprintf(stderr, "[STACK:\t%lu words currently in use (%lu words max, %lu words total)]\n",
        (unsigned long)(&rml_stack[rml_stack_size] - (void**)rml_state_SP),
        (unsigned long)(&rml_stack[rml_stack_size] - rmlSPMIN),
        rml_stack_size);
    fprintf(stderr, "[ARRAY:\t%lu words currently in use in the array trail]\n",
        (unsigned long)(&rml_array_trail[RML_ARRAY_TRAIL_SIZE] - rml_state_ATP));
    fprintf(stderr, "[TRAIL:\t%lu words currently in use]\n",
        (unsigned long)(&rml_trail[RML_TRAIL_SIZE] - rml_state_TP));
    fprintf(stderr, "[MOTOR:\t%lu tailcalls performed]\n",
        rml_call_count);
#ifdef  RML_MORE_LOGGING
    fprintf(stderr, "[CALLS:\t%lu intra, %lu known intra, %lu inter, %lu known inter]\n",
        rml_intra_calls, rml_intra_known_calls,
        rml_inter_calls, rml_inter_known_calls);
#endif  /*RML_MORE_LOGGING*/
  }
  else
  {
    fprintf(stdout, "Run using -log: ./rml_program -log ...\n if you want status information in the debugger!\n");
  }
  if ( rml_flag_bench )
  {
    unsigned long rml_clock_end = rml_prim_clock();
    double secs = (double)(rml_clock_end - rml_clock_start) / (double)RML_CLOCKS_PER_SEC;
    fprintf(stderr, "[%s:\t%#.2f seconds total from which %#.2f seconds GC, %lu minor collections, %lu major collections]\n",
        status ? "FAIL" : "BENCH",
        secs, rml_gc_total_time, rml_minorgc_count, rml_majorgc_count);
  }
#endif /* _RMLDB_DEFINED_ */
}

void rml_exit(int status) {
  if (rml_flag_log) {
    fprintf(
        stderr,
        "[HEAP:\t%lu minor collections, %lu major collections, %lu words currently in use]\n",
        rml_minorgc_count, rml_majorgc_count,
        (unsigned long)(rml_state_young_next - rml_young_region)
            + (unsigned long)(rml_current_next - rml_current_region)
            + (unsigned long)rml_c_heap_region_total_size);
    fprintf(
        stderr,
        "[HEAP:\t%lu words allocated to young, %lu words allocated to current, %lu/%lu heap expansions/shrinkings performed]\n",
        (unsigned long)rml_young_size, /* RML_YOUNG_SIZE, */
        (unsigned long)rml_older_size,
        (unsigned long)(rml_heap_expansions_count),
    (unsigned long)(rml_heap_shrinkings_count));
    fprintf(
        stderr,
        "[HEAP: \t%lu words allocated into managed C heap (from mk_* functions), collected %lu times, remaining uncollected %lu words]\n",
        rml_allocated_from_c, rml_c_heap_collect_count,
        rml_c_heap_region_total_size);
    fprintf(stderr, "[HEAP: \t%lu strings totaling %lu words where shared]\n",
        rml_total_shared_strings, rml_total_shared_strings_words);
    fprintf(stderr, "[HEAP:\t%#.2f seconds wasted while doing GC]\n",
        rml_gc_total_time);
    fprintf(
        stderr,
        "[STACK:\t%lu words currently in use (%lu words max, %lu words total)]\n",
        (unsigned long)(&rml_stack[rml_stack_size] - (void**)rml_state_SP),
        (unsigned long)(&rml_stack[rml_stack_size] - rmlSPMIN), rml_stack_size);
    fprintf(stderr,
        "[ARRAY:\t%lu words currently in use in the array trail]\n",
        (unsigned long)(&rml_array_trail[RML_ARRAY_TRAIL_SIZE] - rml_state_ATP));
    fprintf(stderr, "[TRAIL:\t%lu words currently in use]\n",
        (unsigned long)(&rml_trail[RML_TRAIL_SIZE] - rml_state_TP));
    fprintf(stderr, "[MOTOR:\t%lu tailcalls performed]\n", rml_call_count);
#ifdef  RML_MORE_LOGGING
    fprintf(stderr, "[CALLS:\t%lu intra, %lu known intra, %lu inter, %lu known inter]\n",
        rml_intra_calls, rml_intra_known_calls,
        rml_inter_calls, rml_inter_known_calls);
#endif  /*RML_MORE_LOGGING*/
  }
  if (rml_flag_bench) {
    unsigned long rml_clock_end = rml_prim_clock();
    double secs = (double)(rml_clock_end - rml_clock_start)
        / (double)RML_CLOCKS_PER_SEC;
    fprintf(
        stderr,
        "[%s:\t%#.2f seconds total from which %#.2f seconds GC, %lu minor collections, %lu major collections]\n",
        status ? "FAIL" : "BENCH", secs, rml_gc_total_time, rml_minorgc_count,
        rml_majorgc_count);
  }
  exit(status);
}

int rml_isYoungOrOlder(void *p)
{
  return 
      (((char*)rml_young_region <= (char*)p && (char*)rml_young_region + rml_young_size >= (char*)p) /* p in young */ ||
       ((char*)rml_current_region <= (char*)p && (char*)rml_current_region + rml_older_size >= (char*)p) /* p in older */);
}


/* Forward the vector scan[0..nwords-1] of values using next as the allocation
 * pointer. Return the updated allocation pointer.
 * Objects located outside of [region_low,region_low+region_nbytes] remain in place.
 */
static INLINE void **rml_forward_vec(void **scan, rml_uint_t nwords,
    void **next, char *region_low, rml_uint_t region_nbytes) {
  for (; nwords > 0; ++scan, --nwords) {
    /* Forward the value pointed to by `*scan' to the next region.
     * Update `*scan' with the new address.
     * Leave forwarding address behind in `**scan'.
     * Update the allocation pointer `next'.
     */
    void **old;
    rml_uint_t hdr;

    /* If the value is immediate, do nothing. */
    old = (void**)*scan;
    if ( RML_ISIMM(old))
      continue;

    /* If not allocated in this region, do nothing. */
    if ( (rml_uint_t)((char*)old - region_low) >= region_nbytes ) {
      /* If is not allocated in the C heap, do not forward it! */
      if (rml_c_heap_collect_flag && rml_is_allocated_on_c_heap((void**)RML_UNTAGPTR(old))) {
        /* collect to next region */
      } else {
        continue;
      }
    }

    /* If already moved, replace `*scan' with the forwarding address. */
    hdr = RML_GETHDR(old);
    if ( RML_HDRISFORWARD(hdr)) {
      *scan = (void*)hdr;
      continue;
    }
    /* Copy node to next region.
     * Update `*scan' with new address.
     * Leave forwarding address behind in old node.
     */
    *scan = RML_TAGPTR(next);
    old = (void**)RML_UNTAGPTR(old);
    *old++ = RML_TAGPTR(next);
    *next++ = (void*)hdr;

    for (hdr = RML_HDRSLOTS(hdr); hdr > 0; --hdr)
      /* reuse `hdr' as `#slots' */
      *next++ = *old++;
  }
  return next;
}

/*
 * External roots callback.
 */
struct rml_xgcstate {
  void **next;
  char *region_low;
  rml_uint_t region_nbytes;
};

void rml_user_gc_callback(struct rml_xgcstate *s, void **vec, rml_uint_t nelts) {
  if (rml_flag_gclog && !rml_flag_bench) {
    fprintf(stderr, " [rml_user_gc called roots=%lu]", (long unsigned)nelts);
  }
  s->next = rml_forward_vec(vec, nelts, s->next, s->region_low, s->region_nbytes);
}

/* global root data */
void rml_roots_gc_callback(struct rml_xgcstate *s, void **vec, rml_uint_t nelts) {
  if (rml_flag_gclog && !rml_flag_bench) {
    fprintf(stderr, " [rml_roots_gc called roots=%lu]", (long unsigned)nelts);
  }
  s->next = rml_forward_vec(vec, nelts, s->next, s->region_low, s->region_nbytes);
}

/* Forward all roots. Return updated allocation pointer.
 * Objects located outside of [region_low,region_low+region_nbytes] remain in place.
 */
static void **rml_forward_all(rml_uint_t nliveargs, void **next, char *region_low, rml_uint_t region_nbytes) 
{
  /* forward roots from stack */ 
  next = rml_forward_vec(rml_state_SP, &rml_stack[rml_stack_size] - (void**)rml_state_SP, next, region_low, region_nbytes);
  /* forward roots from live arguments */ 
  next = rml_forward_vec(rml_state_ARGS, nliveargs, next, region_low, region_nbytes);
  /* forward roots from trail (logical variables) */
  {
    void **TP = rml_state_TP;
    rml_sint_t cnt = &rml_trail[RML_TRAIL_SIZE] - TP;
    next = rml_forward_vec(TP, (rml_uint_t)cnt, next, region_low, region_nbytes);
    for (; --cnt >= 0; ++TP) {
      void *ref_node = *TP; /* known to be a BOUND ref node */
      next = rml_forward_vec(&RML_REFDATA(ref_node), 1, next, region_low, region_nbytes);
    }
  }
  /* Adrian Pop, adrpo@ida.liu.se addded 2005-01-11
   * forwarding of array_setnth/array_update elements
   */
  {
    void **ATP= rml_state_ATP;
    rml_sint_t cnt = &rml_array_trail[RML_ARRAY_TRAIL_SIZE] - ATP;
    /* adrpo: is not needed to forward the entire arrays, only the elements pointing into the young generation! */
    /* next = rml_forward_vec(ATP, (rml_uint_t)cnt, next, region_low, region_nbytes); */
    /* take all the arrays present in the trail and scan them for pointers into
     * the younger generation
     */
    for (; --cnt >= 0; ++ATP) {
      void *array_node = *ATP; /* known to be an array node */
      rml_uint_t i;
      rml_uint_t nrelements= RML_GETHDR(array_node);
      if ( RML_HDRISFORWARD(nrelements)) {
        continue;
      }
      nrelements = RML_HDRSLOTS(nrelements);
      /* fprintf(stderr, "\n"); */
      for (i = 0; i < nrelements; i++) {
        /* fprintf(stderr, "{%p[%d]=%p} ", array_node, i, RML_STRUCTDATA(array_node)[i]); */
        next = rml_forward_vec(&(RML_STRUCTDATA(array_node)[i]), 1, next, region_low, region_nbytes);
        /*rml_var_print(array_node);*/
      }
    }
    /* next = rml_forward_vec(ATP, (rml_uint_t)cnt, next, region_low, region_nbytes); */
    rml_state_ATP = &rml_array_trail[RML_ARRAY_TRAIL_SIZE];
  }
  
  /* forward global roots from roots.c */
  {
    struct rml_xgcstate state;
    state.next = next;
    state.region_low = region_low;
    state.region_nbytes = region_nbytes;
    rml_roots_gc(&state);
    next = state.next;
  }

  /* forward roots from user defined heap */
  {
    struct rml_xgcstate state;
    state.next = next;
    state.region_low = region_low;
    state.region_nbytes = region_nbytes;
    rml_user_gc(&state);
    next = state.next;
  }
  return next;
}

static void **rml_collect(void **scan, char *region_low, rml_uint_t region_nbytes, rml_uint_t nliveargs) 
{
  /* void **scan_old = scan; */
  void **next;

  /* forward all roots */
  next = rml_forward_all(nliveargs, scan, region_low, region_nbytes);

  /* compute the transitive closure of the copied roots */
  while (scan < next) {
    rml_uint_t hdr = *(rml_uint_t*)scan;
    rml_uint_t slots = RML_HDRSLOTS(hdr);
    ++scan; /* since slots doesn't include the header itself */
    if ( RML_HDRHASPTRS(hdr))
      next = rml_forward_vec(scan, slots, next, region_low, region_nbytes);
    scan += slots;
  }
  /* debugging if problems appear
  while (scan_old < next)
  {
    void **old = (void**)*scan_old;
    if ( RML_ISIMM(old)) { ++scan_old; continue; }
    ++scan_old;
    if ( (rml_uint_t)((char*)old - region_low) >= region_nbytes)
    {
      if (rml_c_heap_collect_flag && rml_is_allocated_on_c_heap((void**)RML_UNTAGPTR(old)))
        rmldb_var_print(old);
      assert(!(rml_c_heap_collect_flag && rml_is_allocated_on_c_heap((void**)RML_UNTAGPTR(old))));
    }
  }
  */

  /* return final allocation pointer */
  return next;
}

/* Do a major collection. */

static void* rml_major_collection(rml_uint_t nwords, rml_uint_t nliveargs) 
{
  void **next =0, **scan = 0, **rr = 0; 
  rml_sint_t current_inuse = 0;
  rml_sint_t used_before = (rml_sint_t)(rml_current_next - rml_current_region);

  ++rml_majorgc_count;
  if (rml_flag_gclog && !rml_flag_bench) 
  {
    fprintf(stderr, "\n[major collection: N: %ld, F: %ld, O: %ld Y: %ld, O/Y: %ld, W: %ld, C: %ld, L: %ld]",
      (long)(rml_c_heap_region_total_size + nwords + rml_young_size),
      (long)(rml_older_size - (rml_current_next - rml_current_region)),
      (long)rml_older_size,
      (long)rml_young_size,
      (long)(rml_older_size/rml_young_size),
      (long)nwords,
      (long)rml_c_heap_region_total_size,
      (long)nliveargs
      ); 
    fprintf(stderr, "\n[major collection #%lu..", rml_majorgc_count); 
    fflush(stderr);
  }

  /* allocate the reserve region */
  if (!rml_reserve_region) 
  {
    /* 
   * see if we have enough space to add 
   * external C heap data + the young gen + what we need to allocate now (nwords)
   */
    if (((rml_sint_t)rml_c_heap_region_total_size + (rml_sint_t)nwords + (rml_sint_t)rml_young_size)
        < ((rml_sint_t)rml_older_size - ((rml_sint_t)rml_current_next - (rml_sint_t)rml_current_region)))
    {
      /* we have enough space */
      if (rml_flag_gclog && !rml_flag_bench) 
      {
        rml_heap_expansions_count++;
        fprintf(stderr, " keep heap size ..."); fflush(stderr);
      }
      rr = rml_alloc_core(rml_older_size, RML_EXIT_ON_FAILURE);
      if (rr == NULL) 
      {
        fprintf(stderr, "returning NULL (not enough memory) from rml_major_collection!\n");
        fflush(stderr);
        return NULL;
      }
      rml_reserve_region = rr;
    }
    else 
    {
      /* we DON'T have enough space , do a heap expansion directly */
      if (rml_flag_gclog && !rml_flag_bench) 
      {
        rml_heap_expansions_count++;
        fprintf(stderr, " expanding heap (A) ..."); fflush(stderr);
      }
      rml_older_size += rml_c_heap_region_total_size + nwords + rml_young_size;
      rr = rml_alloc_core(rml_older_size, RML_EXIT_ON_FAILURE);
      if (rr == NULL) 
      {
        fprintf(stderr, "returning NULL (not enough memory) from rml_major_collection!\n");
        fflush(stderr);
        return NULL;
      }
      rml_reserve_region = rr;
    }
  }
  if (rml_c_heap_region_total_size != 0) {
    rml_c_heap_collect_flag = 1;
  }
  /* collect the current region, forwarding to the reserve region */
  next = rml_collect(rml_reserve_region, (char*)rml_current_region, (char*)rml_current_next - (char*)rml_current_region, nliveargs);
  assert(next-rml_reserve_region < rml_older_size);
  /* free our rml_c_heap! */
  if (rml_c_heap_collect_flag) {
    rml_c_heap_collect_flag = 0;
    rml_free_c_heap_region();
  }

  /* update the older region state variables */
  /* switch reserve with current */
  rml_current_next = next;
  scan = rml_reserve_region;
  next = rml_current_region;
  rml_current_region = scan;
  rml_reserve_region = next;

  current_inuse = rml_current_next - rml_current_region;

  if (rml_flag_gclog && !rml_flag_bench) 
  {
     rml_heap_expansions_count++;
     fprintf(stderr, " AC O/U: %.3g CO: %ld O/Y: %.3g U/Y: %.3g", 
       (double)rml_older_size/(double)current_inuse,
       (long)(used_before-current_inuse),
       (double)rml_older_size/(double)rml_young_size,
       (double)current_inuse/(double)rml_young_size
       );
     fflush(stderr);
  }

  /* 
   * Check if the older region should be expanded.
   * Expansion is triggered if more than 90% is in use.
   * The new size is chosen to make the heap at least 
   * 50% free or as much as free memory goes and is 
   * still enough.
   */
  current_inuse += nwords + rml_c_heap_region_total_size;

  /* do a heap expansion if needed */
  if ( (100.0*((double)current_inuse)/(double)rml_older_size) > 90.0 ) /* current_inuse > 90/100 * rml_older_size */
  {
    rml_uint_t new_size = 0;

    if (rml_flag_gclog && !rml_flag_bench) {
      rml_heap_expansions_count++;
      fprintf(stderr, " expanding heap (B) [used: %.3g%%] ...", (((double)current_inuse*100.0)/(double)rml_older_size));
      fflush(stderr);
    }

    new_size = (2 * current_inuse) + rml_young_size;
    
    /* expand the older region */
    rml_free_core(rml_reserve_region, rml_older_size);
    rr = rml_alloc_core(new_size, RML_NO_EXIT_ON_FAILURE);
    if (rr == NULL) 
    {
      fprintf(stderr, "returning NULL (not enough memory) from rml_major_collection!\n");
      fflush(stderr);
      return NULL;
    }
    rml_reserve_region = rr;

    if ( !rml_reserve_region ) /* we couldn't allocate that much, try again, with less memory */
    {
      if (rml_flag_gclog && !rml_flag_bench) {
        fprintf(stderr, " (LESS %%50) "); fflush(stderr);
      }
      new_size = current_inuse + rml_young_size; /* try to allocate less */
      rr = rml_alloc_core(new_size, RML_EXIT_ON_FAILURE);
      if (rr == NULL) 
      {
        fprintf(stderr, "returning NULL (not enough memory) from rml_major_collection!\n");
        fflush(stderr);
        return NULL;
      }
      rml_reserve_region = rr;
    }
    else
    {
      if (rml_flag_gclog && !rml_flag_bench) {
          fprintf(stderr, " (MORE 50%%) "); fflush(stderr);
      }
    }
    
    if (rml_c_heap_region_total_size != 0) {
       rml_c_heap_collect_flag = 1;
    }

    next = rml_collect(rml_reserve_region, (char*)rml_current_region, (char*)rml_current_next - (char*)rml_current_region, nliveargs);
    assert(next-rml_reserve_region < new_size);
    /* free our rml_c_heap! */
    if (rml_c_heap_collect_flag) {
       rml_c_heap_collect_flag = 0;
       rml_free_c_heap_region();
    }

    rml_current_next = next;
    rml_free_core(rml_current_region, rml_older_size);
    rml_current_region = rml_reserve_region;
    rml_older_size = new_size;
    rml_reserve_region = NULL;

    current_inuse = rml_current_next - rml_current_region;
  } 
  else if ( /* do a heap shrink if only 15% is used and it was an expansion */
           100.0*((double)current_inuse/(double)rml_older_size) <= 20.0 && /* less than 20% used */
           (double)rml_young_size * 4.0 < (double)rml_older_size  /* older is at least 4 times the young */
          )
  {
    rml_uint_t new_size = 0;
    rml_uint_t ratio = 0;

    ratio = (current_inuse/rml_young_size) + 2 /* we need to have at least young free */;
    if (ratio < 4) 
      ratio = 4;
    else 
      if (ratio % 2) /* not even */
        ratio++; /* make it even */
        
    new_size = ratio * rml_young_size;

    if (rml_flag_gclog && !rml_flag_bench) {
      rml_heap_shrinkings_count++;
      fprintf(stderr, " shrinking heap [ratio: %ld, before: %.3g%%, after: %.3g%%] ...", 
        (long)ratio,
        100.0*((double)current_inuse/(double)rml_older_size),
        100.0*((double)current_inuse/(double)new_size)
        ); 
      fflush(stderr);
    }

    /* shrink the older region */

    /* free the reserve */
    rml_free_core(rml_reserve_region, rml_older_size);
    /* allocate the reserve */
    rr = rml_alloc_core(new_size, RML_EXIT_ON_FAILURE);
    if (rr == NULL) 
    {
      fprintf(stderr, "returning NULL (not enough memory) from rml_major_collection!\n");
      fflush(stderr);
      return NULL;
    }
    rml_reserve_region = rr;

    /* collect */
    next = rml_collect(rml_reserve_region, (char*)rml_current_region, (char*)rml_current_next - (char*)rml_current_region, nliveargs);
    assert(next-rml_reserve_region < new_size);
    /* set the next */
    rml_current_next = next;
    /* free the current */
    rml_free_core(rml_current_region, rml_older_size);  
    /* switch regions reserve becomes next */
    rml_current_region = rml_reserve_region;
    /* set the new size */
    rml_older_size = new_size;
    /* nullize the reserve */
    rml_reserve_region = NULL;

    current_inuse = rml_current_next - rml_current_region;
  } 
  else 
  {
    rml_free_core(rml_reserve_region, rml_older_size);
    rml_reserve_region = NULL;
  }
  /* done with the major collection */
  if (rml_flag_gclog && !rml_flag_bench)
  {
    fprintf(stderr, " used: %.3g%%]", 100.0*((double)current_inuse/(double)rml_older_size));
    fflush(stderr);
  }

  return rml_current_next;
}

/* Do a minor collection. */

void* rml_minor_collection(rml_uint_t nliveargs) {
  void **next;
  rml_uint_t current_nfree = rml_older_size - (rml_current_next - rml_current_region);
  /* increase the minor collections */
  ++rml_minorgc_count;
  
  /*
   * do we have enough space in the current region
   * to also forward the rml_c_heap?
   */
  if (rml_c_heap_region_total_size &&
      (rml_older_size - (rml_current_next - rml_current_region) >
      (rml_young_size + rml_c_heap_region_total_size))) {
    /* we have enough space, signal to go on with the forwarding */
    rml_c_heap_collect_flag = 1;
  }
  /* collect the young region, forwarding to the current region */
  next = rml_collect(rml_current_next, (char*)rml_young_region, rml_young_size * sizeof(void*), nliveargs);
  assert(next-rml_current_next < rml_older_size);

  /* free our rml_c_heap and set the flag on nothing */
  if (rml_c_heap_collect_flag) {
    rml_c_heap_collect_flag = 0;
    rml_free_c_heap_region();
  }

  if (rml_flag_gclog && !rml_flag_bench) {
    fprintf(stderr, "\nminor collection #%ld collected: %ld",
      (long)rml_minorgc_count,
      (long)(current_nfree - (rml_older_size - (next - rml_current_region)))
      );
    fflush(stderr);
  }

  /* update the older region state variables */
  rml_current_next = next;
  current_nfree = rml_older_size - (next - rml_current_region);

  /* check if a major collection should be done */
  if (rml_c_heap_region_total_size || (current_nfree < rml_young_size))
    if (rml_major_collection(0, nliveargs) == NULL)
    {
      fprintf(stderr, "returning NULL (not enough memory) from rml_minor_collection!\n");
      fflush(stderr);
      return NULL;
    }

  return rml_current_next;
}

/* If a minor collection doesn't give us enough memory,
 * try to allocate in the current older region.
 */
void **rml_older_alloc(rml_uint_t nwords, rml_uint_t nargs) {
  void **next = rml_current_next;
  rml_uint_t nfree = rml_older_size - (next - rml_current_region);
  if (!rml_c_heap_region_total_size && nfree >= nwords + rml_young_size)
  {
    rml_current_next = next + nwords;
    return next;
  } else {
    if (rml_major_collection(nwords, nargs) == NULL) 
    {
      fprintf(stderr, "returning NULL (not enough memory) from rml_older_alloc!\n");
      fflush(stderr);
      return NULL;
    }

    next = rml_current_next;
    nfree = rml_older_size - (next - rml_current_region);
    if (nfree >= nwords + rml_young_size) /* RML_YOUNG_SIZE ) */
    {
      rml_current_next = next + nwords;
      return next;
    }
    fprintf(stderr, "returning NULL (not enough memory) from rml_older_alloc!\n");
    fflush(stderr);
    return NULL;
  }
}


#if 0
void shareEqual(void)
{
  void *p, *q;
  void **pp, **qq;
  rml_uint_t slotsIdx;
#if  defined(RML_STATE_APTR) || defined(RML_STATE_LPTR)
  struct rml_state *rmlState = &rml_state;
#endif  /*RML_STATE_APTR || RML_STATE_LPTR*/
  if (*pp != *qq) /* if pointers are different */
  {
    /* check to see if pointers are in young or older */
    if (rml_isYoungOrOlder((void**)RML_UNTAGPTR(pp)) &&
      rml_isYoungOrOlder((void**)RML_UNTAGPTR(qq)))
    {
      rml_uint_t idx = 0;
      /* point *pp to *qq to have sharing. */
      fprintf(stderr, "Sharing %d %p <-> %p\n", slotsIdx, *pp, *qq); fflush(stderr);
      if (*pp > *qq) /* store qq in pp as pp is > than qq */
      {
        RML_STRUCTDATA(p)[slotsIdx] = *qq;
        if (!RML_ISIMM(*qq))
        {
          /* also check here if the array is not already in the trail */
          for (idx = rml_array_trail_size; &rml_array_trail[idx] >= rmlATP; idx--)
            if (rml_array_trail[idx] == *qq) /* if found, do not add again */
            {
              break;
            }
            /* add the address of the array into the roots to be
            taken into consideration at the garbage collection time */
            if( rmlATP == &rml_array_trail[0] ) 
            {
              (void)fprintf(stderr, "Array Trail Overflow!\n"); fflush(stderr);
              rml_exit(1);
            }

            if (!idx) /* we didn't already find it */
              *--rmlATP = p;
        }
      }
      else /* store pp in qq as qq is > than pp */
      {
        RML_STRUCTDATA(q)[slotsIdx] = *pp;
        if (!RML_ISIMM(*pp))
        {
          /* also check here if the array is not already in the trail */
          for (idx = rml_array_trail_size; &rml_array_trail[idx] >= rmlATP; idx--)
            if (rml_array_trail[idx] == *pp) /* if found, do not add again */
            {
              break;
            }
            /* add the address of the array into the roots to be
            taken into consideration at the garbage collection time */
            if( rmlATP == &rml_array_trail[0] ) 
            {
              (void)fprintf(stderr, "Array Trail Overflow!\n"); fflush(stderr);
              rml_exit(1);
            }

            if (!idx) /* we didn't already find it */
              *--rmlATP = q;
        }
      }
    } 
  }
}
#endif


/******************************************/
/* functions previously part of yacclib.c */
/******************************************/

/*
 * functions to print externally allocated values
 */
extern void print_icon(FILE*, void*);
extern void print_rcon(FILE*, void*);
extern void print_scon(FILE*, void*);

void *alloc_words(unsigned nwords) {
  void* p = NULL;
  rml_c_heap_region_t* current = rml_c_heap;
  if (rml_flag_gclog)
    rml_gc_start_clock = rml_prim_clock();

  /* try to find a big enough place in the existing regions */
  do {
    p = (void*)current->next;
    if ((current->next_region == NULL) && (void**)(p)+(nwords) < current->limit) {
      /* found our zone, update the next */
      current->next = (void**)(p)+(nwords);
      assert(current->next < current->limit);
      /* update total count */
      rml_c_heap_region_total_size += nwords;
      rml_allocated_from_c += nwords;

      if (rml_flag_gclog) {
        rml_gc_end_clock = rml_prim_clock();
        rml_gc_total_time += (double)(rml_gc_end_clock - rml_gc_start_clock) / (double)RML_CLOCKS_PER_SEC;
      }
      /* return the pointer to available region */
      return p;
    }
    /* else, search the next zone */
    if (current->next_region == NULL)
      break;
    else
      current = current->next_region;
  } while (1);
  /* here we haven't found a big enough zone, create one */
  if (nwords > RML_C_HEAP_REGION_SIZE)
    current->next_region = rml_alloc_c_heap_region(nwords+1024);
  else
    current->next_region = rml_alloc_c_heap_region(RML_C_HEAP_REGION_SIZE);
  /* we allocated our region, use it now */
  current = current->next_region;
  p = (void*)current->next;
  /* update the next */
  current->next = (void**)(p)+(nwords);
  assert(current->next < current->limit);
  /* update total count */
  rml_c_heap_region_total_size += nwords;
  rml_allocated_from_c += nwords;

  if (rml_flag_gclog) {
    rml_gc_end_clock = rml_prim_clock();
    rml_gc_total_time += (double)(rml_gc_end_clock - rml_gc_start_clock) / (double)RML_CLOCKS_PER_SEC;
  }
  /* return the pointer to available region */
  return p;
}

void print_icon(FILE *fp, void *icon) {
  fprintf(fp, "%ld", (long)RML_UNTAGFIXNUM(icon));
}

void print_rcon(FILE *fp, void *rcon) {
  fprintf(fp, "%.15g", rml_prim_get_real(rcon));
}

void print_scon(FILE *fp, void *scon) {
  fprintf(fp, "%.*s", (int)RML_HDRSTRLEN(RML_GETHDR(scon)), RML_STRINGDATA(scon));
}

void *mk_rcon(double d) {
  struct rml_real *p = alloc_words(RML_SIZE_DBL/RML_SIZE_INT + 1);
  rml_prim_set_real(p, d);
  p->header = RML_REALHDR;
  return RML_TAGPTR(p);
}

void *mk_scon_string_sharing(const char *s) {
  rml_uint_t nbytes = strlen(s);
  rml_uint_t header = RML_STRINGHDR(nbytes);
  rml_uint_t nwords = RML_HDRSLOTS(header) + 1;
  if (!rml_string_cache_index) /* no string in the cache */
  {
    struct rml_string *p = alloc_words(nwords);
    p->header = header;
    memcpy(p->data, s, nbytes+1); /* including terminating '\0' */
    if (rml_string_cache_index < RML_STRING_CACHE_MAX &&
        nbytes < RML_SHARED_STRING_MAX) /* add to sharing only if less than RML_SHARED_STRING_MAX */
      rml_string_cache[rml_string_cache_index++] = p;
    return RML_TAGPTR(p);
  }
  /* else, try to find if we already have the same string in the heap */
  {
    unsigned int i;
    struct rml_string *p;
    for (i = 0; i < rml_string_cache_index; i++)
    {
      p = rml_string_cache[i];
      if (strcmp(p->data,s) == 0)
      {
        rml_total_shared_strings++;
        rml_total_shared_strings_words += nwords;
        return RML_TAGPTR(p);
      }
    }
    /* no string found in cache */
    {
      struct rml_string *p = alloc_words(nwords);
      p->header = header;
      memcpy(p->data, s, nbytes+1); /* including terminating '\0' */
      if (rml_string_cache_index < RML_STRING_CACHE_MAX &&
          nbytes < RML_SHARED_STRING_MAX) /* add to sharing only if less than RML_SHARED_STRING_MAX */
        rml_string_cache[rml_string_cache_index++] = p;
      return RML_TAGPTR(p);
    }
  }
}

void *mk_scon_no_string_sharing(const char *s) {
  rml_uint_t nbytes = strlen(s);
  rml_uint_t header = RML_STRINGHDR(nbytes);
  rml_uint_t nwords = RML_HDRSLOTS(header) + 1;
  struct rml_string *p = alloc_words(nwords);
  p->header = header;
  memcpy(p->data, s, nbytes+1); /* including terminating '\0' */
  return RML_TAGPTR(p);
}

void *mk_scon(const char *s) {
  return rml_string_sharing ? 
       mk_scon_string_sharing(s) : mk_scon_no_string_sharing(s);
}

void *mk_box0(unsigned ctor) {
  struct rml_struct *p = alloc_words(1);
  p->header = RML_STRUCTHDR(0, ctor);
  return RML_TAGPTR(p);
}

void *mk_box1(unsigned ctor, void *x0) {
  struct rml_struct *p = alloc_words(2);
  p->header = RML_STRUCTHDR(1, ctor);
  p->data[0] = x0;
  return RML_TAGPTR(p);
}

void *mk_box2(unsigned ctor, void *x0, void *x1) {
  struct rml_struct *p = alloc_words(3);
  p->header = RML_STRUCTHDR(2, ctor);
  p->data[0] = x0;
  p->data[1] = x1;
  return RML_TAGPTR(p);
}

void *mk_box3(unsigned ctor, void *x0, void *x1, void *x2) {
  struct rml_struct *p = alloc_words(4);
  p->header = RML_STRUCTHDR(3, ctor);
  p->data[0] = x0;
  p->data[1] = x1;
  p->data[2] = x2;
  return RML_TAGPTR(p);
}

void *mk_box4(unsigned ctor, void *x0, void *x1, void *x2, void *x3) {
  struct rml_struct *p = alloc_words(5);
  p->header = RML_STRUCTHDR(4, ctor);
  p->data[0] = x0;
  p->data[1] = x1;
  p->data[2] = x2;
  p->data[3] = x3;
  return RML_TAGPTR(p);
}

void *mk_box5(unsigned ctor, void *x0, void *x1, void *x2, void *x3, void *x4) {
  struct rml_struct *p = alloc_words(6);
  p->header = RML_STRUCTHDR(5, ctor);
  p->data[0] = x0;
  p->data[1] = x1;
  p->data[2] = x2;
  p->data[3] = x3;
  p->data[4] = x4;
  return RML_TAGPTR(p);
}

void *mk_box6(unsigned ctor, void *x0, void *x1, void *x2, void *x3, void *x4,
    void *x5) {
  struct rml_struct *p = alloc_words(7);
  p->header = RML_STRUCTHDR(6, ctor);
  p->data[0] = x0;
  p->data[1] = x1;
  p->data[2] = x2;
  p->data[3] = x3;
  p->data[4] = x4;
  p->data[5] = x5;
  return RML_TAGPTR(p);
}

void *mk_box7(unsigned ctor, void *x0, void *x1, void *x2, void *x3, void *x4,
    void *x5, void *x6) {
  struct rml_struct *p = alloc_words(8);
  p->header = RML_STRUCTHDR(7, ctor);
  p->data[0] = x0;
  p->data[1] = x1;
  p->data[2] = x2;
  p->data[3] = x3;
  p->data[4] = x4;
  p->data[5] = x5;
  p->data[6] = x6;
  return RML_TAGPTR(p);
}

void *mk_box8(unsigned ctor, void *x0, void *x1, void *x2, void *x3, void *x4,
    void *x5, void *x6, void *x7) {
  struct rml_struct *p = alloc_words(9);
  p->header = RML_STRUCTHDR(8, ctor);
  p->data[0] = x0;
  p->data[1] = x1;
  p->data[2] = x2;
  p->data[3] = x3;
  p->data[4] = x4;
  p->data[5] = x5;
  p->data[6] = x6;
  p->data[7] = x7;
  return RML_TAGPTR(p);
}

void *mk_box9(unsigned ctor, void *x0, void *x1, void *x2, void *x3, void *x4,
    void *x5, void *x6, void *x7, void *x8) {
  struct rml_struct *p = alloc_words(10);
  p->header = RML_STRUCTHDR(9, ctor);
  p->data[0] = x0;
  p->data[1] = x1;
  p->data[2] = x2;
  p->data[3] = x3;
  p->data[4] = x4;
  p->data[5] = x5;
  p->data[6] = x6;
  p->data[7] = x7;
  p->data[8] = x8;
  return RML_TAGPTR(p);
}

void *mk_box10(unsigned ctor, void *x0, void *x1, void *x2, void *x3, void *x4,
    void *x5, void *x6, void *x7, void *x8, void *x9) {
  struct rml_struct *p = alloc_words(11);
  p->header = RML_STRUCTHDR(10, ctor);
  p->data[0] = x0;
  p->data[1] = x1;
  p->data[2] = x2;
  p->data[3] = x3;
  p->data[4] = x4;
  p->data[5] = x5;
  p->data[6] = x6;
  p->data[7] = x7;
  p->data[8] = x8;
  p->data[9] = x9;
  return RML_TAGPTR(p);
}

void *mk_box11(unsigned ctor, void *x0, void *x1, void *x2, void *x3, void *x4,
    void *x5, void *x6, void *x7, void *x8, void *x9, void* x10) {
  struct rml_struct *p = alloc_words(12);
  p->header = RML_STRUCTHDR(11, ctor);
  p->data[0] = x0;
  p->data[1] = x1;
  p->data[2] = x2;
  p->data[3] = x3;
  p->data[4] = x4;
  p->data[5] = x5;
  p->data[6] = x6;
  p->data[7] = x7;
  p->data[8] = x8;
  p->data[9] = x9;
  p->data[10] = x10;
  return RML_TAGPTR(p);
}

void *mk_box12(unsigned ctor, void *x0, void *x1, void *x2, void *x3, void *x4,
    void *x5, void *x6, void *x7, void *x8, void *x9, void* x10, void* x11) {
  struct rml_struct *p = alloc_words(13);
  p->header = RML_STRUCTHDR(12, ctor);
  p->data[0] = x0;
  p->data[1] = x1;
  p->data[2] = x2;
  p->data[3] = x3;
  p->data[4] = x4;
  p->data[5] = x5;
  p->data[6] = x6;
  p->data[7] = x7;
  p->data[8] = x8;
  p->data[9] = x9;
  p->data[10] = x10;
  p->data[11] = x11;
  return RML_TAGPTR(p);
}

void *mk_box13(unsigned ctor, void *x0, void *x1, void *x2, void *x3, void *x4,
    void *x5, void *x6, void *x7, void *x8, void *x9, void* x10, void* x11, void* x12) {
  struct rml_struct *p = alloc_words(14);
  p->header = RML_STRUCTHDR(13, ctor);
  p->data[0] = x0;
  p->data[1] = x1;
  p->data[2] = x2;
  p->data[3] = x3;
  p->data[4] = x4;
  p->data[5] = x5;
  p->data[6] = x6;
  p->data[7] = x7;
  p->data[8] = x8;
  p->data[9] = x9;
  p->data[10] = x10;
  p->data[11] = x11;
  p->data[12] = x12;
  return RML_TAGPTR(p);
}

void *mk_box14(unsigned ctor, void *x0, void *x1, void *x2, void *x3, void *x4,
    void *x5, void *x6, void *x7, void *x8, void *x9, void* x10, void* x11, void* x12, void* x13) {
  struct rml_struct *p = alloc_words(15);
  p->header = RML_STRUCTHDR(14, ctor);
  p->data[0] = x0;
  p->data[1] = x1;
  p->data[2] = x2;
  p->data[3] = x3;
  p->data[4] = x4;
  p->data[5] = x5;
  p->data[6] = x6;
  p->data[7] = x7;
  p->data[8] = x8;
  p->data[9] = x9;
  p->data[10] = x10;
  p->data[11] = x11;
  p->data[12] = x12;
  p->data[13] = x13;
  return RML_TAGPTR(p);
}

void *mk_box15(unsigned ctor, void *x0, void *x1, void *x2, void *x3, void *x4,
    void *x5, void *x6, void *x7, void *x8, void *x9, void* x10, void* x11, void* x12, void* x13, void* x14) {
  struct rml_struct *p = alloc_words(16);
  p->header = RML_STRUCTHDR(15, ctor);
  p->data[0] = x0;
  p->data[1] = x1;
  p->data[2] = x2;
  p->data[3] = x3;
  p->data[4] = x4;
  p->data[5] = x5;
  p->data[6] = x6;
  p->data[7] = x7;
  p->data[8] = x8;
  p->data[9] = x9;
  p->data[10] = x10;
  p->data[11] = x11;
  p->data[12] = x12;
  p->data[13] = x13;
  p->data[14] = x14;
  return RML_TAGPTR(p);
}

void *mk_box16(unsigned ctor, void *x0, void *x1, void *x2, void *x3, void *x4,
    void *x5, void *x6, void *x7, void *x8, void *x9, void* x10, void* x11, void* x12, void* x13, void* x14, void* x15) {
  struct rml_struct *p = alloc_words(17);
  p->header = RML_STRUCTHDR(16, ctor);
  p->data[0] = x0;
  p->data[1] = x1;
  p->data[2] = x2;
  p->data[3] = x3;
  p->data[4] = x4;
  p->data[5] = x5;
  p->data[6] = x6;
  p->data[7] = x7;
  p->data[8] = x8;
  p->data[9] = x9;
  p->data[10] = x10;
  p->data[11] = x11;
  p->data[12] = x12;
  p->data[13] = x13;
  p->data[14] = x14;
  p->data[15] = x15;
  return RML_TAGPTR(p);
}


/* old stuff

void *mk_bcon(double d) {
  if (d > 0)
    return RML_TRUE;
  return RML_FALSE;
}

void *mk_icon(int i) {
  return RML_IMMEDIATE(RML_TAGFIXNUM((rml_sint_t)i));
}

void *mk_none(void) {
  static struct rml_header none = { RML_STRUCTHDR(0, 0) };
  return RML_TAGPTR(&none);
}

void *mk_some(void *x) {
  return mk_box1(1, x);
}

void *mk_nil(void) {
  return RML_TAGPTR(&rml_prim_nil);
}

void *mk_cons(void *car, void *cdr) {
  return mk_box2(1, car, cdr);
}

*/


