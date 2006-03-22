/* module Types */
#include "rml.h"
#include <stdlib.h>
#include <stdio.h>
RML_DEFINE_MODULE("Types")
extern RML_FORWARD_LABEL(RML__lvar_5fget);
extern RML_FORWARD_LABEL(RML__debug_5fpush_5fin01);
extern RML_FORWARD_LABEL(RML__tick);
extern RML_FORWARD_LABEL(RML__lvar_5fnew);
extern RML_FORWARD_LABEL(RML__debug_5fpush_5fin03);
extern RML_FORWARD_LABEL(RML__debug);
extern RML_FORWARD_LABEL(RML__debug_5fpush_5fout01);

RML_FORWARD_LABEL(Types__alpha_5fovld);
static RML_FORWARD_LABEL(Types_2dsclam188);
static RML_FORWARD_LABEL(Types_2dsclam187);
static RML_FORWARD_LABEL(Types_2dsclam186);
RML_FORWARD_LABEL(Types__deref);
static RML_FORWARD_LABEL(Types_2dsclam249);
static RML_FORWARD_LABEL(Types_2dsclam248);
static RML_FORWARD_LABEL(Types_2dsclam247);
static RML_FORWARD_LABEL(Types_2dsclam246);
static RML_FORWARD_LABEL(Types_2dfclam236);
static RML_FORWARD_LABEL(Types_2dsclam235);
static RML_FORWARD_LABEL(Types_2dsclam234);
static RML_FORWARD_LABEL(Types_2dsclam233);
static RML_FORWARD_LABEL(Types_2dsclam232);
static RML_FORWARD_LABEL(Types_2dsclam231);
static RML_FORWARD_LABEL(Types_2dsclam205);
static RML_FORWARD_LABEL(Types_2dsclam204);
static RML_FORWARD_LABEL(Types_2dsclam203);
RML_FORWARD_LABEL(Types__mkEqAlpha);
static RML_FORWARD_LABEL(Types_2dsclam264);
static RML_FORWARD_LABEL(Types_2dsclam263);
static RML_FORWARD_LABEL(Types_2dsclam262);
static RML_FORWARD_LABEL(Types_2dsclam261);
RML_FORWARD_LABEL(Types__mkAlpha);
static RML_FORWARD_LABEL(Types_2dsclam288);
static RML_FORWARD_LABEL(Types_2dsclam287);
static RML_FORWARD_LABEL(Types_2dsclam286);
static RML_FORWARD_LABEL(Types_2dsclam285);
static RML_FORWARD_LABEL(Types_2dsclam284);
RML_FORWARD_LABEL(Types__mkFreeAlpha);
static RML_FORWARD_LABEL(Types_2dsclam303);
static RML_FORWARD_LABEL(Types_2dsclam302);
static RML_FORWARD_LABEL(Types_2dsclam301);
static RML_FORWARD_LABEL(Types_2dsclam300);
RML_FORWARD_LABEL(Types__mkOvldAlpha);
static RML_FORWARD_LABEL(Types_2dsclam321);
static RML_FORWARD_LABEL(Types_2dsclam320);
static RML_FORWARD_LABEL(Types_2dsclam319);
static RML_FORWARD_LABEL(Types_2dsclam318);

static const RML_DEFSTRINGLIT(lit0,3,"lev");
static const RML_DEFSTRINGLIT(lit1,5,"false");
static const RML_DEFSTRINGLIT(lit2,10,"SOME(ovld)");
static const RML_DEFSTRINGLIT(lit3,9,"types.rml");
static const RML_DEFSTRINGLIT(lit4,11,"mkOvldAlpha");
static const RML_DEFSTRINGLIT(lit5,45,"call:mkAlpha(lev,false,SOME(ovld)) => (alpha)");
static const RML_DEFSTRINGLIT(lit6,5,"alpha");
static const RML_DEFSTRINGLIT(lit7,4,"NONE");
static const RML_DEFSTRUCT0LIT(lit8,0);
static const RML_DEFSTRINGLIT(lit9,11,"mkFreeAlpha");
static const RML_DEFSTRINGLIT(lit10,39,"call:mkAlpha(lev,false,NONE) => (alpha)");
static const RML_DEFSTRINGLIT(lit11,7,"mkAlpha");
static const RML_DEFSTRINGLIT(lit12,20,"call:tick() => (tag)");
static const RML_DEFSTRINGLIT(lit13,3,"tag");
static const RML_DEFSTRINGLIT(lit14,26,"call:lvar_new() => (subst)");
static const RML_DEFSTRINGLIT(lit15,4,"true");
static const RML_DEFSTRINGLIT(lit16,9,"mkEqAlpha");
static const RML_DEFSTRINGLIT(lit17,38,"call:mkAlpha(lev,true,NONE) => (alpha)");
static const RML_DEFSTRINGLIT(lit18,2,"ty");
static const RML_DEFSTRINGLIT(lit19,5,"deref");
static const RML_DEFSTRINGLIT(lit20,36,"axiom:deref(ty as CONS(_,_)) => (ty)");
static const RML_DEFSTRINGLIT(lit21,5,"subst");
static const RML_DEFSTRINGLIT(lit22,35,"call:lvar_get(subst) => (SOME(ty'))");
static const RML_DEFSTRINGLIT(lit23,3,"ty'");
static const RML_DEFSTRINGLIT(lit24,23,"call:deref(ty') => (ty)");
static const RML_DEFSTRINGLIT(lit25,30,"call:lvar_get(subst) => (NONE)");
static const RML_DEFSTRINGLIT(lit26,4,"ovld");
static const RML_DEFSTRINGLIT(lit27,10,"alpha_ovld");
static const RML_DEFSTRINGLIT(lit28,47,"axiom:alpha_ovld(ALPHA(_,_,_,ovld,_)) => (ovld)");

extern void RML_5finit(void);

void Types_5finit(void)
{
	static int done = 0;
	if( done ) return;
	done = 1;
	RML_5finit();
	rmldb_load_db("types.rdb");
}

RML_BEGIN_LABEL(Types__alpha_5fovld)
{

	{ void *tmp161 = rmlSC;
	{ void *tmp160 = rmlFC;
	{ void *tmp423 = rmlSP;
	{ void *tmp162 = rmlA0;
	{ void *tmp182 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp162), 4));
	RML_STORE(RML_OFFSET(tmp423, -1), tmp160);
	RML_STORE(RML_OFFSET(tmp423, -2), tmp182);
	RML_STORE(RML_OFFSET(tmp423, -3), tmp161);
	RML_STORE(RML_OFFSET(tmp423, -4), RML_LABVAL(Types_2dsclam188));
	rmlA1 = tmp182;
	rmlA0 = RML_REFSTRINGLIT(lit26);
	rmlSC = RML_OFFSET(tmp423, -4);
	rmlSP = RML_OFFSET(tmp423, -4);
	RML_TAILCALLQ(RML__debug_5fpush_5fin01,2);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Types_2dsclam188)
{

	{ void *tmp426 = rmlSC;
	{ void *tmp161 = RML_FETCH(RML_OFFSET(tmp426, 1));
	{ void *tmp182 = RML_FETCH(RML_OFFSET(tmp426, 2));
	{ void *tmp160 = RML_FETCH(RML_OFFSET(tmp426, 3));
	{ void *tmp425 = RML_OFFSET(tmp426, 4);
	RML_STORE(RML_OFFSET(tmp425, -1), tmp182);
	RML_STORE(RML_OFFSET(tmp425, -2), tmp160);
	RML_STORE(RML_OFFSET(tmp425, -3), tmp161);
	RML_STORE(RML_OFFSET(tmp425, -4), RML_LABVAL(Types_2dsclam187));
	rmlA6 = RML_REFSTRINGLIT(lit28);
	rmlA5 = RML_REFSTRINGLIT(lit27);
	rmlA4 = RML_IMMEDIATE(RML_TAGFIXNUM(18));
	rmlA3 = RML_IMMEDIATE(RML_TAGFIXNUM(44));
	rmlA2 = RML_IMMEDIATE(RML_TAGFIXNUM(3));
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(44));
	rmlA0 = RML_REFSTRINGLIT(lit3);
	rmlFC = tmp160;
	rmlSC = RML_OFFSET(tmp425, -4);
	rmlSP = RML_OFFSET(tmp425, -4);
	RML_TAILCALLQ(RML__debug,7);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Types_2dsclam187)
{

	{ void *tmp429 = rmlSC;
	{ void *tmp161 = RML_FETCH(RML_OFFSET(tmp429, 1));
	{ void *tmp160 = RML_FETCH(RML_OFFSET(tmp429, 2));
	{ void *tmp182 = RML_FETCH(RML_OFFSET(tmp429, 3));
	{ void *tmp428 = RML_OFFSET(tmp429, 4);
	RML_STORE(RML_OFFSET(tmp428, -1), tmp161);
	RML_STORE(RML_OFFSET(tmp428, -2), tmp182);
	RML_STORE(RML_OFFSET(tmp428, -3), RML_LABVAL(Types_2dsclam186));
	rmlA1 = tmp182;
	rmlA0 = RML_REFSTRINGLIT(lit26);
	rmlFC = tmp160;
	rmlSC = RML_OFFSET(tmp428, -3);
	rmlSP = RML_OFFSET(tmp428, -3);
	RML_TAILCALLQ(RML__debug_5fpush_5fout01,2);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Types_2dsclam186)
{

	{ void *tmp432 = rmlSC;
	{ void *tmp182 = RML_FETCH(RML_OFFSET(tmp432, 1));
	{ void *tmp161 = RML_FETCH(RML_OFFSET(tmp432, 2));
	{ void *tmp431 = RML_OFFSET(tmp432, 3);
	rmlA0 = tmp182;
	rmlSC = tmp161;
	rmlSP = tmp431;
	RML_TAILCALL(RML_FETCH(tmp161),1);}}}}
}
RML_END_LABEL

RML_BEGIN_LABEL(Types__deref)
{

	{ void *tmp158 = rmlSC;
	{ void *tmp157 = rmlFC;
	{ void *tmp382 = rmlSP;
	{ void *tmp159 = rmlA0;
	{ void *tmp199 = RML_FETCH(RML_UNTAGPTR(tmp159));
	switch( (rml_sint_t)tmp199 ) {
	case RML_STRUCTHDR(2,1):
	RML_STORE(RML_OFFSET(tmp382, -1), tmp157);
	RML_STORE(RML_OFFSET(tmp382, -2), tmp159);
	RML_STORE(RML_OFFSET(tmp382, -3), tmp158);
	RML_STORE(RML_OFFSET(tmp382, -4), RML_LABVAL(Types_2dsclam205));
	rmlA1 = tmp159;
	rmlA0 = RML_REFSTRINGLIT(lit18);
	rmlSC = RML_OFFSET(tmp382, -4);
	rmlSP = RML_OFFSET(tmp382, -4);
	RML_TAILCALLQ(RML__debug_5fpush_5fin01,2);
	/*case RML_STRUCTHDR(1,0)*/
	default:
	{ void *tmp206 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp159), 1));
	{ void *tmp207 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp206), 5));
	RML_STORE(RML_OFFSET(tmp382, -1), tmp157);
	RML_STORE(RML_OFFSET(tmp382, -2), tmp207);
	RML_STORE(RML_OFFSET(tmp382, -3), tmp158);
	RML_STORE(RML_OFFSET(tmp382, -4), tmp159);
	RML_STORE(RML_OFFSET(tmp382, -5), RML_LABVAL(Types_2dsclam249));
	rmlA1 = tmp207;
	rmlA0 = RML_REFSTRINGLIT(lit21);
	rmlSC = RML_OFFSET(tmp382, -5);
	rmlSP = RML_OFFSET(tmp382, -5);
	RML_TAILCALLQ(RML__debug_5fpush_5fin01,2);}}
	}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Types_2dsclam249)
{

	{ void *tmp394 = rmlSC;
	{ void *tmp159 = RML_FETCH(RML_OFFSET(tmp394, 1));
	{ void *tmp158 = RML_FETCH(RML_OFFSET(tmp394, 2));
	{ void *tmp207 = RML_FETCH(RML_OFFSET(tmp394, 3));
	{ void *tmp157 = RML_FETCH(RML_OFFSET(tmp394, 4));
	{ void *tmp393 = RML_OFFSET(tmp394, 5);
	{ void *tmp209 = rml_prim_marker();
	RML_STORE(RML_OFFSET(tmp393, -1), tmp209);
	RML_STORE(RML_OFFSET(tmp393, -2), tmp157);
	RML_STORE(RML_OFFSET(tmp393, -3), tmp207);
	RML_STORE(RML_OFFSET(tmp393, -4), tmp158);
	RML_STORE(RML_OFFSET(tmp393, -5), RML_LABVAL(Types_2dfclam236));
	{ void *tmp210 = RML_OFFSET(tmp393, -5);
	RML_STORE(RML_OFFSET(tmp393, -6), tmp207);
	RML_STORE(RML_OFFSET(tmp393, -7), tmp210);
	RML_STORE(RML_OFFSET(tmp393, -8), tmp158);
	RML_STORE(RML_OFFSET(tmp393, -9), tmp159);
	RML_STORE(RML_OFFSET(tmp393, -10), RML_LABVAL(Types_2dsclam248));
	rmlA6 = RML_REFSTRINGLIT(lit25);
	rmlA5 = RML_REFSTRINGLIT(lit19);
	rmlA4 = RML_IMMEDIATE(RML_TAGFIXNUM(21));
	rmlA3 = RML_IMMEDIATE(RML_TAGFIXNUM(48));
	rmlA2 = RML_IMMEDIATE(RML_TAGFIXNUM(8));
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(48));
	rmlA0 = RML_REFSTRINGLIT(lit3);
	rmlFC = tmp210;
	rmlSC = RML_OFFSET(tmp393, -10);
	rmlSP = RML_OFFSET(tmp393, -10);
	RML_TAILCALLQ(RML__debug,7);}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Types_2dsclam248)
{

	{ void *tmp415 = rmlSC;
	{ void *tmp159 = RML_FETCH(RML_OFFSET(tmp415, 1));
	{ void *tmp158 = RML_FETCH(RML_OFFSET(tmp415, 2));
	{ void *tmp210 = RML_FETCH(RML_OFFSET(tmp415, 3));
	{ void *tmp207 = RML_FETCH(RML_OFFSET(tmp415, 4));
	{ void *tmp414 = RML_OFFSET(tmp415, 5);
	RML_STORE(RML_OFFSET(tmp414, -1), tmp210);
	RML_STORE(RML_OFFSET(tmp414, -2), tmp158);
	RML_STORE(RML_OFFSET(tmp414, -3), tmp159);
	RML_STORE(RML_OFFSET(tmp414, -4), RML_LABVAL(Types_2dsclam247));
	rmlA0 = tmp207;
	rmlFC = tmp210;
	rmlSC = RML_OFFSET(tmp414, -4);
	rmlSP = RML_OFFSET(tmp414, -4);
	RML_TAILCALLQ(RML__lvar_5fget,1);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Types_2dsclam247)
{

	{ void *tmp418 = rmlSC;
	{ void *tmp159 = RML_FETCH(RML_OFFSET(tmp418, 1));
	{ void *tmp158 = RML_FETCH(RML_OFFSET(tmp418, 2));
	{ void *tmp210 = RML_FETCH(RML_OFFSET(tmp418, 3));
	{ void *tmp417 = RML_OFFSET(tmp418, 4);
	{ void *tmp239 = rmlA0;
	{ void *tmp244 = RML_FETCH(RML_UNTAGPTR(tmp239));
	switch( (rml_sint_t)tmp244 ) {
	case RML_STRUCTHDR(0,0):
	RML_STORE(RML_OFFSET(tmp417, -1), tmp158);
	RML_STORE(RML_OFFSET(tmp417, -2), tmp159);
	RML_STORE(RML_OFFSET(tmp417, -3), RML_LABVAL(Types_2dsclam246));
	rmlA1 = RML_REFSTRUCTLIT(lit8);
	rmlA0 = RML_REFSTRINGLIT(lit7);
	rmlFC = tmp210;
	rmlSC = RML_OFFSET(tmp417, -3);
	rmlSP = RML_OFFSET(tmp417, -3);
	RML_TAILCALLQ(RML__debug_5fpush_5fout01,2);
	default:
	rmlFC = tmp210;
	rmlSP = tmp417;
	RML_TAILCALL(RML_FETCH(tmp210),0);
	}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Types_2dsclam246)
{

	{ void *tmp421 = rmlSC;
	{ void *tmp159 = RML_FETCH(RML_OFFSET(tmp421, 1));
	{ void *tmp158 = RML_FETCH(RML_OFFSET(tmp421, 2));
	{ void *tmp420 = RML_OFFSET(tmp421, 3);
	rmlA0 = tmp159;
	rmlSC = tmp158;
	rmlSP = tmp420;
	RML_TAILCALL(RML_FETCH(tmp158),1);}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Types_2dfclam236)
{

	{ void *tmp397 = rmlFC;
	{ void *tmp158 = RML_FETCH(RML_OFFSET(tmp397, 1));
	{ void *tmp207 = RML_FETCH(RML_OFFSET(tmp397, 2));
	{ void *tmp157 = RML_FETCH(RML_OFFSET(tmp397, 3));
	{ void *tmp209 = RML_FETCH(RML_OFFSET(tmp397, 4));
	{ void *tmp396 = RML_OFFSET(tmp397, 5);
	rml_prim_unwind(tmp209);
	RML_STORE(RML_OFFSET(tmp396, -1), tmp207);
	RML_STORE(RML_OFFSET(tmp396, -2), tmp157);
	RML_STORE(RML_OFFSET(tmp396, -3), tmp158);
	RML_STORE(RML_OFFSET(tmp396, -4), RML_LABVAL(Types_2dsclam235));
	rmlA6 = RML_REFSTRINGLIT(lit22);
	rmlA5 = RML_REFSTRINGLIT(lit19);
	rmlA4 = RML_IMMEDIATE(RML_TAGFIXNUM(21));
	rmlA3 = RML_IMMEDIATE(RML_TAGFIXNUM(52));
	rmlA2 = RML_IMMEDIATE(RML_TAGFIXNUM(8));
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(52));
	rmlA0 = RML_REFSTRINGLIT(lit3);
	rmlFC = tmp157;
	rmlSC = RML_OFFSET(tmp396, -4);
	rmlSP = RML_OFFSET(tmp396, -4);
	RML_TAILCALLQ(RML__debug,7);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Types_2dsclam235)
{

	{ void *tmp400 = rmlSC;
	{ void *tmp158 = RML_FETCH(RML_OFFSET(tmp400, 1));
	{ void *tmp157 = RML_FETCH(RML_OFFSET(tmp400, 2));
	{ void *tmp207 = RML_FETCH(RML_OFFSET(tmp400, 3));
	{ void *tmp399 = RML_OFFSET(tmp400, 4);
	RML_STORE(RML_OFFSET(tmp399, -1), tmp157);
	RML_STORE(RML_OFFSET(tmp399, -2), tmp158);
	RML_STORE(RML_OFFSET(tmp399, -3), RML_LABVAL(Types_2dsclam234));
	rmlA0 = tmp207;
	rmlFC = tmp157;
	rmlSC = RML_OFFSET(tmp399, -3);
	rmlSP = RML_OFFSET(tmp399, -3);
	RML_TAILCALLQ(RML__lvar_5fget,1);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Types_2dsclam234)
{

	{ void *tmp403 = rmlSC;
	{ void *tmp158 = RML_FETCH(RML_OFFSET(tmp403, 1));
	{ void *tmp157 = RML_FETCH(RML_OFFSET(tmp403, 2));
	{ void *tmp402 = RML_OFFSET(tmp403, 3);
	{ void *tmp213 = rmlA0;
	{ void *tmp220 = RML_FETCH(RML_UNTAGPTR(tmp213));
	switch( (rml_sint_t)tmp220 ) {
	case RML_STRUCTHDR(1,1):
	{ void *tmp221 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp213), 1));
	RML_STORE(RML_OFFSET(tmp402, -1), tmp221);
	RML_STORE(RML_OFFSET(tmp402, -2), tmp157);
	RML_STORE(RML_OFFSET(tmp402, -3), tmp158);
	RML_STORE(RML_OFFSET(tmp402, -4), RML_LABVAL(Types_2dsclam233));
	rmlA1 = tmp221;
	rmlA0 = RML_REFSTRINGLIT(lit23);
	rmlFC = tmp157;
	rmlSC = RML_OFFSET(tmp402, -4);
	rmlSP = RML_OFFSET(tmp402, -4);
	RML_TAILCALLQ(RML__debug_5fpush_5fout01,2);}
	default:
	rmlFC = tmp157;
	rmlSP = tmp402;
	RML_TAILCALL(RML_FETCH(tmp157),0);
	}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Types_2dsclam233)
{

	{ void *tmp406 = rmlSC;
	{ void *tmp158 = RML_FETCH(RML_OFFSET(tmp406, 1));
	{ void *tmp157 = RML_FETCH(RML_OFFSET(tmp406, 2));
	{ void *tmp221 = RML_FETCH(RML_OFFSET(tmp406, 3));
	{ void *tmp405 = RML_OFFSET(tmp406, 4);
	RML_STORE(RML_OFFSET(tmp405, -1), tmp157);
	RML_STORE(RML_OFFSET(tmp405, -2), tmp221);
	RML_STORE(RML_OFFSET(tmp405, -3), tmp158);
	RML_STORE(RML_OFFSET(tmp405, -4), RML_LABVAL(Types_2dsclam232));
	rmlA1 = tmp221;
	rmlA0 = RML_REFSTRINGLIT(lit23);
	rmlFC = tmp157;
	rmlSC = RML_OFFSET(tmp405, -4);
	rmlSP = RML_OFFSET(tmp405, -4);
	RML_TAILCALLQ(RML__debug_5fpush_5fin01,2);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Types_2dsclam232)
{

	{ void *tmp409 = rmlSC;
	{ void *tmp158 = RML_FETCH(RML_OFFSET(tmp409, 1));
	{ void *tmp221 = RML_FETCH(RML_OFFSET(tmp409, 2));
	{ void *tmp157 = RML_FETCH(RML_OFFSET(tmp409, 3));
	{ void *tmp408 = RML_OFFSET(tmp409, 4);
	RML_STORE(RML_OFFSET(tmp408, -1), tmp221);
	RML_STORE(RML_OFFSET(tmp408, -2), tmp157);
	RML_STORE(RML_OFFSET(tmp408, -3), tmp158);
	RML_STORE(RML_OFFSET(tmp408, -4), RML_LABVAL(Types_2dsclam231));
	rmlA6 = RML_REFSTRINGLIT(lit24);
	rmlA5 = RML_REFSTRINGLIT(lit19);
	rmlA4 = RML_IMMEDIATE(RML_TAGFIXNUM(45));
	rmlA3 = RML_IMMEDIATE(RML_TAGFIXNUM(52));
	rmlA2 = RML_IMMEDIATE(RML_TAGFIXNUM(37));
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(52));
	rmlA0 = RML_REFSTRINGLIT(lit3);
	rmlFC = tmp157;
	rmlSC = RML_OFFSET(tmp408, -4);
	rmlSP = RML_OFFSET(tmp408, -4);
	RML_TAILCALLQ(RML__debug,7);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Types_2dsclam231)
{

	{ void *tmp412 = rmlSC;
	{ void *tmp158 = RML_FETCH(RML_OFFSET(tmp412, 1));
	{ void *tmp157 = RML_FETCH(RML_OFFSET(tmp412, 2));
	{ void *tmp221 = RML_FETCH(RML_OFFSET(tmp412, 3));
	{ void *tmp411 = RML_OFFSET(tmp412, 4);
	rmlA0 = tmp221;
	rmlFC = tmp157;
	rmlSC = tmp158;
	rmlSP = tmp411;
	RML_TAILCALLQ(Types__deref,1);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Types_2dsclam205)
{

	{ void *tmp385 = rmlSC;
	{ void *tmp158 = RML_FETCH(RML_OFFSET(tmp385, 1));
	{ void *tmp159 = RML_FETCH(RML_OFFSET(tmp385, 2));
	{ void *tmp157 = RML_FETCH(RML_OFFSET(tmp385, 3));
	{ void *tmp384 = RML_OFFSET(tmp385, 4);
	RML_STORE(RML_OFFSET(tmp384, -1), tmp159);
	RML_STORE(RML_OFFSET(tmp384, -2), tmp157);
	RML_STORE(RML_OFFSET(tmp384, -3), tmp158);
	RML_STORE(RML_OFFSET(tmp384, -4), RML_LABVAL(Types_2dsclam204));
	rmlA6 = RML_REFSTRINGLIT(lit20);
	rmlA5 = RML_REFSTRINGLIT(lit19);
	rmlA4 = RML_IMMEDIATE(RML_TAGFIXNUM(13));
	rmlA3 = RML_IMMEDIATE(RML_TAGFIXNUM(56));
	rmlA2 = RML_IMMEDIATE(RML_TAGFIXNUM(3));
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(56));
	rmlA0 = RML_REFSTRINGLIT(lit3);
	rmlFC = tmp157;
	rmlSC = RML_OFFSET(tmp384, -4);
	rmlSP = RML_OFFSET(tmp384, -4);
	RML_TAILCALLQ(RML__debug,7);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Types_2dsclam204)
{

	{ void *tmp388 = rmlSC;
	{ void *tmp158 = RML_FETCH(RML_OFFSET(tmp388, 1));
	{ void *tmp157 = RML_FETCH(RML_OFFSET(tmp388, 2));
	{ void *tmp159 = RML_FETCH(RML_OFFSET(tmp388, 3));
	{ void *tmp387 = RML_OFFSET(tmp388, 4);
	RML_STORE(RML_OFFSET(tmp387, -1), tmp158);
	RML_STORE(RML_OFFSET(tmp387, -2), tmp159);
	RML_STORE(RML_OFFSET(tmp387, -3), RML_LABVAL(Types_2dsclam203));
	rmlA1 = tmp159;
	rmlA0 = RML_REFSTRINGLIT(lit18);
	rmlFC = tmp157;
	rmlSC = RML_OFFSET(tmp387, -3);
	rmlSP = RML_OFFSET(tmp387, -3);
	RML_TAILCALLQ(RML__debug_5fpush_5fout01,2);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Types_2dsclam203)
{

	{ void *tmp391 = rmlSC;
	{ void *tmp159 = RML_FETCH(RML_OFFSET(tmp391, 1));
	{ void *tmp158 = RML_FETCH(RML_OFFSET(tmp391, 2));
	{ void *tmp390 = RML_OFFSET(tmp391, 3);
	rmlA0 = tmp159;
	rmlSC = tmp158;
	rmlSP = tmp390;
	RML_TAILCALL(RML_FETCH(tmp158),1);}}}}
}
RML_END_LABEL

RML_BEGIN_LABEL(Types__mkEqAlpha)
{

	{ void *tmp173 = rmlSC;
	{ void *tmp172 = rmlFC;
	{ void *tmp368 = rmlSP;
	{ void *tmp174 = rmlA0;
	RML_STORE(RML_OFFSET(tmp368, -1), tmp172);
	RML_STORE(RML_OFFSET(tmp368, -2), tmp174);
	RML_STORE(RML_OFFSET(tmp368, -3), tmp173);
	RML_STORE(RML_OFFSET(tmp368, -4), RML_LABVAL(Types_2dsclam264));
	rmlA5 = RML_REFSTRUCTLIT(lit8);
	rmlA4 = RML_REFSTRINGLIT(lit7);
	rmlA3 = RML_IMMEDIATE(RML_TAGFIXNUM(1));
	rmlA2 = RML_REFSTRINGLIT(lit15);
	rmlA1 = tmp174;
	rmlA0 = RML_REFSTRINGLIT(lit0);
	rmlSC = RML_OFFSET(tmp368, -4);
	rmlSP = RML_OFFSET(tmp368, -4);
	RML_TAILCALLQ(RML__debug_5fpush_5fin03,6);}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Types_2dsclam264)
{

	{ void *tmp371 = rmlSC;
	{ void *tmp173 = RML_FETCH(RML_OFFSET(tmp371, 1));
	{ void *tmp174 = RML_FETCH(RML_OFFSET(tmp371, 2));
	{ void *tmp172 = RML_FETCH(RML_OFFSET(tmp371, 3));
	{ void *tmp370 = RML_OFFSET(tmp371, 4);
	RML_STORE(RML_OFFSET(tmp370, -1), tmp174);
	RML_STORE(RML_OFFSET(tmp370, -2), tmp172);
	RML_STORE(RML_OFFSET(tmp370, -3), tmp173);
	RML_STORE(RML_OFFSET(tmp370, -4), RML_LABVAL(Types_2dsclam263));
	rmlA6 = RML_REFSTRINGLIT(lit17);
	rmlA5 = RML_REFSTRINGLIT(lit16);
	rmlA4 = RML_IMMEDIATE(RML_TAGFIXNUM(31));
	rmlA3 = RML_IMMEDIATE(RML_TAGFIXNUM(32));
	rmlA2 = RML_IMMEDIATE(RML_TAGFIXNUM(8));
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(32));
	rmlA0 = RML_REFSTRINGLIT(lit3);
	rmlFC = tmp172;
	rmlSC = RML_OFFSET(tmp370, -4);
	rmlSP = RML_OFFSET(tmp370, -4);
	RML_TAILCALLQ(RML__debug,7);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Types_2dsclam263)
{

	{ void *tmp374 = rmlSC;
	{ void *tmp173 = RML_FETCH(RML_OFFSET(tmp374, 1));
	{ void *tmp172 = RML_FETCH(RML_OFFSET(tmp374, 2));
	{ void *tmp174 = RML_FETCH(RML_OFFSET(tmp374, 3));
	{ void *tmp373 = RML_OFFSET(tmp374, 4);
	RML_STORE(RML_OFFSET(tmp373, -1), tmp172);
	RML_STORE(RML_OFFSET(tmp373, -2), tmp173);
	RML_STORE(RML_OFFSET(tmp373, -3), RML_LABVAL(Types_2dsclam262));
	rmlA2 = RML_REFSTRUCTLIT(lit8);
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(1));
	rmlA0 = tmp174;
	rmlFC = tmp172;
	rmlSC = RML_OFFSET(tmp373, -3);
	rmlSP = RML_OFFSET(tmp373, -3);
	RML_TAILCALLQ(Types__mkAlpha,3);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Types_2dsclam262)
{

	{ void *tmp377 = rmlSC;
	{ void *tmp173 = RML_FETCH(RML_OFFSET(tmp377, 1));
	{ void *tmp172 = RML_FETCH(RML_OFFSET(tmp377, 2));
	{ void *tmp376 = RML_OFFSET(tmp377, 3);
	{ void *tmp256 = rmlA0;
	RML_STORE(RML_OFFSET(tmp376, -1), tmp173);
	RML_STORE(RML_OFFSET(tmp376, -2), tmp256);
	RML_STORE(RML_OFFSET(tmp376, -3), RML_LABVAL(Types_2dsclam261));
	rmlA1 = tmp256;
	rmlA0 = RML_REFSTRINGLIT(lit6);
	rmlFC = tmp172;
	rmlSC = RML_OFFSET(tmp376, -3);
	rmlSP = RML_OFFSET(tmp376, -3);
	RML_TAILCALLQ(RML__debug_5fpush_5fout01,2);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Types_2dsclam261)
{

	{ void *tmp380 = rmlSC;
	{ void *tmp256 = RML_FETCH(RML_OFFSET(tmp380, 1));
	{ void *tmp173 = RML_FETCH(RML_OFFSET(tmp380, 2));
	{ void *tmp379 = RML_OFFSET(tmp380, 3);
	rmlA0 = tmp256;
	rmlSC = tmp173;
	rmlSP = tmp379;
	RML_TAILCALL(RML_FETCH(tmp173),1);}}}}
}
RML_END_LABEL

RML_BEGIN_LABEL(Types__mkAlpha)
{

	{ void *tmp164 = rmlSC;
	{ void *tmp163 = rmlFC;
	{ void *tmp351 = rmlSP;
	{ void *tmp165 = rmlA0;
	{ void *tmp166 = rmlA1;
	{ void *tmp167 = rmlA2;
	RML_STORE(RML_OFFSET(tmp351, -1), tmp163);
	RML_STORE(RML_OFFSET(tmp351, -2), tmp165);
	RML_STORE(RML_OFFSET(tmp351, -3), tmp166);
	RML_STORE(RML_OFFSET(tmp351, -4), tmp167);
	RML_STORE(RML_OFFSET(tmp351, -5), tmp164);
	RML_STORE(RML_OFFSET(tmp351, -6), RML_LABVAL(Types_2dsclam288));
	rmlA6 = RML_REFSTRINGLIT(lit12);
	rmlA5 = RML_REFSTRINGLIT(lit11);
	rmlA4 = RML_IMMEDIATE(RML_TAGFIXNUM(13));
	rmlA3 = RML_IMMEDIATE(RML_TAGFIXNUM(20));
	rmlA2 = RML_IMMEDIATE(RML_TAGFIXNUM(8));
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(20));
	rmlA0 = RML_REFSTRINGLIT(lit3);
	rmlSC = RML_OFFSET(tmp351, -6);
	rmlSP = RML_OFFSET(tmp351, -6);
	RML_TAILCALLQ(RML__debug,7);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Types_2dsclam288)
{

	{ void *tmp354 = rmlSC;
	{ void *tmp164 = RML_FETCH(RML_OFFSET(tmp354, 1));
	{ void *tmp167 = RML_FETCH(RML_OFFSET(tmp354, 2));
	{ void *tmp166 = RML_FETCH(RML_OFFSET(tmp354, 3));
	{ void *tmp165 = RML_FETCH(RML_OFFSET(tmp354, 4));
	{ void *tmp163 = RML_FETCH(RML_OFFSET(tmp354, 5));
	{ void *tmp353 = RML_OFFSET(tmp354, 6);
	RML_STORE(RML_OFFSET(tmp353, -1), tmp163);
	RML_STORE(RML_OFFSET(tmp353, -2), tmp165);
	RML_STORE(RML_OFFSET(tmp353, -3), tmp166);
	RML_STORE(RML_OFFSET(tmp353, -4), tmp167);
	RML_STORE(RML_OFFSET(tmp353, -5), tmp164);
	RML_STORE(RML_OFFSET(tmp353, -6), RML_LABVAL(Types_2dsclam287));
	rmlFC = tmp163;
	rmlSC = RML_OFFSET(tmp353, -6);
	rmlSP = RML_OFFSET(tmp353, -6);
	RML_TAILCALLQ(RML__tick,0);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Types_2dsclam287)
{

	{ void *tmp357 = rmlSC;
	{ void *tmp164 = RML_FETCH(RML_OFFSET(tmp357, 1));
	{ void *tmp167 = RML_FETCH(RML_OFFSET(tmp357, 2));
	{ void *tmp166 = RML_FETCH(RML_OFFSET(tmp357, 3));
	{ void *tmp165 = RML_FETCH(RML_OFFSET(tmp357, 4));
	{ void *tmp163 = RML_FETCH(RML_OFFSET(tmp357, 5));
	{ void *tmp356 = RML_OFFSET(tmp357, 6);
	{ void *tmp272 = rmlA0;
	RML_STORE(RML_OFFSET(tmp356, -1), tmp163);
	RML_STORE(RML_OFFSET(tmp356, -2), tmp272);
	RML_STORE(RML_OFFSET(tmp356, -3), tmp165);
	RML_STORE(RML_OFFSET(tmp356, -4), tmp166);
	RML_STORE(RML_OFFSET(tmp356, -5), tmp167);
	RML_STORE(RML_OFFSET(tmp356, -6), tmp164);
	RML_STORE(RML_OFFSET(tmp356, -7), RML_LABVAL(Types_2dsclam286));
	rmlA1 = tmp272;
	rmlA0 = RML_REFSTRINGLIT(lit13);
	rmlFC = tmp163;
	rmlSC = RML_OFFSET(tmp356, -7);
	rmlSP = RML_OFFSET(tmp356, -7);
	RML_TAILCALLQ(RML__debug_5fpush_5fout01,2);}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Types_2dsclam286)
{

	{ void *tmp360 = rmlSC;
	{ void *tmp164 = RML_FETCH(RML_OFFSET(tmp360, 1));
	{ void *tmp167 = RML_FETCH(RML_OFFSET(tmp360, 2));
	{ void *tmp166 = RML_FETCH(RML_OFFSET(tmp360, 3));
	{ void *tmp165 = RML_FETCH(RML_OFFSET(tmp360, 4));
	{ void *tmp272 = RML_FETCH(RML_OFFSET(tmp360, 5));
	{ void *tmp163 = RML_FETCH(RML_OFFSET(tmp360, 6));
	{ void *tmp359 = RML_OFFSET(tmp360, 7);
	RML_STORE(RML_OFFSET(tmp359, -1), tmp163);
	RML_STORE(RML_OFFSET(tmp359, -2), tmp272);
	RML_STORE(RML_OFFSET(tmp359, -3), tmp165);
	RML_STORE(RML_OFFSET(tmp359, -4), tmp166);
	RML_STORE(RML_OFFSET(tmp359, -5), tmp167);
	RML_STORE(RML_OFFSET(tmp359, -6), tmp164);
	RML_STORE(RML_OFFSET(tmp359, -7), RML_LABVAL(Types_2dsclam285));
	rmlA6 = RML_REFSTRINGLIT(lit14);
	rmlA5 = RML_REFSTRINGLIT(lit11);
	rmlA4 = RML_IMMEDIATE(RML_TAGFIXNUM(31));
	rmlA3 = RML_IMMEDIATE(RML_TAGFIXNUM(20));
	rmlA2 = RML_IMMEDIATE(RML_TAGFIXNUM(22));
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(20));
	rmlA0 = RML_REFSTRINGLIT(lit3);
	rmlFC = tmp163;
	rmlSC = RML_OFFSET(tmp359, -7);
	rmlSP = RML_OFFSET(tmp359, -7);
	RML_TAILCALLQ(RML__debug,7);}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Types_2dsclam285)
{

	{ void *tmp363 = rmlSC;
	{ void *tmp164 = RML_FETCH(RML_OFFSET(tmp363, 1));
	{ void *tmp167 = RML_FETCH(RML_OFFSET(tmp363, 2));
	{ void *tmp166 = RML_FETCH(RML_OFFSET(tmp363, 3));
	{ void *tmp165 = RML_FETCH(RML_OFFSET(tmp363, 4));
	{ void *tmp272 = RML_FETCH(RML_OFFSET(tmp363, 5));
	{ void *tmp163 = RML_FETCH(RML_OFFSET(tmp363, 6));
	{ void *tmp362 = RML_OFFSET(tmp363, 7);
	RML_STORE(RML_OFFSET(tmp362, -1), tmp272);
	RML_STORE(RML_OFFSET(tmp362, -2), tmp165);
	RML_STORE(RML_OFFSET(tmp362, -3), tmp166);
	RML_STORE(RML_OFFSET(tmp362, -4), tmp167);
	RML_STORE(RML_OFFSET(tmp362, -5), tmp164);
	RML_STORE(RML_OFFSET(tmp362, -6), RML_LABVAL(Types_2dsclam284));
	rmlFC = tmp163;
	rmlSC = RML_OFFSET(tmp362, -6);
	rmlSP = RML_OFFSET(tmp362, -6);
	RML_TAILCALLQ(RML__lvar_5fnew,0);}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Types_2dsclam284)
{
	void *tmp364;
	RML_ALLOC(tmp364,6,1,Types_2dsclam284);
	{ void *tmp366 = rmlSC;
	{ void *tmp164 = RML_FETCH(RML_OFFSET(tmp366, 1));
	{ void *tmp167 = RML_FETCH(RML_OFFSET(tmp366, 2));
	{ void *tmp166 = RML_FETCH(RML_OFFSET(tmp366, 3));
	{ void *tmp165 = RML_FETCH(RML_OFFSET(tmp366, 4));
	{ void *tmp272 = RML_FETCH(RML_OFFSET(tmp366, 5));
	{ void *tmp365 = RML_OFFSET(tmp366, 6);
	{ void *tmp279 = rmlA0;
	RML_STORE(tmp364, RML_IMMEDIATE(RML_STRUCTHDR(5,0)));
	RML_STORE(RML_OFFSET(tmp364, 1), tmp272);
	RML_STORE(RML_OFFSET(tmp364, 2), tmp165);
	RML_STORE(RML_OFFSET(tmp364, 3), tmp166);
	RML_STORE(RML_OFFSET(tmp364, 4), tmp167);
	RML_STORE(RML_OFFSET(tmp364, 5), tmp279);
	{ void *tmp283 = RML_TAGPTR(tmp364);
	rmlA0 = tmp283;
	rmlSC = tmp164;
	rmlSP = tmp365;
	RML_TAILCALL(RML_FETCH(tmp164),1);}}}}}}}}}
}
RML_END_LABEL

RML_BEGIN_LABEL(Types__mkFreeAlpha)
{

	{ void *tmp176 = rmlSC;
	{ void *tmp175 = rmlFC;
	{ void *tmp337 = rmlSP;
	{ void *tmp177 = rmlA0;
	RML_STORE(RML_OFFSET(tmp337, -1), tmp175);
	RML_STORE(RML_OFFSET(tmp337, -2), tmp177);
	RML_STORE(RML_OFFSET(tmp337, -3), tmp176);
	RML_STORE(RML_OFFSET(tmp337, -4), RML_LABVAL(Types_2dsclam303));
	rmlA5 = RML_REFSTRUCTLIT(lit8);
	rmlA4 = RML_REFSTRINGLIT(lit7);
	rmlA3 = RML_IMMEDIATE(RML_TAGFIXNUM(0));
	rmlA2 = RML_REFSTRINGLIT(lit1);
	rmlA1 = tmp177;
	rmlA0 = RML_REFSTRINGLIT(lit0);
	rmlSC = RML_OFFSET(tmp337, -4);
	rmlSP = RML_OFFSET(tmp337, -4);
	RML_TAILCALLQ(RML__debug_5fpush_5fin03,6);}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Types_2dsclam303)
{

	{ void *tmp340 = rmlSC;
	{ void *tmp176 = RML_FETCH(RML_OFFSET(tmp340, 1));
	{ void *tmp177 = RML_FETCH(RML_OFFSET(tmp340, 2));
	{ void *tmp175 = RML_FETCH(RML_OFFSET(tmp340, 3));
	{ void *tmp339 = RML_OFFSET(tmp340, 4);
	RML_STORE(RML_OFFSET(tmp339, -1), tmp177);
	RML_STORE(RML_OFFSET(tmp339, -2), tmp175);
	RML_STORE(RML_OFFSET(tmp339, -3), tmp176);
	RML_STORE(RML_OFFSET(tmp339, -4), RML_LABVAL(Types_2dsclam302));
	rmlA6 = RML_REFSTRINGLIT(lit10);
	rmlA5 = RML_REFSTRINGLIT(lit9);
	rmlA4 = RML_IMMEDIATE(RML_TAGFIXNUM(32));
	rmlA3 = RML_IMMEDIATE(RML_TAGFIXNUM(26));
	rmlA2 = RML_IMMEDIATE(RML_TAGFIXNUM(8));
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(26));
	rmlA0 = RML_REFSTRINGLIT(lit3);
	rmlFC = tmp175;
	rmlSC = RML_OFFSET(tmp339, -4);
	rmlSP = RML_OFFSET(tmp339, -4);
	RML_TAILCALLQ(RML__debug,7);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Types_2dsclam302)
{

	{ void *tmp343 = rmlSC;
	{ void *tmp176 = RML_FETCH(RML_OFFSET(tmp343, 1));
	{ void *tmp175 = RML_FETCH(RML_OFFSET(tmp343, 2));
	{ void *tmp177 = RML_FETCH(RML_OFFSET(tmp343, 3));
	{ void *tmp342 = RML_OFFSET(tmp343, 4);
	RML_STORE(RML_OFFSET(tmp342, -1), tmp175);
	RML_STORE(RML_OFFSET(tmp342, -2), tmp176);
	RML_STORE(RML_OFFSET(tmp342, -3), RML_LABVAL(Types_2dsclam301));
	rmlA2 = RML_REFSTRUCTLIT(lit8);
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(0));
	rmlA0 = tmp177;
	rmlFC = tmp175;
	rmlSC = RML_OFFSET(tmp342, -3);
	rmlSP = RML_OFFSET(tmp342, -3);
	RML_TAILCALLQ(Types__mkAlpha,3);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Types_2dsclam301)
{

	{ void *tmp346 = rmlSC;
	{ void *tmp176 = RML_FETCH(RML_OFFSET(tmp346, 1));
	{ void *tmp175 = RML_FETCH(RML_OFFSET(tmp346, 2));
	{ void *tmp345 = RML_OFFSET(tmp346, 3);
	{ void *tmp295 = rmlA0;
	RML_STORE(RML_OFFSET(tmp345, -1), tmp176);
	RML_STORE(RML_OFFSET(tmp345, -2), tmp295);
	RML_STORE(RML_OFFSET(tmp345, -3), RML_LABVAL(Types_2dsclam300));
	rmlA1 = tmp295;
	rmlA0 = RML_REFSTRINGLIT(lit6);
	rmlFC = tmp175;
	rmlSC = RML_OFFSET(tmp345, -3);
	rmlSP = RML_OFFSET(tmp345, -3);
	RML_TAILCALLQ(RML__debug_5fpush_5fout01,2);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Types_2dsclam300)
{

	{ void *tmp349 = rmlSC;
	{ void *tmp295 = RML_FETCH(RML_OFFSET(tmp349, 1));
	{ void *tmp176 = RML_FETCH(RML_OFFSET(tmp349, 2));
	{ void *tmp348 = RML_OFFSET(tmp349, 3);
	rmlA0 = tmp295;
	rmlSC = tmp176;
	rmlSP = tmp348;
	RML_TAILCALL(RML_FETCH(tmp176),1);}}}}
}
RML_END_LABEL

RML_BEGIN_LABEL(Types__mkOvldAlpha)
{
	void *tmp322;
	RML_ALLOC(tmp322,2,2,Types__mkOvldAlpha);
	{ void *tmp169 = rmlSC;
	{ void *tmp168 = rmlFC;
	{ void *tmp323 = rmlSP;
	{ void *tmp170 = rmlA0;
	{ void *tmp171 = rmlA1;
	RML_STORE(tmp322, RML_IMMEDIATE(RML_STRUCTHDR(1,1)));
	RML_STORE(RML_OFFSET(tmp322, 1), tmp170);
	{ void *tmp308 = RML_TAGPTR(tmp322);
	RML_STORE(RML_OFFSET(tmp323, -1), tmp168);
	RML_STORE(RML_OFFSET(tmp323, -2), tmp170);
	RML_STORE(RML_OFFSET(tmp323, -3), tmp171);
	RML_STORE(RML_OFFSET(tmp323, -4), tmp169);
	RML_STORE(RML_OFFSET(tmp323, -5), RML_LABVAL(Types_2dsclam321));
	rmlA5 = tmp308;
	rmlA4 = RML_REFSTRINGLIT(lit2);
	rmlA3 = RML_IMMEDIATE(RML_TAGFIXNUM(0));
	rmlA2 = RML_REFSTRINGLIT(lit1);
	rmlA0 = RML_REFSTRINGLIT(lit0);
	rmlSC = RML_OFFSET(tmp323, -5);
	rmlSP = RML_OFFSET(tmp323, -5);
	RML_TAILCALLQ(RML__debug_5fpush_5fin03,6);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Types_2dsclam321)
{

	{ void *tmp326 = rmlSC;
	{ void *tmp169 = RML_FETCH(RML_OFFSET(tmp326, 1));
	{ void *tmp171 = RML_FETCH(RML_OFFSET(tmp326, 2));
	{ void *tmp170 = RML_FETCH(RML_OFFSET(tmp326, 3));
	{ void *tmp168 = RML_FETCH(RML_OFFSET(tmp326, 4));
	{ void *tmp325 = RML_OFFSET(tmp326, 5);
	RML_STORE(RML_OFFSET(tmp325, -1), tmp170);
	RML_STORE(RML_OFFSET(tmp325, -2), tmp171);
	RML_STORE(RML_OFFSET(tmp325, -3), tmp168);
	RML_STORE(RML_OFFSET(tmp325, -4), tmp169);
	RML_STORE(RML_OFFSET(tmp325, -5), RML_LABVAL(Types_2dsclam320));
	rmlA6 = RML_REFSTRINGLIT(lit5);
	rmlA5 = RML_REFSTRINGLIT(lit4);
	rmlA4 = RML_IMMEDIATE(RML_TAGFIXNUM(37));
	rmlA3 = RML_IMMEDIATE(RML_TAGFIXNUM(38));
	rmlA2 = RML_IMMEDIATE(RML_TAGFIXNUM(8));
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(38));
	rmlA0 = RML_REFSTRINGLIT(lit3);
	rmlFC = tmp168;
	rmlSC = RML_OFFSET(tmp325, -5);
	rmlSP = RML_OFFSET(tmp325, -5);
	RML_TAILCALLQ(RML__debug,7);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Types_2dsclam320)
{
	void *tmp327;
	RML_ALLOC(tmp327,2,0,Types_2dsclam320);
	{ void *tmp329 = rmlSC;
	{ void *tmp169 = RML_FETCH(RML_OFFSET(tmp329, 1));
	{ void *tmp168 = RML_FETCH(RML_OFFSET(tmp329, 2));
	{ void *tmp171 = RML_FETCH(RML_OFFSET(tmp329, 3));
	{ void *tmp170 = RML_FETCH(RML_OFFSET(tmp329, 4));
	{ void *tmp328 = RML_OFFSET(tmp329, 5);
	RML_STORE(tmp327, RML_IMMEDIATE(RML_STRUCTHDR(1,1)));
	RML_STORE(RML_OFFSET(tmp327, 1), tmp170);
	{ void *tmp311 = RML_TAGPTR(tmp327);
	RML_STORE(RML_OFFSET(tmp328, -1), tmp168);
	RML_STORE(RML_OFFSET(tmp328, -2), tmp169);
	RML_STORE(RML_OFFSET(tmp328, -3), RML_LABVAL(Types_2dsclam319));
	rmlA2 = tmp311;
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(0));
	rmlA0 = tmp171;
	rmlFC = tmp168;
	rmlSC = RML_OFFSET(tmp328, -3);
	rmlSP = RML_OFFSET(tmp328, -3);
	RML_TAILCALLQ(Types__mkAlpha,3);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Types_2dsclam319)
{

	{ void *tmp332 = rmlSC;
	{ void *tmp169 = RML_FETCH(RML_OFFSET(tmp332, 1));
	{ void *tmp168 = RML_FETCH(RML_OFFSET(tmp332, 2));
	{ void *tmp331 = RML_OFFSET(tmp332, 3);
	{ void *tmp313 = rmlA0;
	RML_STORE(RML_OFFSET(tmp331, -1), tmp169);
	RML_STORE(RML_OFFSET(tmp331, -2), tmp313);
	RML_STORE(RML_OFFSET(tmp331, -3), RML_LABVAL(Types_2dsclam318));
	rmlA1 = tmp313;
	rmlA0 = RML_REFSTRINGLIT(lit6);
	rmlFC = tmp168;
	rmlSC = RML_OFFSET(tmp331, -3);
	rmlSP = RML_OFFSET(tmp331, -3);
	RML_TAILCALLQ(RML__debug_5fpush_5fout01,2);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Types_2dsclam318)
{

	{ void *tmp335 = rmlSC;
	{ void *tmp313 = RML_FETCH(RML_OFFSET(tmp335, 1));
	{ void *tmp169 = RML_FETCH(RML_OFFSET(tmp335, 2));
	{ void *tmp334 = RML_OFFSET(tmp335, 3);
	rmlA0 = tmp313;
	rmlSC = tmp169;
	rmlSP = tmp334;
	RML_TAILCALL(RML_FETCH(tmp169),1);}}}}
}
RML_END_LABEL
