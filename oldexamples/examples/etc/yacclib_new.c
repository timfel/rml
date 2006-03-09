/* yacclib.c */
#include <errno.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "rml.h"
#include "yacclib.h"


void* RML_GET(rml_value_t* x)
{
	if (!x) return RML_TAGPTR(&rml_prim_nil);
	if (x->type == RML_INT) return (void*)x->value;
	else if (x->type == RML_CONST) return RML_TAGPTR(x->value); 
		 else return c2rml_heap[x->ptr_index];
}

void* RML_GET_AND_FREE(rml_value_t* x)
{
	void *p;
	if (!x) return RML_TAGPTR(&rml_prim_nil);
	if (x->type == RML_INT) p = (void*)x->value;
	else if (x->type == RML_CONST) p = RML_TAGPTR(x->value); 
		 else p = c2rml_heap[x->ptr_index];
	free(x);
	return p;
}



/* only add the reference if the value 
 * is not immediate 
 * meaning x.type != RML_INT 
 */
#define  RML_SET_BOX_SLOT(SLOT_INDEX, X)	\
	p->data[SLOT_INDEX] = RML_GET(X); \
	if (X->type > RML_CONST)\
	{\
		remove_c2rml_pointer_ref(X);\
		free(X); \
	}


#define C2RML_HEAP_SIZE (100*1024)
void *c2rml_heap[C2RML_HEAP_SIZE];
unsigned long c2rml_heap_index = 0;

unsigned long add_c2rml_pointer_ref(void *p)
{
	if (c2rml_heap_index > C2RML_HEAP_SIZE) 
	{
		fprintf(stderr, "\nToo many refereces from C into RML_HEAP");
		rml_exit(2);
	}
	c2rml_heap[c2rml_heap_index++] = RML_TAGPTR(p);
	return (c2rml_heap_index-1);
}

void remove_c2rml_pointer_ref(rml_value_t* x)
{
	return;
	if (x->type == RML_INT || x->type == RML_CONST) return;
	/* move the last array element inside this position */
	c2rml_heap[x->ptr_index] = c2rml_heap[c2rml_heap_index-1];
	/* decrement the heap index */
	c2rml_heap_index--;
}

extern void rml_user_gc(struct rml_xgcstate *state) 
{
	/*unsigned long i;*/
	void **TP = c2rml_heap;
	/*printf("\n==============before===================\n");
	for (i = 0; i < c2rml_heap_index; i++) 
	{
		printf("\n#%lu = [", i); rml_var_print(c2rml_heap[i]); printf("]");
	}*/
	rml_user_gc_callback(state, TP, c2rml_heap_index);
	fprintf(stderr, " [rml_user_gc called index=%lu]", c2rml_heap_index);
	/*printf("\n==============after ===================\n");
	for (i = 0; i < c2rml_heap_index; i++) 
	{
		printf("\n#%lu = [", i); rml_var_print(c2rml_heap[i]); printf("]");
	}*/
}

void *alloc_words(unsigned nwords)
{
	/* adrpo changed 2004-11-07 */
	rml_allocated_from_c = rml_allocated_from_c + nwords;
	return rml_prim_alloc(nwords, rml_state_nrArgs);
}

void print_icon(FILE *fp, rml_value_t* icon)
{
    fprintf(fp, "%d", RML_UNTAGFIXNUM(RML_GET(icon)));
}

void print_rcon(FILE *fp, rml_value_t* rcon)
{
    fprintf(fp, "%.15g", rml_prim_get_real(RML_GET(rcon)));
}

void print_scon(FILE *fp, rml_value_t* scon)
{
    fprintf(fp, "%.*s", 
		RML_HDRSTRLEN(RML_GETHDR(RML_GET(scon))), 
		RML_STRINGDATA(RML_GET(scon)));
}


/* this function constructs a rml_value_t*
 * from a box->data[index] 
 */
rml_value_t* get_box_element(rml_value_t* x, int index)
{
	unsigned long i; rml_uint_t phdr, slots;
	void *p; 
	rml_value_t* tmp;
	/* we can't be sure we got a rml_value_t that is a BOX 
	 * let's see about that: */
	/* - is it NULL?? */
	if (!x) return NULL;
	/* - is it INT, CONST, STRING, REAL? */
	if (x->type != RML_BOX) return NULL;
	/* - now we're sure it's a BOX get the addres of the pointer we want */
	p = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(RML_GET(x)), index));

	/* now we need a rml_value_t to return */
	tmp = (rml_value_t*)malloc(sizeof(rml_value_t));
	if (!tmp) { fprintf(stderr, "malloc could not alloc memory!"); rml_exit(2); }

	/* before we search for the address in the external roots we have to 
	 * see if the address points to an imediate (read: INT) value or a constant value 
	 * (read: rml_prim_nil or none)
	 */
	/* let's see if is immediate */
	if (RML_ISIMM(p)) 
	{
		tmp->type = RML_INT;
		tmp->value = p; 
		tmp->ptr_index = 0;
		return tmp;
	}
	/* let's see if is a constant */
	if (p == RML_TAGPTR(&rml_prim_nil)) 
	{
		tmp->type = RML_CONST;
		tmp->value = (void*)&rml_prim_nil;
		tmp->ptr_index = 0;
		return tmp;
	}
	/* let's see if is "none" */
	/* none is a struct with 0 header and 0 slots (like rml_prim_nil) */
	phdr = RML_GETHDR(p);
	/* if is a struct we go further to test the slots 
	 * if not, we just search for it in the external roots
	 */
	/* if (phdr == RML_STRUCTHDR(0, 0)) maybe this does work better */
	if (RML_HDRISSTRUCT(phdr)) /* XXX: does it work if header and slots is 0? TEST!! */
	{
		slots = RML_HDRSLOTS(phdr);
		if (!phdr && !slots)
		{
			static struct rml_header none = { RML_STRUCTHDR(0, 0) };
			tmp->type = RML_CONST;
			tmp->value = (void*)&none;
			tmp->ptr_index = 0;
			return tmp;
		}
	}
	/* now that we know is some meaningful box 
	 * search for the address in the external roots */
	for (i = 0; i < c2rml_heap_index; i++)
	{
		/* if they have the same tagged pointer */
		if (p == c2rml_heap[i]) break;
	}
	/* if we haven't found it, that's bad!!! */
	if (i == c2rml_heap_index) 
	{ 
		/* somebody played with our pointers meantime BAD, BAD, boy! */
		fprintf(stderr, "get_box_element: could not find the address %p in the external roots", p); 
		rml_exit(2); 
	} 
	/* found it, now box it for our use, let's see what type it has 
	 * RML_INT, RML_CONST is out of the question as we tested for that already
	 * RML_STRING, RML_REAL, RML_BOX comes into play now
	 */
	phdr = RML_GETHDR(p);
	if (phdr == RML_REALHDR) tmp->type = RML_REAL;
	else if (RML_HDRISSTRING(phdr)) tmp->type = RML_STRING;
		 else if (RML_HDRISSTRUCT(phdr)) tmp->type = RML_BOX;
	tmp->ptr_index = i;
	tmp->value = 0;
	return tmp;
 }

rml_value_t* mk_bcon(int flag)
{
	return flag ? mk_icon(1) : mk_icon(0);
}

rml_value_t* mk_icon(int i)
{
	rml_value_t* tmp = (rml_value_t*)malloc(sizeof(rml_value_t));
	if (!tmp) { fprintf(stderr, "malloc could not alloc memory!"); rml_exit(2); }

	tmp->type = RML_INT;
	tmp->value = RML_IMMEDIATE(RML_TAGFIXNUM((rml_sint_t)i));
	tmp->ptr_index = 0;

	return tmp;
}

rml_value_t* mk_rcon(double d)
{
    struct rml_real *p = alloc_words(RML_SIZE_DBL/RML_SIZE_INT + 1);

	rml_value_t* tmp = (rml_value_t*)malloc(sizeof(rml_value_t));
	if (!tmp) { fprintf(stderr, "malloc could not alloc memory!"); rml_exit(2); }

    rml_prim_set_real(p, d);
    p->header = RML_REALHDR;

	tmp->type = RML_REAL;
	tmp->ptr_index = add_c2rml_pointer_ref(p);
	tmp->value = 0;
    return tmp;
}

rml_value_t* mk_scon(char *s)
{
    unsigned nbytes = strlen(s);
    unsigned header = RML_STRINGHDR(nbytes);
    unsigned nwords = RML_HDRSLOTS(header) + 1;
    struct rml_string *p = alloc_words(nwords);

	rml_value_t* tmp = (rml_value_t*)malloc(sizeof(rml_value_t));
	if (!tmp) { fprintf(stderr, "malloc could not alloc memory!"); rml_exit(2); }

    p->header = header;
    memcpy(p->data, s, nbytes+1);	/* including terminating '\0' */

	tmp->type = RML_STRING;
	tmp->ptr_index = add_c2rml_pointer_ref(p);
	tmp->value = 0;

    return tmp;
}

rml_value_t* mk_nil(void)
{
	rml_value_t* tmp = (rml_value_t*)malloc(sizeof(rml_value_t));
	if (!tmp) { fprintf(stderr, "malloc could not alloc memory!"); rml_exit(2); }

	tmp->type = RML_CONST;
	tmp->value = (void*)(&rml_prim_nil);
	tmp->ptr_index = 0;

    return tmp;
}

rml_value_t* mk_cons(rml_value_t* car, rml_value_t* cdr)
{
    return mk_box2(1, car, cdr);
}

void* rml_mk_cons(void* car, void* cdr)
{
    struct rml_struct *p = alloc_words(3);
	p->header = RML_CONSHDR;
    p->data[0] = car;
    p->data[1] = cdr;
    return RML_TAGPTR(p);
}

rml_value_t* mk_none(void)
{
    static struct rml_header none = { RML_STRUCTHDR(0, 0) };

	rml_value_t* tmp = (rml_value_t*)malloc(sizeof(rml_value_t));
	if (!tmp) { fprintf(stderr, "malloc could not alloc memory!"); rml_exit(2); }

	tmp->type = RML_CONST;
	tmp->value = (void*)(&none);
	tmp->ptr_index = 0;

	return tmp;
}

rml_value_t* mk_some(rml_value_t* x)
{
	/* not needed to add the &mk_box1 here, already done
	 * in mk_box1. also removing of car and cdr not needed
	 */
    return mk_box1(1, x);
}

rml_value_t* mk_box0(unsigned ctor)
{
    struct rml_struct *p = alloc_words(1);

	rml_value_t* tmp = (rml_value_t*)malloc(sizeof(rml_value_t));
	if (!tmp) { fprintf(stderr, "malloc could not alloc memory!"); rml_exit(2); }

    p->header = RML_STRUCTHDR(0, ctor);

	tmp->type = RML_BOX;
	tmp->value = 0;
	tmp->ptr_index = add_c2rml_pointer_ref(p);

	return tmp;
}

rml_value_t* mk_box1(unsigned ctor, rml_value_t* x0)
{
    struct rml_struct *p = alloc_words(2);

	rml_value_t* tmp = (rml_value_t*)malloc(sizeof(rml_value_t));
	if (!tmp) { fprintf(stderr, "malloc could not alloc memory!"); rml_exit(2); }

    p->header = RML_STRUCTHDR(1, ctor);

	RML_SET_BOX_SLOT(0, x0);

	tmp->type = RML_BOX;
	tmp->value = 0;
	tmp->ptr_index = add_c2rml_pointer_ref(p);

    return tmp;
}

rml_value_t* mk_box2(unsigned ctor, rml_value_t* x0, rml_value_t* x1)
{
    struct rml_struct *p = alloc_words(3);

	rml_value_t* tmp = (rml_value_t*)malloc(sizeof(rml_value_t));
	if (!tmp) { fprintf(stderr, "malloc could not alloc memory!"); rml_exit(2); }

    p->header = RML_STRUCTHDR(2, ctor);

	if ((x0->type == x1->type) && (x0->ptr_index == x1->ptr_index)) 
		printf("\n\nWHATTTTTTTTTTTTTTTTTTTTTTTT????????????  !!!!!!!!!!!!!!\n\n");

	RML_SET_BOX_SLOT (0, x0);
	RML_SET_BOX_SLOT (1, x1);

	tmp->type = RML_BOX;
	tmp->value = 0;
	tmp->ptr_index = add_c2rml_pointer_ref(p);

    return tmp;
}

rml_value_t* mk_box3(unsigned ctor, rml_value_t* x0, rml_value_t* x1, rml_value_t* x2)
{
    struct rml_struct *p = alloc_words(4);

	rml_value_t* tmp = (rml_value_t*)malloc(sizeof(rml_value_t));
	if (!tmp) { fprintf(stderr, "malloc could not alloc memory!"); rml_exit(2); }

    p->header = RML_STRUCTHDR(3, ctor);

	RML_SET_BOX_SLOT (0, x0);
	RML_SET_BOX_SLOT (1, x1);
	RML_SET_BOX_SLOT (2, x2);

	tmp->type = RML_BOX;
	tmp->value = 0;
	tmp->ptr_index = add_c2rml_pointer_ref(p);

    return tmp;
}

rml_value_t* mk_box4(unsigned ctor, rml_value_t* x0, rml_value_t* x1, rml_value_t* x2, rml_value_t* x3)
{
    struct rml_struct *p = alloc_words(5);

	rml_value_t* tmp = (rml_value_t*)malloc(sizeof(rml_value_t));
	if (!tmp) { fprintf(stderr, "malloc could not alloc memory!"); rml_exit(2); }

    p->header = RML_STRUCTHDR(4, ctor);

	RML_SET_BOX_SLOT (0, x0);
	RML_SET_BOX_SLOT (1, x1);
	RML_SET_BOX_SLOT (2, x2);
	RML_SET_BOX_SLOT (3, x3);

	tmp->type = RML_BOX;
	tmp->value = 0;
	tmp->ptr_index = add_c2rml_pointer_ref(p);

    return tmp;
}

rml_value_t* mk_box5(unsigned ctor, 
	rml_value_t* x0, 
	rml_value_t* x1, 
	rml_value_t* x2, 
	rml_value_t* x3, 
	rml_value_t* x4)
{
    struct rml_struct *p = alloc_words(6);

	rml_value_t* tmp = (rml_value_t*)malloc(sizeof(rml_value_t));
	if (!tmp) { fprintf(stderr, "malloc could not alloc memory!"); rml_exit(2); }

    p->header = RML_STRUCTHDR(5, ctor);

	RML_SET_BOX_SLOT (0, x0);
	RML_SET_BOX_SLOT (1, x1);
	RML_SET_BOX_SLOT (2, x2);
	RML_SET_BOX_SLOT (3, x3);
	RML_SET_BOX_SLOT (4, x4);

	tmp->type = RML_BOX;
	tmp->value = 0;
	tmp->ptr_index = add_c2rml_pointer_ref(p);

    return tmp;
}

rml_value_t* mk_box6(unsigned ctor, 
	rml_value_t* x0, 
	rml_value_t* x1, 
	rml_value_t* x2, 
	rml_value_t* x3, 
	rml_value_t* x4,
	rml_value_t* x5)
{
    struct rml_struct *p = alloc_words(7);

	rml_value_t* tmp = (rml_value_t*)malloc(sizeof(rml_value_t));
	if (!tmp) { fprintf(stderr, "malloc could not alloc memory!"); rml_exit(2); }

    p->header = RML_STRUCTHDR(6, ctor);

	RML_SET_BOX_SLOT (0, x0);
	RML_SET_BOX_SLOT (1, x1);
	RML_SET_BOX_SLOT (2, x2);
	RML_SET_BOX_SLOT (3, x3);
	RML_SET_BOX_SLOT (4, x4);
	RML_SET_BOX_SLOT (5, x5);

	tmp->type = RML_BOX;
	tmp->value = 0;
	tmp->ptr_index = add_c2rml_pointer_ref(p);

    return tmp;
}

rml_value_t* mk_box7(unsigned ctor, 
	rml_value_t* x0, 
	rml_value_t* x1, 
	rml_value_t* x2, 
	rml_value_t* x3, 
	rml_value_t* x4,
	rml_value_t* x5, 
	rml_value_t* x6)
{
    struct rml_struct *p = alloc_words(8);

	rml_value_t* tmp = (rml_value_t*)malloc(sizeof(rml_value_t));
	if (!tmp) { fprintf(stderr, "malloc could not alloc memory!"); rml_exit(2); }

    p->header = RML_STRUCTHDR(7, ctor);

	RML_SET_BOX_SLOT (0, x0);
	RML_SET_BOX_SLOT (1, x1);
	RML_SET_BOX_SLOT (2, x2);
	RML_SET_BOX_SLOT (3, x3);
	RML_SET_BOX_SLOT (4, x4);
	RML_SET_BOX_SLOT (5, x5);
	RML_SET_BOX_SLOT (6, x6);

	tmp->type = RML_BOX;
	tmp->value = 0;
	tmp->ptr_index = add_c2rml_pointer_ref(p);

    return tmp;
}

rml_value_t* mk_box8(unsigned ctor, 
	rml_value_t* x0, 
	rml_value_t* x1, 
	rml_value_t* x2, 
	rml_value_t* x3, 
	rml_value_t* x4,
	rml_value_t* x5, 
	rml_value_t* x6, 
	rml_value_t* x7)
{
    struct rml_struct *p = alloc_words(9);

	rml_value_t* tmp = (rml_value_t*)malloc(sizeof(rml_value_t));
	if (!tmp) { fprintf(stderr, "malloc could not alloc memory!"); rml_exit(2); }

    p->header = RML_STRUCTHDR(8, ctor);

	RML_SET_BOX_SLOT (0, x0);
	RML_SET_BOX_SLOT (1, x1);
	RML_SET_BOX_SLOT (2, x2);
	RML_SET_BOX_SLOT (3, x3);
	RML_SET_BOX_SLOT (4, x4);
	RML_SET_BOX_SLOT (5, x5);
	RML_SET_BOX_SLOT (6, x6);
	RML_SET_BOX_SLOT (7, x7);

	tmp->type = RML_BOX;
	tmp->value = 0;
	tmp->ptr_index = add_c2rml_pointer_ref(p);

    return tmp;
}

rml_value_t* mk_box9(unsigned ctor, 
	rml_value_t* x0, 
	rml_value_t* x1, 
	rml_value_t* x2, 
	rml_value_t* x3, 
	rml_value_t* x4,
	rml_value_t* x5, 
	rml_value_t* x6, 
	rml_value_t* x7, 
	rml_value_t* x8)
{
    struct rml_struct *p = alloc_words(10);

	rml_value_t* tmp = (rml_value_t*)malloc(sizeof(rml_value_t));
	if (!tmp) { fprintf(stderr, "malloc could not alloc memory!"); rml_exit(2); }

    p->header = RML_STRUCTHDR(9, ctor);

	RML_SET_BOX_SLOT (0, x0);
	RML_SET_BOX_SLOT (1, x1);
	RML_SET_BOX_SLOT (2, x2);
	RML_SET_BOX_SLOT (3, x3);
	RML_SET_BOX_SLOT (4, x4);
	RML_SET_BOX_SLOT (5, x5);
	RML_SET_BOX_SLOT (6, x6);
	RML_SET_BOX_SLOT (7, x7);
	RML_SET_BOX_SLOT (8, x8);

	tmp->type = RML_BOX;
	tmp->value = 0;
	tmp->ptr_index = add_c2rml_pointer_ref(p);

    return tmp;
}
