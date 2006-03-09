/* yacclib.h */

/* Adrian Pop, adrpo@ida.liu.se, 2004-11-11
 * Instead of returning pointers from mk_* functions we
 * return an rml_value
 * So, the idea is to not let the mutator have our 
 * pointers and assign them away, because during a 
 * collection we need to forward them to the next 
 * generation. 
 */
enum rml_value_t_enum {
		RML_INT,	/* immediate value, set into rml_type_t->value */
		RML_CONST,  /* &rml_prim_nil or &none, set into rml_type_t->value */
		RML_REAL,   /* real, goes to external roots */
		RML_STRING, /* string, goes to external roots */
		RML_BOX     /* box, goes to external roots */
};  

typedef struct rml_value 
{
	/* type of rml_value, immediate (INT), pointer (REAL, STRING, BOX) */
	enum rml_value_t_enum type;

	/* the int values are imediate */
	/* the static struct are also stored here and their
	 * type is set to RML_CONST */
	void *value;

	/* for the other values we have an index inside the c2rml_heap 
	 * which we will use at collection time as external roots 
	 */
	unsigned long ptr_index; 
} rml_value_t;

/* use RML_GET to get the real value from the rml_value 
 * this will return either a void*(int) if the value is immediate or
 * the tagged pointer if the type is RML_CONST
 * the actual tagged pointer of the rml real/string/boxed value 
 */
extern void* RML_GET(rml_value_t* x);
extern void* RML_GET_AND_FREE(rml_value_t* x);

/* some definitions of the external roots vector */
/* we should move all yacclib.h/yacclib.c inside the RML */
#define C2RML_HEAP_SIZE (100*1024)
extern void *c2rml_heap[C2RML_HEAP_SIZE];
extern unsigned long c2rml_heap_index;
#define CLEAR_EXTERNAL_ROOTS	c2rml_heap_index=0;

/* used inside the mk_* functions to add/remove 
 * the newly allocated address 
 * to the c2rml_heap (external roots) array.
 */
unsigned long add_c2rml_pointer_ref(void *p);
void remove_c2rml_pointer_ref(rml_value_t* x);

extern void print_icon(FILE*, rml_value_t*);
extern void print_rcon(FILE*, rml_value_t*);
extern void print_scon(FILE*, rml_value_t*);

extern void *alloc_words(unsigned nwords);
/* this function constructs a rml_value_t*
 * from a box->data[index] */
rml_value_t* get_box_element(rml_value_t* x, int index);
extern rml_value_t* mk_bcon(int);
extern rml_value_t* mk_icon(int);
extern rml_value_t* mk_rcon(double);
extern rml_value_t* mk_scon(char*);
extern rml_value_t* mk_nil(void);
extern rml_value_t* mk_cons(rml_value_t*, rml_value_t*);
extern void* rml_mk_cons(void*, void*);
extern rml_value_t* mk_none(void);
extern rml_value_t* mk_some(rml_value_t*);
extern rml_value_t* mk_box0(unsigned ctor);
extern rml_value_t* mk_box1(unsigned ctor, rml_value_t*);
extern rml_value_t* mk_box2(unsigned ctor, rml_value_t*, rml_value_t*);
extern rml_value_t* mk_box3(unsigned ctor, rml_value_t*, 
								rml_value_t*, 
								rml_value_t*);
extern rml_value_t* mk_box4(unsigned ctor, rml_value_t*, 
								rml_value_t*, 
								rml_value_t*, 
								rml_value_t*);
extern rml_value_t* mk_box5(unsigned ctor, rml_value_t*, 
								rml_value_t*, 
								rml_value_t*, 
								rml_value_t*, 
								rml_value_t*);
extern rml_value_t* mk_box6(unsigned ctor, rml_value_t*, 
								rml_value_t*, 
								rml_value_t*, 
								rml_value_t*, 
								rml_value_t*, 
								rml_value_t*);
extern rml_value_t* mk_box7(unsigned ctor, rml_value_t*, 
								rml_value_t*, 
								rml_value_t*, 
								rml_value_t*, 
								rml_value_t*, 
								rml_value_t*, 
								rml_value_t*);
extern rml_value_t* mk_box8(unsigned ctor, rml_value_t*, 
								rml_value_t*, 
								rml_value_t*, 
								rml_value_t*, 
								rml_value_t*, 
								rml_value_t*, 
								rml_value_t*, 
								rml_value_t*);
extern rml_value_t* mk_box9(unsigned ctor, rml_value_t*, 
								rml_value_t*, 
								rml_value_t*, 
								rml_value_t*, 
								rml_value_t*, 
								rml_value_t*, 
								rml_value_t*, 
								rml_value_t*, 
								rml_value_t*);
