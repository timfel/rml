/* module Emit */
#include "rml.h"
#include <stdlib.h>
#include <stdio.h>
RML_DEFINE_MODULE("Emit")
extern RML_FORWARD_LABEL(RML__int_5fstring);
extern RML_FORWARD_LABEL(RML__print);

RML_FORWARD_LABEL(Emit__emit_5fassembly);
static RML_FORWARD_LABEL(Emit_2dsclam279);
static RML_FORWARD_LABEL(Emit_2dsclam260);
static RML_FORWARD_LABEL(Emit_2dsclam249);
static RML_FORWARD_LABEL(Emit_2dsclam206);
static RML_FORWARD_LABEL(Emit__emit_5fop_5foperand);
static RML_FORWARD_LABEL(Emit_2dsclam325);
static RML_FORWARD_LABEL(Emit_2dsclam324);
static RML_FORWARD_LABEL(Emit_2dsclam323);
static RML_FORWARD_LABEL(Emit_2dsclam322);
static RML_FORWARD_LABEL(Emit__emit_5fmoperand);
static RML_FORWARD_LABEL(Emit_2dsclam308);
static RML_FORWARD_LABEL(Emit_2dsclam303);
static RML_FORWARD_LABEL(Emit__emit_5fint);
static RML_FORWARD_LABEL(Emit_2dsclam191);

static const RML_DEFSTRINGLIT(lit0,1,"T");
static const RML_DEFSTRINGLIT(lit1,1,"L");
static const RML_DEFSTRINGLIT(lit2,1,"	");
static const RML_DEFSTRINGLIT(lit3,1,"\n");
static const RML_DEFSTRINGLIT(lit4,6,"	HALT\n");
static const RML_DEFSTRINGLIT(lit5,2,"JP");
static const RML_DEFSTRINGLIT(lit6,3,"JNZ");
static const RML_DEFSTRINGLIT(lit7,2,"JZ");
static const RML_DEFSTRINGLIT(lit8,3,"JPZ");
static const RML_DEFSTRINGLIT(lit9,2,"JN");
static const RML_DEFSTRINGLIT(lit10,3,"JNP");
static const RML_DEFSTRINGLIT(lit11,4,"LOAD");
static const RML_DEFSTRINGLIT(lit12,3,"GET");
static const RML_DEFSTRINGLIT(lit13,5,"	LAB\n");
static const RML_DEFSTRINGLIT(lit14,3,"PUT");
static const RML_DEFSTRINGLIT(lit15,3,"STO");
static const RML_DEFSTRINGLIT(lit16,1,"J");
static const RML_DEFSTRINGLIT(lit17,3,"SUB");
static const RML_DEFSTRINGLIT(lit18,3,"DIV");
static const RML_DEFSTRINGLIT(lit19,4,"MULT");
static const RML_DEFSTRINGLIT(lit20,3,"ADD");

extern void RML_5finit(void);
extern void Mcode_5finit(void);

void Emit_5finit(void)
{
	static int done = 0;
	if( done ) return;
	done = 1;
	RML_5finit();
	Mcode_5finit();
}

RML_BEGIN_LABEL(Emit__emit_5fassembly)
{

	{ void *tmp179 = rmlSC;
	{ void *tmp178 = rmlFC;
	{ void *tmp368 = rmlSP;
	{ void *tmp180 = rmlA0;
	{ void *tmp200 = RML_FETCH(RML_UNTAGPTR(tmp180));
	switch( (rml_sint_t)tmp200 ) {
	case RML_STRUCTHDR(0,0):
	RML_TAILCALL(RML_FETCH(tmp179),0);
	/*case RML_STRUCTHDR(2,1)*/
	default:
	{ void *tmp201 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp180), 2));
	{ void *tmp202 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp180), 1));
	RML_STORE(RML_OFFSET(tmp368, -1), tmp201);
	RML_STORE(RML_OFFSET(tmp368, -2), tmp178);
	RML_STORE(RML_OFFSET(tmp368, -3), tmp179);
	RML_STORE(RML_OFFSET(tmp368, -4), RML_LABVAL(Emit_2dsclam206));
	{ void *tmp176 = RML_OFFSET(tmp368, -4);
	{ void *tmp237 = RML_FETCH(RML_UNTAGPTR(tmp202));
	switch( RML_HDRCTOR((rml_uint_t)tmp237) ) {
	case 8:
	rmlA0 = RML_REFSTRINGLIT(lit4);
	rmlSC = tmp176;
	rmlSP = RML_OFFSET(tmp368, -4);
	RML_TAILCALLQ(RML__print,1);
	case 1:
	{ void *tmp240 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp202), 2));
	{ void *tmp241 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp202), 1));
	RML_STORE(RML_OFFSET(tmp368, -5), tmp240);
	RML_STORE(RML_OFFSET(tmp368, -6), tmp178);
	RML_STORE(RML_OFFSET(tmp368, -7), tmp176);
	RML_STORE(RML_OFFSET(tmp368, -8), RML_LABVAL(Emit_2dsclam249));
	{ void *tmp160 = RML_OFFSET(tmp368, -8);
	switch( RML_UNTAGFIXNUM(tmp241) ) {
	case 1:
	rmlA0 = RML_REFSTRINGLIT(lit5);
	rmlSC = tmp160;
	rmlSP = RML_OFFSET(tmp368, -8);
	RML_TAILCALL(RML_FETCH(tmp160),1);
	case 3:
	rmlA0 = RML_REFSTRINGLIT(lit6);
	rmlSC = tmp160;
	rmlSP = RML_OFFSET(tmp368, -8);
	RML_TAILCALL(RML_FETCH(tmp160),1);
	case 5:
	rmlA0 = RML_REFSTRINGLIT(lit7);
	rmlSC = tmp160;
	rmlSP = RML_OFFSET(tmp368, -8);
	RML_TAILCALL(RML_FETCH(tmp160),1);
	case 4:
	rmlA0 = RML_REFSTRINGLIT(lit8);
	rmlSC = tmp160;
	rmlSP = RML_OFFSET(tmp368, -8);
	RML_TAILCALL(RML_FETCH(tmp160),1);
	case 2:
	rmlA0 = RML_REFSTRINGLIT(lit9);
	rmlSC = tmp160;
	rmlSP = RML_OFFSET(tmp368, -8);
	RML_TAILCALL(RML_FETCH(tmp160),1);
	/*case 0*/
	default:
	rmlA0 = RML_REFSTRINGLIT(lit10);
	rmlSC = tmp160;
	rmlSP = RML_OFFSET(tmp368, -8);
	RML_TAILCALL(RML_FETCH(tmp160),1);
	}}}}
	case 3:
	{ void *tmp250 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp202), 1));
	rmlA1 = tmp250;
	rmlA0 = RML_REFSTRINGLIT(lit11);
	rmlSC = tmp176;
	rmlSP = RML_OFFSET(tmp368, -4);
	RML_TAILCALLQ(Emit__emit_5fop_5foperand,2);}
	case 5:
	{ void *tmp253 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp202), 1));
	rmlA1 = tmp253;
	rmlA0 = RML_REFSTRINGLIT(lit12);
	rmlSC = tmp176;
	rmlSP = RML_OFFSET(tmp368, -4);
	RML_TAILCALLQ(Emit__emit_5fop_5foperand,2);}
	case 7:
	{ void *tmp256 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp202), 1));
	RML_STORE(RML_OFFSET(tmp368, -5), tmp178);
	RML_STORE(RML_OFFSET(tmp368, -6), tmp176);
	RML_STORE(RML_OFFSET(tmp368, -7), RML_LABVAL(Emit_2dsclam260));
	rmlA0 = tmp256;
	rmlSC = RML_OFFSET(tmp368, -7);
	rmlSP = RML_OFFSET(tmp368, -7);
	RML_TAILCALLQ(Emit__emit_5fmoperand,1);}
	case 6:
	{ void *tmp261 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp202), 1));
	rmlA1 = tmp261;
	rmlA0 = RML_REFSTRINGLIT(lit14);
	rmlSC = tmp176;
	rmlSP = RML_OFFSET(tmp368, -4);
	RML_TAILCALLQ(Emit__emit_5fop_5foperand,2);}
	case 4:
	{ void *tmp264 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp202), 1));
	rmlA1 = tmp264;
	rmlA0 = RML_REFSTRINGLIT(lit15);
	rmlSC = tmp176;
	rmlSP = RML_OFFSET(tmp368, -4);
	RML_TAILCALLQ(Emit__emit_5fop_5foperand,2);}
	case 2:
	{ void *tmp267 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp202), 1));
	rmlA1 = tmp267;
	rmlA0 = RML_REFSTRINGLIT(lit16);
	rmlSC = tmp176;
	rmlSP = RML_OFFSET(tmp368, -4);
	RML_TAILCALLQ(Emit__emit_5fop_5foperand,2);}
	/*case 0*/
	default:
	{ void *tmp270 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp202), 2));
	{ void *tmp271 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp202), 1));
	RML_STORE(RML_OFFSET(tmp368, -5), tmp270);
	RML_STORE(RML_OFFSET(tmp368, -6), tmp178);
	RML_STORE(RML_OFFSET(tmp368, -7), tmp176);
	RML_STORE(RML_OFFSET(tmp368, -8), RML_LABVAL(Emit_2dsclam279));
	{ void *tmp163 = RML_OFFSET(tmp368, -8);
	switch( RML_UNTAGFIXNUM(tmp271) ) {
	case 1:
	rmlA0 = RML_REFSTRINGLIT(lit17);
	rmlSC = tmp163;
	rmlSP = RML_OFFSET(tmp368, -8);
	RML_TAILCALL(RML_FETCH(tmp163),1);
	case 3:
	rmlA0 = RML_REFSTRINGLIT(lit18);
	rmlSC = tmp163;
	rmlSP = RML_OFFSET(tmp368, -8);
	RML_TAILCALL(RML_FETCH(tmp163),1);
	case 2:
	rmlA0 = RML_REFSTRINGLIT(lit19);
	rmlSC = tmp163;
	rmlSP = RML_OFFSET(tmp368, -8);
	RML_TAILCALL(RML_FETCH(tmp163),1);
	/*case 0*/
	default:
	rmlA0 = RML_REFSTRINGLIT(lit20);
	rmlSC = tmp163;
	rmlSP = RML_OFFSET(tmp368, -8);
	RML_TAILCALL(RML_FETCH(tmp163),1);
	}}}}
	}}}}}
	}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Emit_2dsclam279)
{

	{ void *tmp380 = rmlSC;
	{ void *tmp176 = RML_FETCH(RML_OFFSET(tmp380, 1));
	{ void *tmp178 = RML_FETCH(RML_OFFSET(tmp380, 2));
	{ void *tmp270 = RML_FETCH(RML_OFFSET(tmp380, 3));
	{ void *tmp379 = RML_OFFSET(tmp380, 4);
	rmlA1 = tmp270;
	rmlFC = tmp178;
	rmlSC = tmp176;
	rmlSP = tmp379;
	RML_TAILCALLQ(Emit__emit_5fop_5foperand,2);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Emit_2dsclam260)
{

	{ void *tmp377 = rmlSC;
	{ void *tmp176 = RML_FETCH(RML_OFFSET(tmp377, 1));
	{ void *tmp178 = RML_FETCH(RML_OFFSET(tmp377, 2));
	{ void *tmp376 = RML_OFFSET(tmp377, 3);
	rmlA0 = RML_REFSTRINGLIT(lit13);
	rmlFC = tmp178;
	rmlSC = tmp176;
	rmlSP = tmp376;
	RML_TAILCALLQ(RML__print,1);}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Emit_2dsclam249)
{

	{ void *tmp374 = rmlSC;
	{ void *tmp176 = RML_FETCH(RML_OFFSET(tmp374, 1));
	{ void *tmp178 = RML_FETCH(RML_OFFSET(tmp374, 2));
	{ void *tmp240 = RML_FETCH(RML_OFFSET(tmp374, 3));
	{ void *tmp373 = RML_OFFSET(tmp374, 4);
	rmlA1 = tmp240;
	rmlFC = tmp178;
	rmlSC = tmp176;
	rmlSP = tmp373;
	RML_TAILCALLQ(Emit__emit_5fop_5foperand,2);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Emit_2dsclam206)
{

	{ void *tmp371 = rmlSC;
	{ void *tmp179 = RML_FETCH(RML_OFFSET(tmp371, 1));
	{ void *tmp178 = RML_FETCH(RML_OFFSET(tmp371, 2));
	{ void *tmp201 = RML_FETCH(RML_OFFSET(tmp371, 3));
	{ void *tmp370 = RML_OFFSET(tmp371, 4);
	rmlA0 = tmp201;
	rmlFC = tmp178;
	rmlSC = tmp179;
	rmlSP = tmp370;
	RML_TAILCALLQ(Emit__emit_5fassembly,1);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Emit__emit_5fop_5foperand)
{

	{ void *tmp172 = rmlSC;
	{ void *tmp171 = rmlFC;
	{ void *tmp354 = rmlSP;
	{ void *tmp173 = rmlA0;
	{ void *tmp174 = rmlA1;
	RML_STORE(RML_OFFSET(tmp354, -1), tmp173);
	RML_STORE(RML_OFFSET(tmp354, -2), tmp171);
	RML_STORE(RML_OFFSET(tmp354, -3), tmp174);
	RML_STORE(RML_OFFSET(tmp354, -4), tmp172);
	RML_STORE(RML_OFFSET(tmp354, -5), RML_LABVAL(Emit_2dsclam325));
	rmlA0 = RML_REFSTRINGLIT(lit2);
	rmlSC = RML_OFFSET(tmp354, -5);
	rmlSP = RML_OFFSET(tmp354, -5);
	RML_TAILCALLQ(RML__print,1);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Emit_2dsclam325)
{

	{ void *tmp357 = rmlSC;
	{ void *tmp172 = RML_FETCH(RML_OFFSET(tmp357, 1));
	{ void *tmp174 = RML_FETCH(RML_OFFSET(tmp357, 2));
	{ void *tmp171 = RML_FETCH(RML_OFFSET(tmp357, 3));
	{ void *tmp173 = RML_FETCH(RML_OFFSET(tmp357, 4));
	{ void *tmp356 = RML_OFFSET(tmp357, 5);
	RML_STORE(RML_OFFSET(tmp356, -1), tmp171);
	RML_STORE(RML_OFFSET(tmp356, -2), tmp174);
	RML_STORE(RML_OFFSET(tmp356, -3), tmp172);
	RML_STORE(RML_OFFSET(tmp356, -4), RML_LABVAL(Emit_2dsclam324));
	rmlA0 = tmp173;
	rmlFC = tmp171;
	rmlSC = RML_OFFSET(tmp356, -4);
	rmlSP = RML_OFFSET(tmp356, -4);
	RML_TAILCALLQ(RML__print,1);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Emit_2dsclam324)
{

	{ void *tmp360 = rmlSC;
	{ void *tmp172 = RML_FETCH(RML_OFFSET(tmp360, 1));
	{ void *tmp174 = RML_FETCH(RML_OFFSET(tmp360, 2));
	{ void *tmp171 = RML_FETCH(RML_OFFSET(tmp360, 3));
	{ void *tmp359 = RML_OFFSET(tmp360, 4);
	RML_STORE(RML_OFFSET(tmp359, -1), tmp174);
	RML_STORE(RML_OFFSET(tmp359, -2), tmp171);
	RML_STORE(RML_OFFSET(tmp359, -3), tmp172);
	RML_STORE(RML_OFFSET(tmp359, -4), RML_LABVAL(Emit_2dsclam323));
	rmlA0 = RML_REFSTRINGLIT(lit2);
	rmlFC = tmp171;
	rmlSC = RML_OFFSET(tmp359, -4);
	rmlSP = RML_OFFSET(tmp359, -4);
	RML_TAILCALLQ(RML__print,1);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Emit_2dsclam323)
{

	{ void *tmp363 = rmlSC;
	{ void *tmp172 = RML_FETCH(RML_OFFSET(tmp363, 1));
	{ void *tmp171 = RML_FETCH(RML_OFFSET(tmp363, 2));
	{ void *tmp174 = RML_FETCH(RML_OFFSET(tmp363, 3));
	{ void *tmp362 = RML_OFFSET(tmp363, 4);
	RML_STORE(RML_OFFSET(tmp362, -1), tmp171);
	RML_STORE(RML_OFFSET(tmp362, -2), tmp172);
	RML_STORE(RML_OFFSET(tmp362, -3), RML_LABVAL(Emit_2dsclam322));
	rmlA0 = tmp174;
	rmlFC = tmp171;
	rmlSC = RML_OFFSET(tmp362, -3);
	rmlSP = RML_OFFSET(tmp362, -3);
	RML_TAILCALLQ(Emit__emit_5fmoperand,1);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Emit_2dsclam322)
{

	{ void *tmp366 = rmlSC;
	{ void *tmp172 = RML_FETCH(RML_OFFSET(tmp366, 1));
	{ void *tmp171 = RML_FETCH(RML_OFFSET(tmp366, 2));
	{ void *tmp365 = RML_OFFSET(tmp366, 3);
	rmlA0 = RML_REFSTRINGLIT(lit3);
	rmlFC = tmp171;
	rmlSC = tmp172;
	rmlSP = tmp365;
	RML_TAILCALLQ(RML__print,1);}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Emit__emit_5fmoperand)
{

	{ void *tmp169 = rmlSC;
	{ void *tmp168 = rmlFC;
	{ void *tmp346 = rmlSP;
	{ void *tmp170 = rmlA0;
	{ void *tmp295 = RML_FETCH(RML_UNTAGPTR(tmp170));
	switch( RML_HDRCTOR((rml_uint_t)tmp295) ) {
	case 1:
	{ void *tmp296 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp170), 1));
	rmlA0 = tmp296;
	RML_TAILCALLQ(Emit__emit_5fint,1);}
	case 2:
	{ void *tmp299 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp170), 1));
	RML_STORE(RML_OFFSET(tmp346, -1), tmp299);
	RML_STORE(RML_OFFSET(tmp346, -2), tmp168);
	RML_STORE(RML_OFFSET(tmp346, -3), tmp169);
	RML_STORE(RML_OFFSET(tmp346, -4), RML_LABVAL(Emit_2dsclam303));
	rmlA0 = RML_REFSTRINGLIT(lit0);
	rmlSC = RML_OFFSET(tmp346, -4);
	rmlSP = RML_OFFSET(tmp346, -4);
	RML_TAILCALLQ(RML__print,1);}
	case 3:
	{ void *tmp304 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp170), 1));
	RML_STORE(RML_OFFSET(tmp346, -1), tmp304);
	RML_STORE(RML_OFFSET(tmp346, -2), tmp168);
	RML_STORE(RML_OFFSET(tmp346, -3), tmp169);
	RML_STORE(RML_OFFSET(tmp346, -4), RML_LABVAL(Emit_2dsclam308));
	rmlA0 = RML_REFSTRINGLIT(lit1);
	rmlSC = RML_OFFSET(tmp346, -4);
	rmlSP = RML_OFFSET(tmp346, -4);
	RML_TAILCALLQ(RML__print,1);}
	/*case 0*/
	default:
	{ void *tmp309 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp170), 1));
	rmlA0 = tmp309;
	RML_TAILCALLQ(RML__print,1);}
	}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Emit_2dsclam308)
{

	{ void *tmp352 = rmlSC;
	{ void *tmp169 = RML_FETCH(RML_OFFSET(tmp352, 1));
	{ void *tmp168 = RML_FETCH(RML_OFFSET(tmp352, 2));
	{ void *tmp304 = RML_FETCH(RML_OFFSET(tmp352, 3));
	{ void *tmp351 = RML_OFFSET(tmp352, 4);
	rmlA0 = tmp304;
	rmlFC = tmp168;
	rmlSC = tmp169;
	rmlSP = tmp351;
	RML_TAILCALLQ(Emit__emit_5fint,1);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Emit_2dsclam303)
{

	{ void *tmp349 = rmlSC;
	{ void *tmp169 = RML_FETCH(RML_OFFSET(tmp349, 1));
	{ void *tmp168 = RML_FETCH(RML_OFFSET(tmp349, 2));
	{ void *tmp299 = RML_FETCH(RML_OFFSET(tmp349, 3));
	{ void *tmp348 = RML_OFFSET(tmp349, 4);
	rmlA0 = tmp299;
	rmlFC = tmp168;
	rmlSC = tmp169;
	rmlSP = tmp348;
	RML_TAILCALLQ(Emit__emit_5fint,1);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Emit__emit_5fint)
{

	{ void *tmp166 = rmlSC;
	{ void *tmp165 = rmlFC;
	{ void *tmp341 = rmlSP;
	RML_STORE(RML_OFFSET(tmp341, -1), tmp165);
	RML_STORE(RML_OFFSET(tmp341, -2), tmp166);
	RML_STORE(RML_OFFSET(tmp341, -3), RML_LABVAL(Emit_2dsclam191));
	rmlSC = RML_OFFSET(tmp341, -3);
	rmlSP = RML_OFFSET(tmp341, -3);
	RML_TAILCALLQ(RML__int_5fstring,1);}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Emit_2dsclam191)
{

	{ void *tmp344 = rmlSC;
	{ void *tmp166 = RML_FETCH(RML_OFFSET(tmp344, 1));
	{ void *tmp165 = RML_FETCH(RML_OFFSET(tmp344, 2));
	{ void *tmp343 = RML_OFFSET(tmp344, 3);
	rmlFC = tmp165;
	rmlSC = tmp166;
	rmlSP = tmp343;
	RML_TAILCALLQ(RML__print,1);}}}}
}
RML_END_LABEL
