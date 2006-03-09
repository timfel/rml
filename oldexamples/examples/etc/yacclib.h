/* yacclib.h */

extern void *alloc_bytes(unsigned nbytes);
extern void *alloc_words(unsigned nwords);

#define C2RML_HEAP_SIZE (100*1024)
extern void *c2rml_heap[C2RML_HEAP_SIZE];
extern void **C2RMLP;
extern unsigned long c2rml_heap_index;

void *add_c2rml_pointer_ref(void *p);
void remove_c2rml_pointer_ref(void *p);

extern void print_icon(FILE*, void*);
extern void print_rcon(FILE*, void*);
extern void print_scon(FILE*, void*);

extern void *mk_icon(int);
extern void *mk_rcon(double);
extern void *mk_scon(char*);
extern void *mk_nil(void);
extern void *mk_cons(void*, void*);
extern void *mk_none(void);
extern void *mk_some(void*);
extern void *mk_box0(unsigned ctor);
extern void *mk_box1(unsigned ctor, void*);
extern void *mk_box2(unsigned ctor, void*, void*);
extern void *mk_box3(unsigned ctor, void*, void*, void*);
extern void *mk_box4(unsigned ctor, void*, void*, void*, void*);
extern void *mk_box5(unsigned ctor, void*, void*, void*, void*, void*);
