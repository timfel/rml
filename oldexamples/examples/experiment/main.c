/* module Main */
#include "rml.h"
#include <stdlib.h>
#include <stdio.h>
RML_DEFINE_MODULE("Main")
extern RML_FORWARD_LABEL(RML__array_5flength);
extern RML_FORWARD_LABEL(RML__int_5freal);
extern RML_FORWARD_LABEL(RML__array_5fnth);
extern RML_FORWARD_LABEL(RML__debug_5fprint);
extern RML_FORWARD_LABEL(RML__array_5fvector);
extern RML_FORWARD_LABEL(RML__array_5fcreate);
extern RML_FORWARD_LABEL(RML__list_5farray);
extern RML_FORWARD_LABEL(RML__array_5fupdate);
extern RML_FORWARD_LABEL(RML__array_5fsetnth);
extern RML_FORWARD_LABEL(RML__array_5fadd);

RML_FORWARD_LABEL(Main__main);
static RML_FORWARD_LABEL(Main_2dsclam418);
static RML_FORWARD_LABEL(Main_2dsclam417);
static RML_FORWARD_LABEL(Main_2dsclam416);
RML_FORWARD_LABEL(Main__print_5farray);
static RML_FORWARD_LABEL(Main__print_5fa);
static RML_FORWARD_LABEL(Main_2dsclam453);
static RML_FORWARD_LABEL(Main_2dsclam451);
static RML_FORWARD_LABEL(Main_2dsclam450);
static RML_FORWARD_LABEL(Main_2dfclam425);
static RML_FORWARD_LABEL(Main__loop);
static RML_FORWARD_LABEL(Main_2dsclam380);
static RML_FORWARD_LABEL(Main_2dsclam379);
static RML_FORWARD_LABEL(Main_2dsclam378);
static RML_FORWARD_LABEL(Main_2dsclam377);
static RML_FORWARD_LABEL(Main_2dsclam331);
static RML_FORWARD_LABEL(Main_2dsclam330);
static RML_FORWARD_LABEL(Main_2dsclam329);
static RML_FORWARD_LABEL(Main_2dsclam328);
static RML_FORWARD_LABEL(Main_2dsclam327);
static RML_FORWARD_LABEL(Main_2dsclam326);
static RML_FORWARD_LABEL(Main_2dsclam325);
static RML_FORWARD_LABEL(Main_2dsclam324);
static RML_FORWARD_LABEL(Main_2dsclam323);
static RML_FORWARD_LABEL(Main_2dfclam345);

static const RML_DEFSTRUCT0LIT(lit0,0);
static const RML_DEFSTRINGLIT(lit1,5,"\nset:");
static const RML_DEFREALLIT(lit2,10.0);
static const RML_DEFSTRUCTLIT(lit3,2,1) {RML_REFREALLIT(lit2),RML_REFSTRUCTLIT(lit0)}};
static const RML_DEFREALLIT(lit4,1.0);
static const RML_DEFREALLIT(lit5,10.1);
static const RML_DEFSTRUCTLIT(lit6,2,1) {RML_REFREALLIT(lit5),RML_REFSTRUCTLIT(lit0)}};
static const RML_DEFSTRUCTLIT(lit7,2,1) {RML_REFREALLIT(lit4),RML_REFSTRUCTLIT(lit6)}};
static const RML_DEFREALLIT(lit8,2.0);
static const RML_DEFSTRUCTLIT(lit9,2,1) {RML_REFREALLIT(lit8),RML_REFSTRUCTLIT(lit0)}};
static const RML_DEFREALLIT(lit10,3.0);
static const RML_DEFSTRUCTLIT(lit11,2,1) {RML_REFREALLIT(lit10),RML_REFSTRUCTLIT(lit0)}};
static const RML_DEFSTRUCTLIT(lit12,2,1) {RML_REFSTRUCTLIT(lit11),RML_REFSTRUCTLIT(lit0)}};
static const RML_DEFSTRUCTLIT(lit13,2,1) {RML_REFSTRUCTLIT(lit9),RML_REFSTRUCTLIT(lit12)}};
static const RML_DEFSTRUCTLIT(lit14,2,1) {RML_REFSTRUCTLIT(lit7),RML_REFSTRUCTLIT(lit13)}};
static const RML_DEFSTRINGLIT(lit15,2,"el");

extern void RML_5finit(void);

void Main_5finit(void)
{
	static int done = 0;
	if( done ) return;
	done = 1;
	RML_5finit();
}

RML_BEGIN_LABEL(Main__main)
{
	{ void *tmp237 = rmlSC;
	{ void *tmp236 = rmlFC;
	{ void *tmp588 = rmlSP;
	RML_STORE(RML_OFFSET(tmp588, -1), tmp236);
	RML_STORE(RML_OFFSET(tmp588, -2), tmp237);
	RML_STORE(RML_OFFSET(tmp588, -3), RML_LABVAL(Main_2dsclam418));
	rmlA1 = RML_REFSTRUCTLIT(lit3);
	rmlA0 = RML_IMMEDIATE(RML_TAGFIXNUM(20));
	rmlSC = RML_OFFSET(tmp588, -3);
	rmlSP = RML_OFFSET(tmp588, -3);
	RML_TAILCALLQ(RML__array_5fcreate,2);}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam418)
{
	{ void *tmp591 = rmlSC;
	{ void *tmp237 = RML_FETCH(RML_OFFSET(tmp591, 1));
	{ void *tmp236 = RML_FETCH(RML_OFFSET(tmp591, 2));
	{ void *tmp590 = RML_OFFSET(tmp591, 3);
	RML_STORE(RML_OFFSET(tmp590, -1), tmp236);
	RML_STORE(RML_OFFSET(tmp590, -2), tmp237);
	RML_STORE(RML_OFFSET(tmp590, -3), RML_LABVAL(Main_2dsclam417));
	rmlA2 = RML_REFSTRUCTLIT(lit3);
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(1));
	rmlFC = tmp236;
	rmlSC = RML_OFFSET(tmp590, -3);
	rmlSP = RML_OFFSET(tmp590, -3);
	RML_TAILCALLQ(RML__array_5fsetnth,3);}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam417)
{
	{ void *tmp594 = rmlSC;
	{ void *tmp237 = RML_FETCH(RML_OFFSET(tmp594, 1));
	{ void *tmp236 = RML_FETCH(RML_OFFSET(tmp594, 2));
	{ void *tmp593 = RML_OFFSET(tmp594, 3);
	{ void *tmp400 = rmlA0;
	RML_STORE(RML_OFFSET(tmp593, -1), tmp400);
	RML_STORE(RML_OFFSET(tmp593, -2), tmp236);
	RML_STORE(RML_OFFSET(tmp593, -3), tmp237);
	RML_STORE(RML_OFFSET(tmp593, -4), RML_LABVAL(Main_2dsclam416));
	rmlFC = tmp236;
	rmlSC = RML_OFFSET(tmp593, -4);
	rmlSP = RML_OFFSET(tmp593, -4);
	RML_TAILCALLQ(Main__print_5farray,1);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam416)
{
	{ void *tmp597 = rmlSC;
	{ void *tmp237 = RML_FETCH(RML_OFFSET(tmp597, 1));
	{ void *tmp236 = RML_FETCH(RML_OFFSET(tmp597, 2));
	{ void *tmp400 = RML_FETCH(RML_OFFSET(tmp597, 3));
	{ void *tmp596 = RML_OFFSET(tmp597, 4);
	rmlA2 = tmp400;
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(20));
	rmlA0 = RML_IMMEDIATE(RML_TAGFIXNUM(0));
	rmlFC = tmp236;
	rmlSC = tmp237;
	rmlSP = tmp596;
	RML_TAILCALLQ(Main__loop,3);}}}}}
}
RML_END_LABEL

RML_BEGIN_LABEL(Main__print_5farray)
{
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(0));
	RML_TAILCALLQ(Main__print_5fa,2);
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main__print_5fa)
{
	{ void *tmp230 = rmlSC;
	{ void *tmp572 = rmlSP;
	{ void *tmp231 = rmlA0;
	{ void *tmp232 = rmlA1;
	{ void *tmp423 = rml_prim_marker();
	RML_STORE(RML_OFFSET(tmp572, -1), tmp423);
	RML_STORE(RML_OFFSET(tmp572, -2), tmp230);
	RML_STORE(RML_OFFSET(tmp572, -3), RML_LABVAL(Main_2dfclam425));
	{ void *tmp424 = RML_OFFSET(tmp572, -3);
	RML_STORE(RML_OFFSET(tmp572, -4), tmp232);
	RML_STORE(RML_OFFSET(tmp572, -5), tmp231);
	RML_STORE(RML_OFFSET(tmp572, -6), tmp424);
	RML_STORE(RML_OFFSET(tmp572, -7), tmp230);
	RML_STORE(RML_OFFSET(tmp572, -8), RML_LABVAL(Main_2dsclam453));
	rmlFC = tmp424;
	rmlSC = RML_OFFSET(tmp572, -8);
	rmlSP = RML_OFFSET(tmp572, -8);
	RML_TAILCALLQ(RML__array_5flength,1);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam453)
{
	{ void *tmp578 = rmlSC;
	{ void *tmp230 = RML_FETCH(RML_OFFSET(tmp578, 1));
	{ void *tmp424 = RML_FETCH(RML_OFFSET(tmp578, 2));
	{ void *tmp231 = RML_FETCH(RML_OFFSET(tmp578, 3));
	{ void *tmp232 = RML_FETCH(RML_OFFSET(tmp578, 4));
	{ void *tmp577 = RML_OFFSET(tmp578, 5);
	{ void *tmp427 = rmlA0;
	{ void *tmp526 = RML_PRIM_INT_LT(tmp232, tmp427);
	switch( (rml_sint_t)tmp526 ) {
	case RML_TAGFIXNUM(1):
	RML_STORE(RML_OFFSET(tmp577, -1), tmp424);
	RML_STORE(RML_OFFSET(tmp577, -2), tmp232);
	RML_STORE(RML_OFFSET(tmp577, -3), tmp231);
	RML_STORE(RML_OFFSET(tmp577, -4), tmp230);
	RML_STORE(RML_OFFSET(tmp577, -5), RML_LABVAL(Main_2dsclam451));
	rmlA1 = tmp232;
	rmlA0 = tmp231;
	rmlFC = tmp424;
	rmlSC = RML_OFFSET(tmp577, -5);
	rmlSP = RML_OFFSET(tmp577, -5);
	RML_TAILCALLQ(RML__array_5fnth,2);
	default:
	rmlFC = tmp424;
	rmlSP = tmp577;
	RML_TAILCALL(RML_FETCH(tmp424),0);
	}}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam451)
{
	{ void *tmp581 = rmlSC;
	{ void *tmp230 = RML_FETCH(RML_OFFSET(tmp581, 1));
	{ void *tmp231 = RML_FETCH(RML_OFFSET(tmp581, 2));
	{ void *tmp232 = RML_FETCH(RML_OFFSET(tmp581, 3));
	{ void *tmp424 = RML_FETCH(RML_OFFSET(tmp581, 4));
	{ void *tmp580 = RML_OFFSET(tmp581, 5);
	{ void *tmp437 = rmlA0;
	RML_STORE(RML_OFFSET(tmp580, -1), tmp232);
	RML_STORE(RML_OFFSET(tmp580, -2), tmp231);
	RML_STORE(RML_OFFSET(tmp580, -3), tmp424);
	RML_STORE(RML_OFFSET(tmp580, -4), tmp230);
	RML_STORE(RML_OFFSET(tmp580, -5), RML_LABVAL(Main_2dsclam450));
	rmlA1 = tmp437;
	rmlA0 = RML_REFSTRINGLIT(lit15);
	rmlFC = tmp424;
	rmlSC = RML_OFFSET(tmp580, -5);
	rmlSP = RML_OFFSET(tmp580, -5);
	RML_TAILCALLQ(RML__debug_5fprint,2);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam450)
{
	{ void *tmp584 = rmlSC;
	{ void *tmp230 = RML_FETCH(RML_OFFSET(tmp584, 1));
	{ void *tmp424 = RML_FETCH(RML_OFFSET(tmp584, 2));
	{ void *tmp231 = RML_FETCH(RML_OFFSET(tmp584, 3));
	{ void *tmp232 = RML_FETCH(RML_OFFSET(tmp584, 4));
	{ void *tmp583 = RML_OFFSET(tmp584, 5);
	{ void *tmp523 = RML_PRIM_INT_ADD(tmp232, RML_IMMEDIATE(RML_TAGFIXNUM(1)));
	rmlA1 = tmp523;
	rmlA0 = tmp231;
	rmlFC = tmp424;
	rmlSC = tmp230;
	rmlSP = tmp583;
	RML_TAILCALLQ(Main__print_5fa,2);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dfclam425)
{
	{ void *tmp575 = rmlFC;
	{ void *tmp230 = RML_FETCH(RML_OFFSET(tmp575, 1));
	{ void *tmp423 = RML_FETCH(RML_OFFSET(tmp575, 2));
	{ void *tmp574 = RML_OFFSET(tmp575, 3);
	rml_prim_unwind(tmp423);
	rmlSC = tmp230;
	rmlSP = tmp574;
	RML_TAILCALL(RML_FETCH(tmp230),0);}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main__loop)
{
	{ void *tmp225 = rmlSC;
	{ void *tmp224 = rmlFC;
	{ void *tmp528 = rmlSP;
	{ void *tmp226 = rmlA0;
	{ void *tmp227 = rmlA1;
	{ void *tmp228 = rmlA2;
	{ void *tmp337 = rml_prim_marker();
	RML_STORE(RML_OFFSET(tmp528, -1), tmp337);
	RML_STORE(RML_OFFSET(tmp528, -2), tmp226);
	RML_STORE(RML_OFFSET(tmp528, -3), tmp227);
	RML_STORE(RML_OFFSET(tmp528, -4), tmp225);
	RML_STORE(RML_OFFSET(tmp528, -5), tmp224);
	RML_STORE(RML_OFFSET(tmp528, -6), RML_LABVAL(Main_2dfclam345));
	{ void *tmp338 = RML_OFFSET(tmp528, -6);
	{ void *tmp520 = RML_PRIM_INT_LT(tmp226, tmp227);
	switch( (rml_sint_t)tmp520 ) {
	case RML_TAGFIXNUM(1):
	{ void *tmp517 = RML_PRIM_INT_ADD(tmp226, RML_IMMEDIATE(RML_TAGFIXNUM(1)));
	RML_STORE(RML_OFFSET(tmp528, -7), tmp228);
	RML_STORE(RML_OFFSET(tmp528, -8), tmp517);
	RML_STORE(RML_OFFSET(tmp528, -9), tmp338);
	RML_STORE(RML_OFFSET(tmp528, -10), tmp226);
	RML_STORE(RML_OFFSET(tmp528, -11), tmp227);
	RML_STORE(RML_OFFSET(tmp528, -12), tmp225);
	RML_STORE(RML_OFFSET(tmp528, -13), RML_LABVAL(Main_2dsclam380));
	rmlA0 = tmp517;
	rmlFC = tmp338;
	rmlSC = RML_OFFSET(tmp528, -13);
	rmlSP = RML_OFFSET(tmp528, -13);
	RML_TAILCALLQ(RML__int_5freal,1);}
	default:
	rmlFC = tmp338;
	rmlSP = RML_OFFSET(tmp528, -6);
	RML_TAILCALL(RML_FETCH(tmp338),0);
	}}}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam380)
{	void *tmp532;
	RML_ALLOC(tmp532,3,1,Main_2dsclam380);
	{ void *tmp534 = rmlSC;
	{ void *tmp225 = RML_FETCH(RML_OFFSET(tmp534, 1));
	{ void *tmp227 = RML_FETCH(RML_OFFSET(tmp534, 2));
	{ void *tmp226 = RML_FETCH(RML_OFFSET(tmp534, 3));
	{ void *tmp338 = RML_FETCH(RML_OFFSET(tmp534, 4));
	{ void *tmp517 = RML_FETCH(RML_OFFSET(tmp534, 5));
	{ void *tmp228 = RML_FETCH(RML_OFFSET(tmp534, 6));
	{ void *tmp533 = RML_OFFSET(tmp534, 7);
	{ void *tmp357 = rmlA0;
	RML_STORE(tmp532, RML_IMMEDIATE(RML_STRUCTHDR(2,1)));
	RML_STORE(RML_OFFSET(tmp532, 1), tmp357);
	RML_STORE(RML_OFFSET(tmp532, 2), RML_REFSTRUCTLIT(lit0));
	{ void *tmp361 = RML_TAGPTR(tmp532);
	RML_STORE(RML_OFFSET(tmp533, -1), tmp226);
	RML_STORE(RML_OFFSET(tmp533, -2), tmp338);
	RML_STORE(RML_OFFSET(tmp533, -3), tmp517);
	RML_STORE(RML_OFFSET(tmp533, -4), tmp227);
	RML_STORE(RML_OFFSET(tmp533, -5), tmp225);
	RML_STORE(RML_OFFSET(tmp533, -6), RML_LABVAL(Main_2dsclam379));
	rmlA2 = tmp361;
	rmlA1 = tmp517;
	rmlA0 = tmp228;
	rmlFC = tmp338;
	rmlSC = RML_OFFSET(tmp533, -6);
	rmlSP = RML_OFFSET(tmp533, -6);
	RML_TAILCALLQ(RML__array_5fupdate,3);}}}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam379)
{
	{ void *tmp537 = rmlSC;
	{ void *tmp225 = RML_FETCH(RML_OFFSET(tmp537, 1));
	{ void *tmp227 = RML_FETCH(RML_OFFSET(tmp537, 2));
	{ void *tmp517 = RML_FETCH(RML_OFFSET(tmp537, 3));
	{ void *tmp338 = RML_FETCH(RML_OFFSET(tmp537, 4));
	{ void *tmp226 = RML_FETCH(RML_OFFSET(tmp537, 5));
	{ void *tmp536 = RML_OFFSET(tmp537, 6);
	{ void *tmp363 = rmlA0;
	RML_STORE(RML_OFFSET(tmp536, -1), tmp338);
	RML_STORE(RML_OFFSET(tmp536, -2), tmp363);
	RML_STORE(RML_OFFSET(tmp536, -3), tmp517);
	RML_STORE(RML_OFFSET(tmp536, -4), tmp227);
	RML_STORE(RML_OFFSET(tmp536, -5), tmp225);
	RML_STORE(RML_OFFSET(tmp536, -6), RML_LABVAL(Main_2dsclam378));
	rmlA1 = tmp226;
	rmlFC = tmp338;
	rmlSC = RML_OFFSET(tmp536, -6);
	rmlSP = RML_OFFSET(tmp536, -6);
	RML_TAILCALLQ(RML__array_5fnth,2);}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam378)
{
	{ void *tmp540 = rmlSC;
	{ void *tmp225 = RML_FETCH(RML_OFFSET(tmp540, 1));
	{ void *tmp227 = RML_FETCH(RML_OFFSET(tmp540, 2));
	{ void *tmp517 = RML_FETCH(RML_OFFSET(tmp540, 3));
	{ void *tmp363 = RML_FETCH(RML_OFFSET(tmp540, 4));
	{ void *tmp338 = RML_FETCH(RML_OFFSET(tmp540, 5));
	{ void *tmp539 = RML_OFFSET(tmp540, 6);
	{ void *tmp368 = rmlA0;
	RML_STORE(RML_OFFSET(tmp539, -1), tmp363);
	RML_STORE(RML_OFFSET(tmp539, -2), tmp338);
	RML_STORE(RML_OFFSET(tmp539, -3), tmp517);
	RML_STORE(RML_OFFSET(tmp539, -4), tmp227);
	RML_STORE(RML_OFFSET(tmp539, -5), tmp225);
	RML_STORE(RML_OFFSET(tmp539, -6), RML_LABVAL(Main_2dsclam377));
	rmlA1 = tmp368;
	rmlA0 = RML_REFSTRINGLIT(lit1);
	rmlFC = tmp338;
	rmlSC = RML_OFFSET(tmp539, -6);
	rmlSP = RML_OFFSET(tmp539, -6);
	RML_TAILCALLQ(RML__debug_5fprint,2);}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam377)
{
	{ void *tmp543 = rmlSC;
	{ void *tmp225 = RML_FETCH(RML_OFFSET(tmp543, 1));
	{ void *tmp227 = RML_FETCH(RML_OFFSET(tmp543, 2));
	{ void *tmp517 = RML_FETCH(RML_OFFSET(tmp543, 3));
	{ void *tmp338 = RML_FETCH(RML_OFFSET(tmp543, 4));
	{ void *tmp363 = RML_FETCH(RML_OFFSET(tmp543, 5));
	{ void *tmp542 = RML_OFFSET(tmp543, 6);
	RML_STORE(RML_OFFSET(tmp542, -1), tmp338);
	RML_STORE(RML_OFFSET(tmp542, -2), tmp517);
	RML_STORE(RML_OFFSET(tmp542, -3), tmp227);
	RML_STORE(RML_OFFSET(tmp542, -4), tmp363);
	RML_STORE(RML_OFFSET(tmp542, -5), tmp225);
	RML_STORE(RML_OFFSET(tmp542, -6), RML_LABVAL(Main_2dsclam331));
	rmlA0 = tmp363;
	rmlFC = tmp338;
	rmlSC = RML_OFFSET(tmp542, -6);
	rmlSP = RML_OFFSET(tmp542, -6);
	RML_TAILCALLQ(RML__array_5fvector,1);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam331)
{
	{ void *tmp546 = rmlSC;
	{ void *tmp225 = RML_FETCH(RML_OFFSET(tmp546, 1));
	{ void *tmp363 = RML_FETCH(RML_OFFSET(tmp546, 2));
	{ void *tmp227 = RML_FETCH(RML_OFFSET(tmp546, 3));
	{ void *tmp517 = RML_FETCH(RML_OFFSET(tmp546, 4));
	{ void *tmp338 = RML_FETCH(RML_OFFSET(tmp546, 5));
	{ void *tmp545 = RML_OFFSET(tmp546, 6);
	RML_STORE(RML_OFFSET(tmp545, -1), tmp338);
	RML_STORE(RML_OFFSET(tmp545, -2), tmp517);
	RML_STORE(RML_OFFSET(tmp545, -3), tmp227);
	RML_STORE(RML_OFFSET(tmp545, -4), tmp363);
	RML_STORE(RML_OFFSET(tmp545, -5), tmp225);
	RML_STORE(RML_OFFSET(tmp545, -6), RML_LABVAL(Main_2dsclam330));
	rmlA1 = RML_REFSTRUCTLIT(lit3);
	rmlA0 = RML_IMMEDIATE(RML_TAGFIXNUM(10));
	rmlFC = tmp338;
	rmlSC = RML_OFFSET(tmp545, -6);
	rmlSP = RML_OFFSET(tmp545, -6);
	RML_TAILCALLQ(RML__array_5fcreate,2);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam330)
{
	{ void *tmp549 = rmlSC;
	{ void *tmp225 = RML_FETCH(RML_OFFSET(tmp549, 1));
	{ void *tmp363 = RML_FETCH(RML_OFFSET(tmp549, 2));
	{ void *tmp227 = RML_FETCH(RML_OFFSET(tmp549, 3));
	{ void *tmp517 = RML_FETCH(RML_OFFSET(tmp549, 4));
	{ void *tmp338 = RML_FETCH(RML_OFFSET(tmp549, 5));
	{ void *tmp548 = RML_OFFSET(tmp549, 6);
	{ void *tmp268 = rmlA0;
	RML_STORE(RML_OFFSET(tmp548, -1), tmp268);
	RML_STORE(RML_OFFSET(tmp548, -2), tmp338);
	RML_STORE(RML_OFFSET(tmp548, -3), tmp517);
	RML_STORE(RML_OFFSET(tmp548, -4), tmp227);
	RML_STORE(RML_OFFSET(tmp548, -5), tmp363);
	RML_STORE(RML_OFFSET(tmp548, -6), tmp225);
	RML_STORE(RML_OFFSET(tmp548, -7), RML_LABVAL(Main_2dsclam329));
	rmlA0 = RML_REFSTRUCTLIT(lit14);
	rmlFC = tmp338;
	rmlSC = RML_OFFSET(tmp548, -7);
	rmlSP = RML_OFFSET(tmp548, -7);
	RML_TAILCALLQ(RML__list_5farray,1);}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam329)
{
	{ void *tmp552 = rmlSC;
	{ void *tmp225 = RML_FETCH(RML_OFFSET(tmp552, 1));
	{ void *tmp363 = RML_FETCH(RML_OFFSET(tmp552, 2));
	{ void *tmp227 = RML_FETCH(RML_OFFSET(tmp552, 3));
	{ void *tmp517 = RML_FETCH(RML_OFFSET(tmp552, 4));
	{ void *tmp338 = RML_FETCH(RML_OFFSET(tmp552, 5));
	{ void *tmp268 = RML_FETCH(RML_OFFSET(tmp552, 6));
	{ void *tmp551 = RML_OFFSET(tmp552, 7);
	{ void *tmp273 = rmlA0;
	RML_STORE(RML_OFFSET(tmp551, -1), tmp273);
	RML_STORE(RML_OFFSET(tmp551, -2), tmp338);
	RML_STORE(RML_OFFSET(tmp551, -3), tmp517);
	RML_STORE(RML_OFFSET(tmp551, -4), tmp227);
	RML_STORE(RML_OFFSET(tmp551, -5), tmp363);
	RML_STORE(RML_OFFSET(tmp551, -6), tmp225);
	RML_STORE(RML_OFFSET(tmp551, -7), RML_LABVAL(Main_2dsclam328));
	rmlA2 = RML_REFSTRUCTLIT(lit11);
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(1));
	rmlA0 = tmp268;
	rmlFC = tmp338;
	rmlSC = RML_OFFSET(tmp551, -7);
	rmlSP = RML_OFFSET(tmp551, -7);
	RML_TAILCALLQ(RML__array_5fsetnth,3);}}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam328)
{
	{ void *tmp555 = rmlSC;
	{ void *tmp225 = RML_FETCH(RML_OFFSET(tmp555, 1));
	{ void *tmp363 = RML_FETCH(RML_OFFSET(tmp555, 2));
	{ void *tmp227 = RML_FETCH(RML_OFFSET(tmp555, 3));
	{ void *tmp517 = RML_FETCH(RML_OFFSET(tmp555, 4));
	{ void *tmp338 = RML_FETCH(RML_OFFSET(tmp555, 5));
	{ void *tmp273 = RML_FETCH(RML_OFFSET(tmp555, 6));
	{ void *tmp554 = RML_OFFSET(tmp555, 7);
	{ void *tmp287 = rmlA0;
	RML_STORE(RML_OFFSET(tmp554, -1), tmp287);
	RML_STORE(RML_OFFSET(tmp554, -2), tmp338);
	RML_STORE(RML_OFFSET(tmp554, -3), tmp517);
	RML_STORE(RML_OFFSET(tmp554, -4), tmp227);
	RML_STORE(RML_OFFSET(tmp554, -5), tmp363);
	RML_STORE(RML_OFFSET(tmp554, -6), tmp225);
	RML_STORE(RML_OFFSET(tmp554, -7), RML_LABVAL(Main_2dsclam327));
	rmlA2 = RML_REFSTRUCTLIT(lit11);
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(1));
	rmlA0 = tmp273;
	rmlFC = tmp338;
	rmlSC = RML_OFFSET(tmp554, -7);
	rmlSP = RML_OFFSET(tmp554, -7);
	RML_TAILCALLQ(RML__array_5fsetnth,3);}}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam327)
{
	{ void *tmp558 = rmlSC;
	{ void *tmp225 = RML_FETCH(RML_OFFSET(tmp558, 1));
	{ void *tmp363 = RML_FETCH(RML_OFFSET(tmp558, 2));
	{ void *tmp227 = RML_FETCH(RML_OFFSET(tmp558, 3));
	{ void *tmp517 = RML_FETCH(RML_OFFSET(tmp558, 4));
	{ void *tmp338 = RML_FETCH(RML_OFFSET(tmp558, 5));
	{ void *tmp287 = RML_FETCH(RML_OFFSET(tmp558, 6));
	{ void *tmp557 = RML_OFFSET(tmp558, 7);
	{ void *tmp292 = rmlA0;
	RML_STORE(RML_OFFSET(tmp557, -1), tmp338);
	RML_STORE(RML_OFFSET(tmp557, -2), tmp292);
	RML_STORE(RML_OFFSET(tmp557, -3), tmp517);
	RML_STORE(RML_OFFSET(tmp557, -4), tmp227);
	RML_STORE(RML_OFFSET(tmp557, -5), tmp363);
	RML_STORE(RML_OFFSET(tmp557, -6), tmp225);
	RML_STORE(RML_OFFSET(tmp557, -7), RML_LABVAL(Main_2dsclam326));
	rmlA2 = RML_REFSTRUCTLIT(lit11);
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(2));
	rmlA0 = tmp287;
	rmlFC = tmp338;
	rmlSC = RML_OFFSET(tmp557, -7);
	rmlSP = RML_OFFSET(tmp557, -7);
	RML_TAILCALLQ(RML__array_5fsetnth,3);}}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam326)
{
	{ void *tmp561 = rmlSC;
	{ void *tmp225 = RML_FETCH(RML_OFFSET(tmp561, 1));
	{ void *tmp363 = RML_FETCH(RML_OFFSET(tmp561, 2));
	{ void *tmp227 = RML_FETCH(RML_OFFSET(tmp561, 3));
	{ void *tmp517 = RML_FETCH(RML_OFFSET(tmp561, 4));
	{ void *tmp292 = RML_FETCH(RML_OFFSET(tmp561, 5));
	{ void *tmp338 = RML_FETCH(RML_OFFSET(tmp561, 6));
	{ void *tmp560 = RML_OFFSET(tmp561, 7);
	RML_STORE(RML_OFFSET(tmp560, -1), tmp292);
	RML_STORE(RML_OFFSET(tmp560, -2), tmp338);
	RML_STORE(RML_OFFSET(tmp560, -3), tmp517);
	RML_STORE(RML_OFFSET(tmp560, -4), tmp227);
	RML_STORE(RML_OFFSET(tmp560, -5), tmp363);
	RML_STORE(RML_OFFSET(tmp560, -6), tmp225);
	RML_STORE(RML_OFFSET(tmp560, -7), RML_LABVAL(Main_2dsclam325));
	rmlA2 = RML_REFSTRUCTLIT(lit11);
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(5));
	rmlFC = tmp338;
	rmlSC = RML_OFFSET(tmp560, -7);
	rmlSP = RML_OFFSET(tmp560, -7);
	RML_TAILCALLQ(RML__array_5fupdate,3);}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam325)
{
	{ void *tmp564 = rmlSC;
	{ void *tmp225 = RML_FETCH(RML_OFFSET(tmp564, 1));
	{ void *tmp363 = RML_FETCH(RML_OFFSET(tmp564, 2));
	{ void *tmp227 = RML_FETCH(RML_OFFSET(tmp564, 3));
	{ void *tmp517 = RML_FETCH(RML_OFFSET(tmp564, 4));
	{ void *tmp338 = RML_FETCH(RML_OFFSET(tmp564, 5));
	{ void *tmp292 = RML_FETCH(RML_OFFSET(tmp564, 6));
	{ void *tmp563 = RML_OFFSET(tmp564, 7);
	{ void *tmp302 = rmlA0;
	RML_STORE(RML_OFFSET(tmp563, -1), tmp302);
	RML_STORE(RML_OFFSET(tmp563, -2), tmp338);
	RML_STORE(RML_OFFSET(tmp563, -3), tmp517);
	RML_STORE(RML_OFFSET(tmp563, -4), tmp227);
	RML_STORE(RML_OFFSET(tmp563, -5), tmp363);
	RML_STORE(RML_OFFSET(tmp563, -6), tmp225);
	RML_STORE(RML_OFFSET(tmp563, -7), RML_LABVAL(Main_2dsclam324));
	rmlA2 = RML_REFSTRUCTLIT(lit11);
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(2));
	rmlA0 = tmp292;
	rmlFC = tmp338;
	rmlSC = RML_OFFSET(tmp563, -7);
	rmlSP = RML_OFFSET(tmp563, -7);
	RML_TAILCALLQ(RML__array_5fsetnth,3);}}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam324)
{
	{ void *tmp567 = rmlSC;
	{ void *tmp225 = RML_FETCH(RML_OFFSET(tmp567, 1));
	{ void *tmp363 = RML_FETCH(RML_OFFSET(tmp567, 2));
	{ void *tmp227 = RML_FETCH(RML_OFFSET(tmp567, 3));
	{ void *tmp517 = RML_FETCH(RML_OFFSET(tmp567, 4));
	{ void *tmp338 = RML_FETCH(RML_OFFSET(tmp567, 5));
	{ void *tmp302 = RML_FETCH(RML_OFFSET(tmp567, 6));
	{ void *tmp566 = RML_OFFSET(tmp567, 7);
	RML_STORE(RML_OFFSET(tmp566, -1), tmp517);
	RML_STORE(RML_OFFSET(tmp566, -2), tmp227);
	RML_STORE(RML_OFFSET(tmp566, -3), tmp363);
	RML_STORE(RML_OFFSET(tmp566, -4), tmp338);
	RML_STORE(RML_OFFSET(tmp566, -5), tmp225);
	RML_STORE(RML_OFFSET(tmp566, -6), RML_LABVAL(Main_2dsclam323));
	rmlA1 = RML_REFSTRUCTLIT(lit11);
	rmlA0 = tmp302;
	rmlFC = tmp338;
	rmlSC = RML_OFFSET(tmp566, -6);
	rmlSP = RML_OFFSET(tmp566, -6);
	RML_TAILCALLQ(RML__array_5fadd,2);}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam323)
{
	{ void *tmp570 = rmlSC;
	{ void *tmp225 = RML_FETCH(RML_OFFSET(tmp570, 1));
	{ void *tmp338 = RML_FETCH(RML_OFFSET(tmp570, 2));
	{ void *tmp363 = RML_FETCH(RML_OFFSET(tmp570, 3));
	{ void *tmp227 = RML_FETCH(RML_OFFSET(tmp570, 4));
	{ void *tmp517 = RML_FETCH(RML_OFFSET(tmp570, 5));
	{ void *tmp569 = RML_OFFSET(tmp570, 6);
	rmlA2 = tmp363;
	rmlA1 = tmp227;
	rmlA0 = tmp517;
	rmlFC = tmp338;
	rmlSC = tmp225;
	rmlSP = tmp569;
	RML_TAILCALLQ(Main__loop,3);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dfclam345)
{
	{ void *tmp531 = rmlFC;
	{ void *tmp224 = RML_FETCH(RML_OFFSET(tmp531, 1));
	{ void *tmp225 = RML_FETCH(RML_OFFSET(tmp531, 2));
	{ void *tmp227 = RML_FETCH(RML_OFFSET(tmp531, 3));
	{ void *tmp226 = RML_FETCH(RML_OFFSET(tmp531, 4));
	{ void *tmp337 = RML_FETCH(RML_OFFSET(tmp531, 5));
	{ void *tmp530 = RML_OFFSET(tmp531, 6);
	rml_prim_unwind(tmp337);
	{ void *tmp514 = RML_PRIM_INT_GE(tmp226, tmp227);
	switch( (rml_sint_t)tmp514 ) {
	case RML_TAGFIXNUM(1):
	rmlSC = tmp225;
	rmlSP = tmp530;
	RML_TAILCALL(RML_FETCH(tmp225),0);
	default:
	rmlFC = tmp224;
	rmlSP = tmp530;
	RML_TAILCALL(RML_FETCH(tmp224),0);
	}}}}}}}}}
}
RML_END_LABEL
