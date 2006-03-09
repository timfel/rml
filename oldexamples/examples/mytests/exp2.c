/* module exp2 */
#include "rml.h"
#include <stdlib.h>
#include <stdio.h>
RML_DEFINE_MODULE("exp2")
extern RML_FORWARD_LABEL(RML__debug_5fpush_5fin01);
extern RML_FORWARD_LABEL(RML__debug_5fpush_5fin03);
extern RML_FORWARD_LABEL(RML__debug_5fpush_5fin02);
extern RML_FORWARD_LABEL(RML__debug);
extern RML_FORWARD_LABEL(RML__debug_5fpush_5fout01);

RML_FORWARD_LABEL(exp2__eval);
static RML_FORWARD_LABEL(exp2_2dsclam322);
static RML_FORWARD_LABEL(exp2_2dsclam321);
static RML_FORWARD_LABEL(exp2_2dsclam320);
static RML_FORWARD_LABEL(exp2_2dsclam315);
static RML_FORWARD_LABEL(exp2_2dsclam314);
static RML_FORWARD_LABEL(exp2_2dsclam313);
static RML_FORWARD_LABEL(exp2_2dsclam312);
static RML_FORWARD_LABEL(exp2_2dsclam311);
static RML_FORWARD_LABEL(exp2_2dsclam310);
static RML_FORWARD_LABEL(exp2_2dsclam238);
static RML_FORWARD_LABEL(exp2_2dsclam237);
static RML_FORWARD_LABEL(exp2_2dsclam235);
static RML_FORWARD_LABEL(exp2_2dsclam291);
static RML_FORWARD_LABEL(exp2_2dsclam290);
static RML_FORWARD_LABEL(exp2_2dsclam289);
static RML_FORWARD_LABEL(exp2_2dsclam288);
static RML_FORWARD_LABEL(exp2_2dsclam287);
static RML_FORWARD_LABEL(exp2_2dsclam286);
static RML_FORWARD_LABEL(exp2_2dsclam285);
static RML_FORWARD_LABEL(exp2_2dsclam284);
static RML_FORWARD_LABEL(exp2_2dsclam283);
static RML_FORWARD_LABEL(exp2_2dsclam282);
static RML_FORWARD_LABEL(exp2_2dsclam223);
static RML_FORWARD_LABEL(exp2_2dsclam222);
static RML_FORWARD_LABEL(exp2_2dsclam220);
static RML_FORWARD_LABEL(exp2_2dsclam211);
static RML_FORWARD_LABEL(exp2_2dsclam210);
static RML_FORWARD_LABEL(exp2_2dsclam208);
static RML_FORWARD_LABEL(exp2_2dsclam199);
static RML_FORWARD_LABEL(exp2_2dsclam198);
static RML_FORWARD_LABEL(exp2_2dsclam196);
static RML_FORWARD_LABEL(exp2_2dsclam187);
static RML_FORWARD_LABEL(exp2_2dsclam186);
static RML_FORWARD_LABEL(exp2_2dsclam184);

static const RML_DEFSTRINGLIT(lit0,2,"e1");
static const RML_DEFSTRINGLIT(lit1,8,"exp2.rml");
static const RML_DEFSTRINGLIT(lit2,4,"eval");
static const RML_DEFSTRINGLIT(lit3,21,"call:eval(e1) => (v1)");
static const RML_DEFSTRINGLIT(lit4,2,"v1");
static const RML_DEFSTRINGLIT(lit5,2,"e2");
static const RML_DEFSTRINGLIT(lit6,21,"call:eval(e2) => (v2)");
static const RML_DEFSTRINGLIT(lit7,2,"v2");
static const RML_DEFSTRINGLIT(lit8,5,"binop");
static const RML_DEFSTRINGLIT(lit9,37,"call:apply_binop(binop,v1,v2) => (v3)");
static const RML_DEFSTRINGLIT(lit10,11,"apply_binop");
static const RML_DEFSTRINGLIT(lit11,27,"call:int_sub(v1,v2) => (v3)");
static const RML_DEFSTRINGLIT(lit12,2,"v3");
static const RML_DEFSTRINGLIT(lit13,27,"call:int_div(v1,v2) => (v3)");
static const RML_DEFSTRINGLIT(lit14,27,"call:int_mul(v1,v2) => (v3)");
static const RML_DEFSTRINGLIT(lit15,27,"call:int_add(v1,v2) => (v3)");
static const RML_DEFSTRINGLIT(lit16,1,"e");
static const RML_DEFSTRINGLIT(lit17,20,"call:eval(e) => (v1)");
static const RML_DEFSTRINGLIT(lit18,4,"unop");
static const RML_DEFSTRINGLIT(lit19,32,"call:apply_unop(unop,v1) => (v2)");
static const RML_DEFSTRINGLIT(lit20,1,"v");
static const RML_DEFSTRINGLIT(lit21,10,"apply_unop");
static const RML_DEFSTRINGLIT(lit22,23,"call:int_neg(v) => (v2)");
static const RML_DEFSTRINGLIT(lit23,4,"ival");
static const RML_DEFSTRINGLIT(lit24,31,"axiom:eval(INT(ival)) => (ival)");

extern void RML_5finit(void);

void exp2_5finit(void)
{
	static int done = 0;
	if( done ) return;
	done = 1;
	RML_5finit();
	rmldb_load_db("exp2.rdb");
}

RML_BEGIN_LABEL(exp2__eval)
{

	{ void *tmp160 = rmlSC;
	{ void *tmp159 = rmlFC;
	{ void *tmp338 = rmlSP;
	{ void *tmp161 = rmlA0;
	{ void *tmp254 = RML_FETCH(RML_UNTAGPTR(tmp161));
	switch( (rml_sint_t)tmp254 ) {
	case RML_STRUCTHDR(3,1):
	{ void *tmp255 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp161), 3));
	{ void *tmp256 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp161), 2));
	{ void *tmp257 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp161), 1));
	RML_STORE(RML_OFFSET(tmp338, -1), tmp159);
	RML_STORE(RML_OFFSET(tmp338, -2), tmp257);
	RML_STORE(RML_OFFSET(tmp338, -3), tmp255);
	RML_STORE(RML_OFFSET(tmp338, -4), tmp256);
	RML_STORE(RML_OFFSET(tmp338, -5), tmp160);
	RML_STORE(RML_OFFSET(tmp338, -6), RML_LABVAL(exp2_2dsclam291));
	rmlA1 = tmp257;
	rmlA0 = RML_REFSTRINGLIT(lit0);
	rmlSC = RML_OFFSET(tmp338, -6);
	rmlSP = RML_OFFSET(tmp338, -6);
	RML_TAILCALLQ(RML__debug_5fpush_5fin01,2);}}}
	case RML_STRUCTHDR(2,2):
	{ void *tmp292 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp161), 2));
	{ void *tmp293 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp161), 1));
	RML_STORE(RML_OFFSET(tmp338, -1), tmp159);
	RML_STORE(RML_OFFSET(tmp338, -2), tmp292);
	RML_STORE(RML_OFFSET(tmp338, -3), tmp293);
	RML_STORE(RML_OFFSET(tmp338, -4), tmp160);
	RML_STORE(RML_OFFSET(tmp338, -5), RML_LABVAL(exp2_2dsclam315));
	rmlA1 = tmp292;
	rmlA0 = RML_REFSTRINGLIT(lit16);
	rmlSC = RML_OFFSET(tmp338, -5);
	rmlSP = RML_OFFSET(tmp338, -5);
	RML_TAILCALLQ(RML__debug_5fpush_5fin01,2);}}
	/*case RML_STRUCTHDR(1,0)*/
	default:
	{ void *tmp316 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp161), 1));
	RML_STORE(RML_OFFSET(tmp338, -1), tmp159);
	RML_STORE(RML_OFFSET(tmp338, -2), tmp316);
	RML_STORE(RML_OFFSET(tmp338, -3), tmp160);
	RML_STORE(RML_OFFSET(tmp338, -4), RML_LABVAL(exp2_2dsclam322));
	rmlA1 = tmp316;
	rmlA0 = RML_REFSTRINGLIT(lit23);
	rmlSC = RML_OFFSET(tmp338, -4);
	rmlSP = RML_OFFSET(tmp338, -4);
	RML_TAILCALLQ(RML__debug_5fpush_5fin01,2);}
	}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp2_2dsclam322)
{

	{ void *tmp434 = rmlSC;
	{ void *tmp160 = RML_FETCH(RML_OFFSET(tmp434, 1));
	{ void *tmp316 = RML_FETCH(RML_OFFSET(tmp434, 2));
	{ void *tmp159 = RML_FETCH(RML_OFFSET(tmp434, 3));
	{ void *tmp433 = RML_OFFSET(tmp434, 4);
	RML_STORE(RML_OFFSET(tmp433, -1), tmp316);
	RML_STORE(RML_OFFSET(tmp433, -2), tmp159);
	RML_STORE(RML_OFFSET(tmp433, -3), tmp160);
	RML_STORE(RML_OFFSET(tmp433, -4), RML_LABVAL(exp2_2dsclam321));
	rmlA6 = RML_REFSTRINGLIT(lit24);
	rmlA5 = RML_REFSTRINGLIT(lit2);
	rmlA4 = RML_IMMEDIATE(RML_TAGFIXNUM(33));
	rmlA3 = RML_IMMEDIATE(RML_TAGFIXNUM(16));
	rmlA2 = RML_IMMEDIATE(RML_TAGFIXNUM(3));
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(16));
	rmlA0 = RML_REFSTRINGLIT(lit1);
	rmlFC = tmp159;
	rmlSC = RML_OFFSET(tmp433, -4);
	rmlSP = RML_OFFSET(tmp433, -4);
	RML_TAILCALLQ(RML__debug,7);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp2_2dsclam321)
{

	{ void *tmp437 = rmlSC;
	{ void *tmp160 = RML_FETCH(RML_OFFSET(tmp437, 1));
	{ void *tmp159 = RML_FETCH(RML_OFFSET(tmp437, 2));
	{ void *tmp316 = RML_FETCH(RML_OFFSET(tmp437, 3));
	{ void *tmp436 = RML_OFFSET(tmp437, 4);
	RML_STORE(RML_OFFSET(tmp436, -1), tmp160);
	RML_STORE(RML_OFFSET(tmp436, -2), tmp316);
	RML_STORE(RML_OFFSET(tmp436, -3), RML_LABVAL(exp2_2dsclam320));
	rmlA1 = tmp316;
	rmlA0 = RML_REFSTRINGLIT(lit23);
	rmlFC = tmp159;
	rmlSC = RML_OFFSET(tmp436, -3);
	rmlSP = RML_OFFSET(tmp436, -3);
	RML_TAILCALLQ(RML__debug_5fpush_5fout01,2);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp2_2dsclam320)
{

	{ void *tmp440 = rmlSC;
	{ void *tmp316 = RML_FETCH(RML_OFFSET(tmp440, 1));
	{ void *tmp160 = RML_FETCH(RML_OFFSET(tmp440, 2));
	{ void *tmp439 = RML_OFFSET(tmp440, 3);
	rmlA0 = tmp316;
	rmlSC = tmp160;
	rmlSP = tmp439;
	RML_TAILCALL(RML_FETCH(tmp160),1);}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp2_2dsclam315)
{

	{ void *tmp407 = rmlSC;
	{ void *tmp160 = RML_FETCH(RML_OFFSET(tmp407, 1));
	{ void *tmp293 = RML_FETCH(RML_OFFSET(tmp407, 2));
	{ void *tmp292 = RML_FETCH(RML_OFFSET(tmp407, 3));
	{ void *tmp159 = RML_FETCH(RML_OFFSET(tmp407, 4));
	{ void *tmp406 = RML_OFFSET(tmp407, 5);
	RML_STORE(RML_OFFSET(tmp406, -1), tmp292);
	RML_STORE(RML_OFFSET(tmp406, -2), tmp159);
	RML_STORE(RML_OFFSET(tmp406, -3), tmp293);
	RML_STORE(RML_OFFSET(tmp406, -4), tmp160);
	RML_STORE(RML_OFFSET(tmp406, -5), RML_LABVAL(exp2_2dsclam314));
	rmlA6 = RML_REFSTRINGLIT(lit17);
	rmlA5 = RML_REFSTRINGLIT(lit2);
	rmlA4 = RML_IMMEDIATE(RML_TAGFIXNUM(15));
	rmlA3 = RML_IMMEDIATE(RML_TAGFIXNUM(24));
	rmlA2 = RML_IMMEDIATE(RML_TAGFIXNUM(9));
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(24));
	rmlA0 = RML_REFSTRINGLIT(lit1);
	rmlFC = tmp159;
	rmlSC = RML_OFFSET(tmp406, -5);
	rmlSP = RML_OFFSET(tmp406, -5);
	RML_TAILCALLQ(RML__debug,7);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp2_2dsclam314)
{

	{ void *tmp410 = rmlSC;
	{ void *tmp160 = RML_FETCH(RML_OFFSET(tmp410, 1));
	{ void *tmp293 = RML_FETCH(RML_OFFSET(tmp410, 2));
	{ void *tmp159 = RML_FETCH(RML_OFFSET(tmp410, 3));
	{ void *tmp292 = RML_FETCH(RML_OFFSET(tmp410, 4));
	{ void *tmp409 = RML_OFFSET(tmp410, 5);
	RML_STORE(RML_OFFSET(tmp409, -1), tmp159);
	RML_STORE(RML_OFFSET(tmp409, -2), tmp293);
	RML_STORE(RML_OFFSET(tmp409, -3), tmp160);
	RML_STORE(RML_OFFSET(tmp409, -4), RML_LABVAL(exp2_2dsclam313));
	rmlA0 = tmp292;
	rmlFC = tmp159;
	rmlSC = RML_OFFSET(tmp409, -4);
	rmlSP = RML_OFFSET(tmp409, -4);
	RML_TAILCALLQ(exp2__eval,1);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp2_2dsclam313)
{

	{ void *tmp413 = rmlSC;
	{ void *tmp160 = RML_FETCH(RML_OFFSET(tmp413, 1));
	{ void *tmp293 = RML_FETCH(RML_OFFSET(tmp413, 2));
	{ void *tmp159 = RML_FETCH(RML_OFFSET(tmp413, 3));
	{ void *tmp412 = RML_OFFSET(tmp413, 4);
	{ void *tmp297 = rmlA0;
	RML_STORE(RML_OFFSET(tmp412, -1), tmp293);
	RML_STORE(RML_OFFSET(tmp412, -2), tmp297);
	RML_STORE(RML_OFFSET(tmp412, -3), tmp159);
	RML_STORE(RML_OFFSET(tmp412, -4), tmp160);
	RML_STORE(RML_OFFSET(tmp412, -5), RML_LABVAL(exp2_2dsclam312));
	rmlA1 = tmp297;
	rmlA0 = RML_REFSTRINGLIT(lit4);
	rmlFC = tmp159;
	rmlSC = RML_OFFSET(tmp412, -5);
	rmlSP = RML_OFFSET(tmp412, -5);
	RML_TAILCALLQ(RML__debug_5fpush_5fout01,2);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp2_2dsclam312)
{

	{ void *tmp416 = rmlSC;
	{ void *tmp160 = RML_FETCH(RML_OFFSET(tmp416, 1));
	{ void *tmp159 = RML_FETCH(RML_OFFSET(tmp416, 2));
	{ void *tmp297 = RML_FETCH(RML_OFFSET(tmp416, 3));
	{ void *tmp293 = RML_FETCH(RML_OFFSET(tmp416, 4));
	{ void *tmp415 = RML_OFFSET(tmp416, 5);
	RML_STORE(RML_OFFSET(tmp415, -1), tmp159);
	RML_STORE(RML_OFFSET(tmp415, -2), tmp297);
	RML_STORE(RML_OFFSET(tmp415, -3), tmp160);
	RML_STORE(RML_OFFSET(tmp415, -4), RML_LABVAL(exp2_2dsclam311));
	rmlA3 = tmp297;
	rmlA2 = RML_REFSTRINGLIT(lit4);
	rmlA1 = tmp293;
	rmlA0 = RML_REFSTRINGLIT(lit18);
	rmlFC = tmp159;
	rmlSC = RML_OFFSET(tmp415, -4);
	rmlSP = RML_OFFSET(tmp415, -4);
	RML_TAILCALLQ(RML__debug_5fpush_5fin02,4);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp2_2dsclam311)
{

	{ void *tmp419 = rmlSC;
	{ void *tmp160 = RML_FETCH(RML_OFFSET(tmp419, 1));
	{ void *tmp297 = RML_FETCH(RML_OFFSET(tmp419, 2));
	{ void *tmp159 = RML_FETCH(RML_OFFSET(tmp419, 3));
	{ void *tmp418 = RML_OFFSET(tmp419, 4);
	RML_STORE(RML_OFFSET(tmp418, -1), tmp297);
	RML_STORE(RML_OFFSET(tmp418, -2), tmp159);
	RML_STORE(RML_OFFSET(tmp418, -3), tmp160);
	RML_STORE(RML_OFFSET(tmp418, -4), RML_LABVAL(exp2_2dsclam310));
	rmlA6 = RML_REFSTRINGLIT(lit19);
	rmlA5 = RML_REFSTRINGLIT(lit2);
	rmlA4 = RML_IMMEDIATE(RML_TAGFIXNUM(45));
	rmlA3 = RML_IMMEDIATE(RML_TAGFIXNUM(24));
	rmlA2 = RML_IMMEDIATE(RML_TAGFIXNUM(27));
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(24));
	rmlA0 = RML_REFSTRINGLIT(lit1);
	rmlFC = tmp159;
	rmlSC = RML_OFFSET(tmp418, -4);
	rmlSP = RML_OFFSET(tmp418, -4);
	RML_TAILCALLQ(RML__debug,7);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp2_2dsclam310)
{

	{ void *tmp422 = rmlSC;
	{ void *tmp160 = RML_FETCH(RML_OFFSET(tmp422, 1));
	{ void *tmp159 = RML_FETCH(RML_OFFSET(tmp422, 2));
	{ void *tmp297 = RML_FETCH(RML_OFFSET(tmp422, 3));
	{ void *tmp421 = RML_OFFSET(tmp422, 4);
	RML_STORE(RML_OFFSET(tmp421, -1), tmp159);
	RML_STORE(RML_OFFSET(tmp421, -2), tmp297);
	RML_STORE(RML_OFFSET(tmp421, -3), tmp160);
	RML_STORE(RML_OFFSET(tmp421, -4), RML_LABVAL(exp2_2dsclam238));
	rmlA1 = tmp297;
	rmlA0 = RML_REFSTRINGLIT(lit20);
	rmlFC = tmp159;
	rmlSC = RML_OFFSET(tmp421, -4);
	rmlSP = RML_OFFSET(tmp421, -4);
	RML_TAILCALLQ(RML__debug_5fpush_5fin01,2);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp2_2dsclam238)
{

	{ void *tmp425 = rmlSC;
	{ void *tmp160 = RML_FETCH(RML_OFFSET(tmp425, 1));
	{ void *tmp297 = RML_FETCH(RML_OFFSET(tmp425, 2));
	{ void *tmp159 = RML_FETCH(RML_OFFSET(tmp425, 3));
	{ void *tmp424 = RML_OFFSET(tmp425, 4);
	RML_STORE(RML_OFFSET(tmp424, -1), tmp297);
	RML_STORE(RML_OFFSET(tmp424, -2), tmp159);
	RML_STORE(RML_OFFSET(tmp424, -3), tmp160);
	RML_STORE(RML_OFFSET(tmp424, -4), RML_LABVAL(exp2_2dsclam237));
	rmlA6 = RML_REFSTRINGLIT(lit22);
	rmlA5 = RML_REFSTRINGLIT(lit21);
	rmlA4 = RML_IMMEDIATE(RML_TAGFIXNUM(18));
	rmlA3 = RML_IMMEDIATE(RML_TAGFIXNUM(52));
	rmlA2 = RML_IMMEDIATE(RML_TAGFIXNUM(9));
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(52));
	rmlA0 = RML_REFSTRINGLIT(lit1);
	rmlFC = tmp159;
	rmlSC = RML_OFFSET(tmp424, -4);
	rmlSP = RML_OFFSET(tmp424, -4);
	RML_TAILCALLQ(RML__debug,7);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp2_2dsclam237)
{

	{ void *tmp428 = rmlSC;
	{ void *tmp160 = RML_FETCH(RML_OFFSET(tmp428, 1));
	{ void *tmp159 = RML_FETCH(RML_OFFSET(tmp428, 2));
	{ void *tmp297 = RML_FETCH(RML_OFFSET(tmp428, 3));
	{ void *tmp427 = RML_OFFSET(tmp428, 4);
	{ void *tmp336 = RML_PRIM_INT_NEG(tmp297);
	RML_STORE(RML_OFFSET(tmp427, -1), tmp160);
	RML_STORE(RML_OFFSET(tmp427, -2), tmp336);
	RML_STORE(RML_OFFSET(tmp427, -3), RML_LABVAL(exp2_2dsclam235));
	rmlA1 = tmp336;
	rmlA0 = RML_REFSTRINGLIT(lit7);
	rmlFC = tmp159;
	rmlSC = RML_OFFSET(tmp427, -3);
	rmlSP = RML_OFFSET(tmp427, -3);
	RML_TAILCALLQ(RML__debug_5fpush_5fout01,2);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp2_2dsclam235)
{

	{ void *tmp431 = rmlSC;
	{ void *tmp336 = RML_FETCH(RML_OFFSET(tmp431, 1));
	{ void *tmp160 = RML_FETCH(RML_OFFSET(tmp431, 2));
	{ void *tmp430 = RML_OFFSET(tmp431, 3);
	rmlA0 = tmp336;
	rmlSC = tmp160;
	rmlSP = tmp430;
	RML_TAILCALL(RML_FETCH(tmp160),1);}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp2_2dsclam291)
{

	{ void *tmp341 = rmlSC;
	{ void *tmp160 = RML_FETCH(RML_OFFSET(tmp341, 1));
	{ void *tmp256 = RML_FETCH(RML_OFFSET(tmp341, 2));
	{ void *tmp255 = RML_FETCH(RML_OFFSET(tmp341, 3));
	{ void *tmp257 = RML_FETCH(RML_OFFSET(tmp341, 4));
	{ void *tmp159 = RML_FETCH(RML_OFFSET(tmp341, 5));
	{ void *tmp340 = RML_OFFSET(tmp341, 6);
	RML_STORE(RML_OFFSET(tmp340, -1), tmp257);
	RML_STORE(RML_OFFSET(tmp340, -2), tmp159);
	RML_STORE(RML_OFFSET(tmp340, -3), tmp255);
	RML_STORE(RML_OFFSET(tmp340, -4), tmp256);
	RML_STORE(RML_OFFSET(tmp340, -5), tmp160);
	RML_STORE(RML_OFFSET(tmp340, -6), RML_LABVAL(exp2_2dsclam290));
	rmlA6 = RML_REFSTRINGLIT(lit3);
	rmlA5 = RML_REFSTRINGLIT(lit2);
	rmlA4 = RML_IMMEDIATE(RML_TAGFIXNUM(16));
	rmlA3 = RML_IMMEDIATE(RML_TAGFIXNUM(18));
	rmlA2 = RML_IMMEDIATE(RML_TAGFIXNUM(9));
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(18));
	rmlA0 = RML_REFSTRINGLIT(lit1);
	rmlFC = tmp159;
	rmlSC = RML_OFFSET(tmp340, -6);
	rmlSP = RML_OFFSET(tmp340, -6);
	RML_TAILCALLQ(RML__debug,7);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp2_2dsclam290)
{

	{ void *tmp344 = rmlSC;
	{ void *tmp160 = RML_FETCH(RML_OFFSET(tmp344, 1));
	{ void *tmp256 = RML_FETCH(RML_OFFSET(tmp344, 2));
	{ void *tmp255 = RML_FETCH(RML_OFFSET(tmp344, 3));
	{ void *tmp159 = RML_FETCH(RML_OFFSET(tmp344, 4));
	{ void *tmp257 = RML_FETCH(RML_OFFSET(tmp344, 5));
	{ void *tmp343 = RML_OFFSET(tmp344, 6);
	RML_STORE(RML_OFFSET(tmp343, -1), tmp159);
	RML_STORE(RML_OFFSET(tmp343, -2), tmp255);
	RML_STORE(RML_OFFSET(tmp343, -3), tmp256);
	RML_STORE(RML_OFFSET(tmp343, -4), tmp160);
	RML_STORE(RML_OFFSET(tmp343, -5), RML_LABVAL(exp2_2dsclam289));
	rmlA0 = tmp257;
	rmlFC = tmp159;
	rmlSC = RML_OFFSET(tmp343, -5);
	rmlSP = RML_OFFSET(tmp343, -5);
	RML_TAILCALLQ(exp2__eval,1);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp2_2dsclam289)
{

	{ void *tmp347 = rmlSC;
	{ void *tmp160 = RML_FETCH(RML_OFFSET(tmp347, 1));
	{ void *tmp256 = RML_FETCH(RML_OFFSET(tmp347, 2));
	{ void *tmp255 = RML_FETCH(RML_OFFSET(tmp347, 3));
	{ void *tmp159 = RML_FETCH(RML_OFFSET(tmp347, 4));
	{ void *tmp346 = RML_OFFSET(tmp347, 5);
	{ void *tmp261 = rmlA0;
	RML_STORE(RML_OFFSET(tmp346, -1), tmp255);
	RML_STORE(RML_OFFSET(tmp346, -2), tmp159);
	RML_STORE(RML_OFFSET(tmp346, -3), tmp256);
	RML_STORE(RML_OFFSET(tmp346, -4), tmp261);
	RML_STORE(RML_OFFSET(tmp346, -5), tmp160);
	RML_STORE(RML_OFFSET(tmp346, -6), RML_LABVAL(exp2_2dsclam288));
	rmlA1 = tmp261;
	rmlA0 = RML_REFSTRINGLIT(lit4);
	rmlFC = tmp159;
	rmlSC = RML_OFFSET(tmp346, -6);
	rmlSP = RML_OFFSET(tmp346, -6);
	RML_TAILCALLQ(RML__debug_5fpush_5fout01,2);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp2_2dsclam288)
{

	{ void *tmp350 = rmlSC;
	{ void *tmp160 = RML_FETCH(RML_OFFSET(tmp350, 1));
	{ void *tmp261 = RML_FETCH(RML_OFFSET(tmp350, 2));
	{ void *tmp256 = RML_FETCH(RML_OFFSET(tmp350, 3));
	{ void *tmp159 = RML_FETCH(RML_OFFSET(tmp350, 4));
	{ void *tmp255 = RML_FETCH(RML_OFFSET(tmp350, 5));
	{ void *tmp349 = RML_OFFSET(tmp350, 6);
	RML_STORE(RML_OFFSET(tmp349, -1), tmp159);
	RML_STORE(RML_OFFSET(tmp349, -2), tmp255);
	RML_STORE(RML_OFFSET(tmp349, -3), tmp256);
	RML_STORE(RML_OFFSET(tmp349, -4), tmp261);
	RML_STORE(RML_OFFSET(tmp349, -5), tmp160);
	RML_STORE(RML_OFFSET(tmp349, -6), RML_LABVAL(exp2_2dsclam287));
	rmlA1 = tmp255;
	rmlA0 = RML_REFSTRINGLIT(lit5);
	rmlFC = tmp159;
	rmlSC = RML_OFFSET(tmp349, -6);
	rmlSP = RML_OFFSET(tmp349, -6);
	RML_TAILCALLQ(RML__debug_5fpush_5fin01,2);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp2_2dsclam287)
{

	{ void *tmp353 = rmlSC;
	{ void *tmp160 = RML_FETCH(RML_OFFSET(tmp353, 1));
	{ void *tmp261 = RML_FETCH(RML_OFFSET(tmp353, 2));
	{ void *tmp256 = RML_FETCH(RML_OFFSET(tmp353, 3));
	{ void *tmp255 = RML_FETCH(RML_OFFSET(tmp353, 4));
	{ void *tmp159 = RML_FETCH(RML_OFFSET(tmp353, 5));
	{ void *tmp352 = RML_OFFSET(tmp353, 6);
	RML_STORE(RML_OFFSET(tmp352, -1), tmp255);
	RML_STORE(RML_OFFSET(tmp352, -2), tmp159);
	RML_STORE(RML_OFFSET(tmp352, -3), tmp256);
	RML_STORE(RML_OFFSET(tmp352, -4), tmp261);
	RML_STORE(RML_OFFSET(tmp352, -5), tmp160);
	RML_STORE(RML_OFFSET(tmp352, -6), RML_LABVAL(exp2_2dsclam286));
	rmlA6 = RML_REFSTRINGLIT(lit6);
	rmlA5 = RML_REFSTRINGLIT(lit2);
	rmlA4 = RML_IMMEDIATE(RML_TAGFIXNUM(16));
	rmlA3 = RML_IMMEDIATE(RML_TAGFIXNUM(19));
	rmlA2 = RML_IMMEDIATE(RML_TAGFIXNUM(9));
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(19));
	rmlA0 = RML_REFSTRINGLIT(lit1);
	rmlFC = tmp159;
	rmlSC = RML_OFFSET(tmp352, -6);
	rmlSP = RML_OFFSET(tmp352, -6);
	RML_TAILCALLQ(RML__debug,7);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp2_2dsclam286)
{

	{ void *tmp356 = rmlSC;
	{ void *tmp160 = RML_FETCH(RML_OFFSET(tmp356, 1));
	{ void *tmp261 = RML_FETCH(RML_OFFSET(tmp356, 2));
	{ void *tmp256 = RML_FETCH(RML_OFFSET(tmp356, 3));
	{ void *tmp159 = RML_FETCH(RML_OFFSET(tmp356, 4));
	{ void *tmp255 = RML_FETCH(RML_OFFSET(tmp356, 5));
	{ void *tmp355 = RML_OFFSET(tmp356, 6);
	RML_STORE(RML_OFFSET(tmp355, -1), tmp159);
	RML_STORE(RML_OFFSET(tmp355, -2), tmp256);
	RML_STORE(RML_OFFSET(tmp355, -3), tmp261);
	RML_STORE(RML_OFFSET(tmp355, -4), tmp160);
	RML_STORE(RML_OFFSET(tmp355, -5), RML_LABVAL(exp2_2dsclam285));
	rmlA0 = tmp255;
	rmlFC = tmp159;
	rmlSC = RML_OFFSET(tmp355, -5);
	rmlSP = RML_OFFSET(tmp355, -5);
	RML_TAILCALLQ(exp2__eval,1);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp2_2dsclam285)
{

	{ void *tmp359 = rmlSC;
	{ void *tmp160 = RML_FETCH(RML_OFFSET(tmp359, 1));
	{ void *tmp261 = RML_FETCH(RML_OFFSET(tmp359, 2));
	{ void *tmp256 = RML_FETCH(RML_OFFSET(tmp359, 3));
	{ void *tmp159 = RML_FETCH(RML_OFFSET(tmp359, 4));
	{ void *tmp358 = RML_OFFSET(tmp359, 5);
	{ void *tmp269 = rmlA0;
	RML_STORE(RML_OFFSET(tmp358, -1), tmp256);
	RML_STORE(RML_OFFSET(tmp358, -2), tmp261);
	RML_STORE(RML_OFFSET(tmp358, -3), tmp269);
	RML_STORE(RML_OFFSET(tmp358, -4), tmp159);
	RML_STORE(RML_OFFSET(tmp358, -5), tmp160);
	RML_STORE(RML_OFFSET(tmp358, -6), RML_LABVAL(exp2_2dsclam284));
	rmlA1 = tmp269;
	rmlA0 = RML_REFSTRINGLIT(lit7);
	rmlFC = tmp159;
	rmlSC = RML_OFFSET(tmp358, -6);
	rmlSP = RML_OFFSET(tmp358, -6);
	RML_TAILCALLQ(RML__debug_5fpush_5fout01,2);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp2_2dsclam284)
{

	{ void *tmp362 = rmlSC;
	{ void *tmp160 = RML_FETCH(RML_OFFSET(tmp362, 1));
	{ void *tmp159 = RML_FETCH(RML_OFFSET(tmp362, 2));
	{ void *tmp269 = RML_FETCH(RML_OFFSET(tmp362, 3));
	{ void *tmp261 = RML_FETCH(RML_OFFSET(tmp362, 4));
	{ void *tmp256 = RML_FETCH(RML_OFFSET(tmp362, 5));
	{ void *tmp361 = RML_OFFSET(tmp362, 6);
	RML_STORE(RML_OFFSET(tmp361, -1), tmp159);
	RML_STORE(RML_OFFSET(tmp361, -2), tmp256);
	RML_STORE(RML_OFFSET(tmp361, -3), tmp261);
	RML_STORE(RML_OFFSET(tmp361, -4), tmp269);
	RML_STORE(RML_OFFSET(tmp361, -5), tmp160);
	RML_STORE(RML_OFFSET(tmp361, -6), RML_LABVAL(exp2_2dsclam283));
	rmlA5 = tmp269;
	rmlA4 = RML_REFSTRINGLIT(lit7);
	rmlA3 = tmp261;
	rmlA2 = RML_REFSTRINGLIT(lit4);
	rmlA1 = tmp256;
	rmlA0 = RML_REFSTRINGLIT(lit8);
	rmlFC = tmp159;
	rmlSC = RML_OFFSET(tmp361, -6);
	rmlSP = RML_OFFSET(tmp361, -6);
	RML_TAILCALLQ(RML__debug_5fpush_5fin03,6);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp2_2dsclam283)
{

	{ void *tmp365 = rmlSC;
	{ void *tmp160 = RML_FETCH(RML_OFFSET(tmp365, 1));
	{ void *tmp269 = RML_FETCH(RML_OFFSET(tmp365, 2));
	{ void *tmp261 = RML_FETCH(RML_OFFSET(tmp365, 3));
	{ void *tmp256 = RML_FETCH(RML_OFFSET(tmp365, 4));
	{ void *tmp159 = RML_FETCH(RML_OFFSET(tmp365, 5));
	{ void *tmp364 = RML_OFFSET(tmp365, 6);
	RML_STORE(RML_OFFSET(tmp364, -1), tmp256);
	RML_STORE(RML_OFFSET(tmp364, -2), tmp261);
	RML_STORE(RML_OFFSET(tmp364, -3), tmp269);
	RML_STORE(RML_OFFSET(tmp364, -4), tmp159);
	RML_STORE(RML_OFFSET(tmp364, -5), tmp160);
	RML_STORE(RML_OFFSET(tmp364, -6), RML_LABVAL(exp2_2dsclam282));
	rmlA6 = RML_REFSTRINGLIT(lit9);
	rmlA5 = RML_REFSTRINGLIT(lit2);
	rmlA4 = RML_IMMEDIATE(RML_TAGFIXNUM(32));
	rmlA3 = RML_IMMEDIATE(RML_TAGFIXNUM(20));
	rmlA2 = RML_IMMEDIATE(RML_TAGFIXNUM(9));
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(20));
	rmlA0 = RML_REFSTRINGLIT(lit1);
	rmlFC = tmp159;
	rmlSC = RML_OFFSET(tmp364, -6);
	rmlSP = RML_OFFSET(tmp364, -6);
	RML_TAILCALLQ(RML__debug,7);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp2_2dsclam282)
{

	{ void *tmp368 = rmlSC;
	{ void *tmp160 = RML_FETCH(RML_OFFSET(tmp368, 1));
	{ void *tmp159 = RML_FETCH(RML_OFFSET(tmp368, 2));
	{ void *tmp269 = RML_FETCH(RML_OFFSET(tmp368, 3));
	{ void *tmp261 = RML_FETCH(RML_OFFSET(tmp368, 4));
	{ void *tmp256 = RML_FETCH(RML_OFFSET(tmp368, 5));
	{ void *tmp367 = RML_OFFSET(tmp368, 6);
	switch( RML_UNTAGFIXNUM(tmp256) ) {
	case 1:
	RML_STORE(RML_OFFSET(tmp367, -1), tmp159);
	RML_STORE(RML_OFFSET(tmp367, -2), tmp261);
	RML_STORE(RML_OFFSET(tmp367, -3), tmp269);
	RML_STORE(RML_OFFSET(tmp367, -4), tmp160);
	RML_STORE(RML_OFFSET(tmp367, -5), RML_LABVAL(exp2_2dsclam187));
	rmlA3 = tmp269;
	rmlA2 = RML_REFSTRINGLIT(lit7);
	rmlA1 = tmp261;
	rmlA0 = RML_REFSTRINGLIT(lit4);
	rmlFC = tmp159;
	rmlSC = RML_OFFSET(tmp367, -5);
	rmlSP = RML_OFFSET(tmp367, -5);
	RML_TAILCALLQ(RML__debug_5fpush_5fin02,4);
	case 3:
	RML_STORE(RML_OFFSET(tmp367, -1), tmp159);
	RML_STORE(RML_OFFSET(tmp367, -2), tmp269);
	RML_STORE(RML_OFFSET(tmp367, -3), tmp261);
	RML_STORE(RML_OFFSET(tmp367, -4), tmp160);
	RML_STORE(RML_OFFSET(tmp367, -5), RML_LABVAL(exp2_2dsclam199));
	rmlA3 = tmp269;
	rmlA2 = RML_REFSTRINGLIT(lit7);
	rmlA1 = tmp261;
	rmlA0 = RML_REFSTRINGLIT(lit4);
	rmlFC = tmp159;
	rmlSC = RML_OFFSET(tmp367, -5);
	rmlSP = RML_OFFSET(tmp367, -5);
	RML_TAILCALLQ(RML__debug_5fpush_5fin02,4);
	case 2:
	RML_STORE(RML_OFFSET(tmp367, -1), tmp159);
	RML_STORE(RML_OFFSET(tmp367, -2), tmp261);
	RML_STORE(RML_OFFSET(tmp367, -3), tmp269);
	RML_STORE(RML_OFFSET(tmp367, -4), tmp160);
	RML_STORE(RML_OFFSET(tmp367, -5), RML_LABVAL(exp2_2dsclam211));
	rmlA3 = tmp269;
	rmlA2 = RML_REFSTRINGLIT(lit7);
	rmlA1 = tmp261;
	rmlA0 = RML_REFSTRINGLIT(lit4);
	rmlFC = tmp159;
	rmlSC = RML_OFFSET(tmp367, -5);
	rmlSP = RML_OFFSET(tmp367, -5);
	RML_TAILCALLQ(RML__debug_5fpush_5fin02,4);
	/*case 0*/
	default:
	RML_STORE(RML_OFFSET(tmp367, -1), tmp159);
	RML_STORE(RML_OFFSET(tmp367, -2), tmp261);
	RML_STORE(RML_OFFSET(tmp367, -3), tmp269);
	RML_STORE(RML_OFFSET(tmp367, -4), tmp160);
	RML_STORE(RML_OFFSET(tmp367, -5), RML_LABVAL(exp2_2dsclam223));
	rmlA3 = tmp269;
	rmlA2 = RML_REFSTRINGLIT(lit7);
	rmlA1 = tmp261;
	rmlA0 = RML_REFSTRINGLIT(lit4);
	rmlFC = tmp159;
	rmlSC = RML_OFFSET(tmp367, -5);
	rmlSP = RML_OFFSET(tmp367, -5);
	RML_TAILCALLQ(RML__debug_5fpush_5fin02,4);
	}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp2_2dsclam223)
{

	{ void *tmp398 = rmlSC;
	{ void *tmp160 = RML_FETCH(RML_OFFSET(tmp398, 1));
	{ void *tmp269 = RML_FETCH(RML_OFFSET(tmp398, 2));
	{ void *tmp261 = RML_FETCH(RML_OFFSET(tmp398, 3));
	{ void *tmp159 = RML_FETCH(RML_OFFSET(tmp398, 4));
	{ void *tmp397 = RML_OFFSET(tmp398, 5);
	RML_STORE(RML_OFFSET(tmp397, -1), tmp261);
	RML_STORE(RML_OFFSET(tmp397, -2), tmp269);
	RML_STORE(RML_OFFSET(tmp397, -3), tmp159);
	RML_STORE(RML_OFFSET(tmp397, -4), tmp160);
	RML_STORE(RML_OFFSET(tmp397, -5), RML_LABVAL(exp2_2dsclam222));
	rmlA6 = RML_REFSTRINGLIT(lit15);
	rmlA5 = RML_REFSTRINGLIT(lit10);
	rmlA4 = RML_IMMEDIATE(RML_TAGFIXNUM(22));
	rmlA3 = RML_IMMEDIATE(RML_TAGFIXNUM(32));
	rmlA2 = RML_IMMEDIATE(RML_TAGFIXNUM(9));
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(32));
	rmlA0 = RML_REFSTRINGLIT(lit1);
	rmlFC = tmp159;
	rmlSC = RML_OFFSET(tmp397, -5);
	rmlSP = RML_OFFSET(tmp397, -5);
	RML_TAILCALLQ(RML__debug,7);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp2_2dsclam222)
{

	{ void *tmp401 = rmlSC;
	{ void *tmp160 = RML_FETCH(RML_OFFSET(tmp401, 1));
	{ void *tmp159 = RML_FETCH(RML_OFFSET(tmp401, 2));
	{ void *tmp269 = RML_FETCH(RML_OFFSET(tmp401, 3));
	{ void *tmp261 = RML_FETCH(RML_OFFSET(tmp401, 4));
	{ void *tmp400 = RML_OFFSET(tmp401, 5);
	{ void *tmp334 = RML_PRIM_INT_ADD(tmp261, tmp269);
	RML_STORE(RML_OFFSET(tmp400, -1), tmp160);
	RML_STORE(RML_OFFSET(tmp400, -2), tmp334);
	RML_STORE(RML_OFFSET(tmp400, -3), RML_LABVAL(exp2_2dsclam220));
	rmlA1 = tmp334;
	rmlA0 = RML_REFSTRINGLIT(lit12);
	rmlFC = tmp159;
	rmlSC = RML_OFFSET(tmp400, -3);
	rmlSP = RML_OFFSET(tmp400, -3);
	RML_TAILCALLQ(RML__debug_5fpush_5fout01,2);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp2_2dsclam220)
{

	{ void *tmp404 = rmlSC;
	{ void *tmp334 = RML_FETCH(RML_OFFSET(tmp404, 1));
	{ void *tmp160 = RML_FETCH(RML_OFFSET(tmp404, 2));
	{ void *tmp403 = RML_OFFSET(tmp404, 3);
	rmlA0 = tmp334;
	rmlSC = tmp160;
	rmlSP = tmp403;
	RML_TAILCALL(RML_FETCH(tmp160),1);}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp2_2dsclam211)
{

	{ void *tmp389 = rmlSC;
	{ void *tmp160 = RML_FETCH(RML_OFFSET(tmp389, 1));
	{ void *tmp269 = RML_FETCH(RML_OFFSET(tmp389, 2));
	{ void *tmp261 = RML_FETCH(RML_OFFSET(tmp389, 3));
	{ void *tmp159 = RML_FETCH(RML_OFFSET(tmp389, 4));
	{ void *tmp388 = RML_OFFSET(tmp389, 5);
	RML_STORE(RML_OFFSET(tmp388, -1), tmp261);
	RML_STORE(RML_OFFSET(tmp388, -2), tmp269);
	RML_STORE(RML_OFFSET(tmp388, -3), tmp159);
	RML_STORE(RML_OFFSET(tmp388, -4), tmp160);
	RML_STORE(RML_OFFSET(tmp388, -5), RML_LABVAL(exp2_2dsclam210));
	rmlA6 = RML_REFSTRINGLIT(lit14);
	rmlA5 = RML_REFSTRINGLIT(lit10);
	rmlA4 = RML_IMMEDIATE(RML_TAGFIXNUM(22));
	rmlA3 = RML_IMMEDIATE(RML_TAGFIXNUM(40));
	rmlA2 = RML_IMMEDIATE(RML_TAGFIXNUM(9));
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(40));
	rmlA0 = RML_REFSTRINGLIT(lit1);
	rmlFC = tmp159;
	rmlSC = RML_OFFSET(tmp388, -5);
	rmlSP = RML_OFFSET(tmp388, -5);
	RML_TAILCALLQ(RML__debug,7);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp2_2dsclam210)
{

	{ void *tmp392 = rmlSC;
	{ void *tmp160 = RML_FETCH(RML_OFFSET(tmp392, 1));
	{ void *tmp159 = RML_FETCH(RML_OFFSET(tmp392, 2));
	{ void *tmp269 = RML_FETCH(RML_OFFSET(tmp392, 3));
	{ void *tmp261 = RML_FETCH(RML_OFFSET(tmp392, 4));
	{ void *tmp391 = RML_OFFSET(tmp392, 5);
	{ void *tmp331 = RML_PRIM_INT_MUL(tmp261, tmp269);
	RML_STORE(RML_OFFSET(tmp391, -1), tmp160);
	RML_STORE(RML_OFFSET(tmp391, -2), tmp331);
	RML_STORE(RML_OFFSET(tmp391, -3), RML_LABVAL(exp2_2dsclam208));
	rmlA1 = tmp331;
	rmlA0 = RML_REFSTRINGLIT(lit12);
	rmlFC = tmp159;
	rmlSC = RML_OFFSET(tmp391, -3);
	rmlSP = RML_OFFSET(tmp391, -3);
	RML_TAILCALLQ(RML__debug_5fpush_5fout01,2);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp2_2dsclam208)
{

	{ void *tmp395 = rmlSC;
	{ void *tmp331 = RML_FETCH(RML_OFFSET(tmp395, 1));
	{ void *tmp160 = RML_FETCH(RML_OFFSET(tmp395, 2));
	{ void *tmp394 = RML_OFFSET(tmp395, 3);
	rmlA0 = tmp331;
	rmlSC = tmp160;
	rmlSP = tmp394;
	RML_TAILCALL(RML_FETCH(tmp160),1);}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp2_2dsclam199)
{

	{ void *tmp380 = rmlSC;
	{ void *tmp160 = RML_FETCH(RML_OFFSET(tmp380, 1));
	{ void *tmp261 = RML_FETCH(RML_OFFSET(tmp380, 2));
	{ void *tmp269 = RML_FETCH(RML_OFFSET(tmp380, 3));
	{ void *tmp159 = RML_FETCH(RML_OFFSET(tmp380, 4));
	{ void *tmp379 = RML_OFFSET(tmp380, 5);
	RML_STORE(RML_OFFSET(tmp379, -1), tmp269);
	RML_STORE(RML_OFFSET(tmp379, -2), tmp159);
	RML_STORE(RML_OFFSET(tmp379, -3), tmp261);
	RML_STORE(RML_OFFSET(tmp379, -4), tmp160);
	RML_STORE(RML_OFFSET(tmp379, -5), RML_LABVAL(exp2_2dsclam198));
	rmlA6 = RML_REFSTRINGLIT(lit13);
	rmlA5 = RML_REFSTRINGLIT(lit10);
	rmlA4 = RML_IMMEDIATE(RML_TAGFIXNUM(22));
	rmlA3 = RML_IMMEDIATE(RML_TAGFIXNUM(44));
	rmlA2 = RML_IMMEDIATE(RML_TAGFIXNUM(9));
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(44));
	rmlA0 = RML_REFSTRINGLIT(lit1);
	rmlFC = tmp159;
	rmlSC = RML_OFFSET(tmp379, -5);
	rmlSP = RML_OFFSET(tmp379, -5);
	RML_TAILCALLQ(RML__debug,7);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp2_2dsclam198)
{

	{ void *tmp383 = rmlSC;
	{ void *tmp160 = RML_FETCH(RML_OFFSET(tmp383, 1));
	{ void *tmp261 = RML_FETCH(RML_OFFSET(tmp383, 2));
	{ void *tmp159 = RML_FETCH(RML_OFFSET(tmp383, 3));
	{ void *tmp269 = RML_FETCH(RML_OFFSET(tmp383, 4));
	{ void *tmp382 = RML_OFFSET(tmp383, 5);
	switch( (rml_sint_t)tmp269 ) {
	case RML_TAGFIXNUM(0):
	rmlFC = tmp159;
	rmlSP = tmp382;
	RML_TAILCALL(RML_FETCH(tmp159),0);
	default:
	{ void *tmp328 = RML_PRIM_INT_DIV(tmp261, tmp269);
	RML_STORE(RML_OFFSET(tmp382, -1), tmp160);
	RML_STORE(RML_OFFSET(tmp382, -2), tmp328);
	RML_STORE(RML_OFFSET(tmp382, -3), RML_LABVAL(exp2_2dsclam196));
	rmlA1 = tmp328;
	rmlA0 = RML_REFSTRINGLIT(lit12);
	rmlFC = tmp159;
	rmlSC = RML_OFFSET(tmp382, -3);
	rmlSP = RML_OFFSET(tmp382, -3);
	RML_TAILCALLQ(RML__debug_5fpush_5fout01,2);}
	}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp2_2dsclam196)
{

	{ void *tmp386 = rmlSC;
	{ void *tmp328 = RML_FETCH(RML_OFFSET(tmp386, 1));
	{ void *tmp160 = RML_FETCH(RML_OFFSET(tmp386, 2));
	{ void *tmp385 = RML_OFFSET(tmp386, 3);
	rmlA0 = tmp328;
	rmlSC = tmp160;
	rmlSP = tmp385;
	RML_TAILCALL(RML_FETCH(tmp160),1);}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp2_2dsclam187)
{

	{ void *tmp371 = rmlSC;
	{ void *tmp160 = RML_FETCH(RML_OFFSET(tmp371, 1));
	{ void *tmp269 = RML_FETCH(RML_OFFSET(tmp371, 2));
	{ void *tmp261 = RML_FETCH(RML_OFFSET(tmp371, 3));
	{ void *tmp159 = RML_FETCH(RML_OFFSET(tmp371, 4));
	{ void *tmp370 = RML_OFFSET(tmp371, 5);
	RML_STORE(RML_OFFSET(tmp370, -1), tmp261);
	RML_STORE(RML_OFFSET(tmp370, -2), tmp269);
	RML_STORE(RML_OFFSET(tmp370, -3), tmp159);
	RML_STORE(RML_OFFSET(tmp370, -4), tmp160);
	RML_STORE(RML_OFFSET(tmp370, -5), RML_LABVAL(exp2_2dsclam186));
	rmlA6 = RML_REFSTRINGLIT(lit11);
	rmlA5 = RML_REFSTRINGLIT(lit10);
	rmlA4 = RML_IMMEDIATE(RML_TAGFIXNUM(22));
	rmlA3 = RML_IMMEDIATE(RML_TAGFIXNUM(36));
	rmlA2 = RML_IMMEDIATE(RML_TAGFIXNUM(9));
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(36));
	rmlA0 = RML_REFSTRINGLIT(lit1);
	rmlFC = tmp159;
	rmlSC = RML_OFFSET(tmp370, -5);
	rmlSP = RML_OFFSET(tmp370, -5);
	RML_TAILCALLQ(RML__debug,7);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp2_2dsclam186)
{

	{ void *tmp374 = rmlSC;
	{ void *tmp160 = RML_FETCH(RML_OFFSET(tmp374, 1));
	{ void *tmp159 = RML_FETCH(RML_OFFSET(tmp374, 2));
	{ void *tmp269 = RML_FETCH(RML_OFFSET(tmp374, 3));
	{ void *tmp261 = RML_FETCH(RML_OFFSET(tmp374, 4));
	{ void *tmp373 = RML_OFFSET(tmp374, 5);
	{ void *tmp325 = RML_PRIM_INT_SUB(tmp261, tmp269);
	RML_STORE(RML_OFFSET(tmp373, -1), tmp160);
	RML_STORE(RML_OFFSET(tmp373, -2), tmp325);
	RML_STORE(RML_OFFSET(tmp373, -3), RML_LABVAL(exp2_2dsclam184));
	rmlA1 = tmp325;
	rmlA0 = RML_REFSTRINGLIT(lit12);
	rmlFC = tmp159;
	rmlSC = RML_OFFSET(tmp373, -3);
	rmlSP = RML_OFFSET(tmp373, -3);
	RML_TAILCALLQ(RML__debug_5fpush_5fout01,2);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp2_2dsclam184)
{

	{ void *tmp377 = rmlSC;
	{ void *tmp325 = RML_FETCH(RML_OFFSET(tmp377, 1));
	{ void *tmp160 = RML_FETCH(RML_OFFSET(tmp377, 2));
	{ void *tmp376 = RML_OFFSET(tmp377, 3);
	rmlA0 = tmp325;
	rmlSC = tmp160;
	rmlSP = tmp376;
	RML_TAILCALL(RML_FETCH(tmp160),1);}}}}
}
RML_END_LABEL
