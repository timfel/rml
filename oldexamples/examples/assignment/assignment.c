/* module assignment */
#include "rml.h"
#include <stdlib.h>
#include <stdio.h>
RML_DEFINE_MODULE("assignment")
extern RML_FORWARD_LABEL(RML__list_5freverse);
extern RML_FORWARD_LABEL(RML__int_5fstring);
extern RML_FORWARD_LABEL(RML__print);

RML_FORWARD_LABEL(assignment__evalprogram);
static RML_FORWARD_LABEL(assignment_2dsclam459);
static RML_FORWARD_LABEL(assignment_2dsclam458);
static RML_FORWARD_LABEL(assignment_2dsclam457);
static RML_FORWARD_LABEL(assignment_2dsclam456);
static RML_FORWARD_LABEL(assignment_2dsclam455);
static RML_FORWARD_LABEL(assignment_2dsclam454);
static RML_FORWARD_LABEL(assignment_2dsclam453);
static RML_FORWARD_LABEL(assignment__eval);
static RML_FORWARD_LABEL(assignment_2dsclam424);
static RML_FORWARD_LABEL(assignment_2dsclam408);
static RML_FORWARD_LABEL(assignment_2dsclam392);
static RML_FORWARD_LABEL(assignment_2dsclam391);
static RML_FORWARD_LABEL(assignment_2dsclam390);
static RML_FORWARD_LABEL(assignment_2dsclam538);
static RML_FORWARD_LABEL(assignment_2dfclam532);
static RML_FORWARD_LABEL(assignment_2dsclam367);
static RML_FORWARD_LABEL(assignment_2dsclam366);
static RML_FORWARD_LABEL(assignment_2dsclam365);
static RML_FORWARD_LABEL(assignment_2dsclam364);
static RML_FORWARD_LABEL(assignment_2dsclam363);
static RML_FORWARD_LABEL(assignment__evals);
static RML_FORWARD_LABEL(assignment_2dsclam498);
static RML_FORWARD_LABEL(assignment_2dsclam497);
static RML_FORWARD_LABEL(assignment_2dsclam496);
static RML_FORWARD_LABEL(assignment_2dsclam495);
static RML_FORWARD_LABEL(assignment_2dsclam494);
static RML_FORWARD_LABEL(assignment__lookup);

static const RML_DEFSTRINGLIT(lit0,3,"v: ");
static const RML_DEFSTRINGLIT(lit1,1,"\n");
static const RML_DEFSTRINGLIT(lit2,8,"lookup: ");
static const RML_DEFSTRINGLIT(lit3,5,"evp1\n");
static const RML_DEFSTRINGLIT(lit4,5,"evp2\n");
static const RML_DEFSTRUCT0LIT(lit5,0);
static const RML_DEFSTRINGLIT(lit6,5,"evp3\n");
static const RML_DEFSTRINGLIT(lit7,5,"evp4\n");

extern void RML_5finit(void);

void assignment_5finit(void)
{
	static int done = 0;
	if( done ) return;
	done = 1;
	RML_5finit();
}

RML_BEGIN_LABEL(assignment__evalprogram)
{

	{ void *tmp270 = rmlSC;
	{ void *tmp269 = rmlFC;
	{ void *tmp618 = rmlSP;
	{ void *tmp271 = rmlA0;
	{ void *tmp431 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp271), 2));
	{ void *tmp432 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp271), 1));
	RML_STORE(RML_OFFSET(tmp618, -1), tmp432);
	RML_STORE(RML_OFFSET(tmp618, -2), tmp269);
	RML_STORE(RML_OFFSET(tmp618, -3), tmp431);
	RML_STORE(RML_OFFSET(tmp618, -4), tmp270);
	RML_STORE(RML_OFFSET(tmp618, -5), RML_LABVAL(assignment_2dsclam459));
	rmlA0 = RML_REFSTRINGLIT(lit3);
	rmlSC = RML_OFFSET(tmp618, -5);
	rmlSP = RML_OFFSET(tmp618, -5);
	RML_TAILCALLQ(RML__print,1);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam459)
{

	{ void *tmp621 = rmlSC;
	{ void *tmp270 = RML_FETCH(RML_OFFSET(tmp621, 1));
	{ void *tmp431 = RML_FETCH(RML_OFFSET(tmp621, 2));
	{ void *tmp269 = RML_FETCH(RML_OFFSET(tmp621, 3));
	{ void *tmp432 = RML_FETCH(RML_OFFSET(tmp621, 4));
	{ void *tmp620 = RML_OFFSET(tmp621, 5);
	RML_STORE(RML_OFFSET(tmp620, -1), tmp269);
	RML_STORE(RML_OFFSET(tmp620, -2), tmp431);
	RML_STORE(RML_OFFSET(tmp620, -3), tmp270);
	RML_STORE(RML_OFFSET(tmp620, -4), RML_LABVAL(assignment_2dsclam458));
	rmlA0 = tmp432;
	rmlFC = tmp269;
	rmlSC = RML_OFFSET(tmp620, -4);
	rmlSP = RML_OFFSET(tmp620, -4);
	RML_TAILCALLQ(RML__list_5freverse,1);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam458)
{

	{ void *tmp624 = rmlSC;
	{ void *tmp270 = RML_FETCH(RML_OFFSET(tmp624, 1));
	{ void *tmp431 = RML_FETCH(RML_OFFSET(tmp624, 2));
	{ void *tmp269 = RML_FETCH(RML_OFFSET(tmp624, 3));
	{ void *tmp623 = RML_OFFSET(tmp624, 4);
	{ void *tmp435 = rmlA0;
	RML_STORE(RML_OFFSET(tmp623, -1), tmp435);
	RML_STORE(RML_OFFSET(tmp623, -2), tmp269);
	RML_STORE(RML_OFFSET(tmp623, -3), tmp431);
	RML_STORE(RML_OFFSET(tmp623, -4), tmp270);
	RML_STORE(RML_OFFSET(tmp623, -5), RML_LABVAL(assignment_2dsclam457));
	rmlA0 = RML_REFSTRINGLIT(lit4);
	rmlFC = tmp269;
	rmlSC = RML_OFFSET(tmp623, -5);
	rmlSP = RML_OFFSET(tmp623, -5);
	RML_TAILCALLQ(RML__print,1);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam457)
{

	{ void *tmp627 = rmlSC;
	{ void *tmp270 = RML_FETCH(RML_OFFSET(tmp627, 1));
	{ void *tmp431 = RML_FETCH(RML_OFFSET(tmp627, 2));
	{ void *tmp269 = RML_FETCH(RML_OFFSET(tmp627, 3));
	{ void *tmp435 = RML_FETCH(RML_OFFSET(tmp627, 4));
	{ void *tmp626 = RML_OFFSET(tmp627, 5);
	RML_STORE(RML_OFFSET(tmp626, -1), tmp269);
	RML_STORE(RML_OFFSET(tmp626, -2), tmp431);
	RML_STORE(RML_OFFSET(tmp626, -3), tmp270);
	RML_STORE(RML_OFFSET(tmp626, -4), RML_LABVAL(assignment_2dsclam456));
	rmlA1 = tmp435;
	rmlA0 = RML_REFSTRUCTLIT(lit5);
	rmlFC = tmp269;
	rmlSC = RML_OFFSET(tmp626, -4);
	rmlSP = RML_OFFSET(tmp626, -4);
	RML_TAILCALLQ(assignment__evals,2);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam456)
{

	{ void *tmp630 = rmlSC;
	{ void *tmp270 = RML_FETCH(RML_OFFSET(tmp630, 1));
	{ void *tmp431 = RML_FETCH(RML_OFFSET(tmp630, 2));
	{ void *tmp269 = RML_FETCH(RML_OFFSET(tmp630, 3));
	{ void *tmp629 = RML_OFFSET(tmp630, 4);
	{ void *tmp441 = rmlA0;
	RML_STORE(RML_OFFSET(tmp629, -1), tmp441);
	RML_STORE(RML_OFFSET(tmp629, -2), tmp431);
	RML_STORE(RML_OFFSET(tmp629, -3), tmp269);
	RML_STORE(RML_OFFSET(tmp629, -4), tmp270);
	RML_STORE(RML_OFFSET(tmp629, -5), RML_LABVAL(assignment_2dsclam455));
	rmlA0 = RML_REFSTRINGLIT(lit6);
	rmlFC = tmp269;
	rmlSC = RML_OFFSET(tmp629, -5);
	rmlSP = RML_OFFSET(tmp629, -5);
	RML_TAILCALLQ(RML__print,1);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam455)
{

	{ void *tmp633 = rmlSC;
	{ void *tmp270 = RML_FETCH(RML_OFFSET(tmp633, 1));
	{ void *tmp269 = RML_FETCH(RML_OFFSET(tmp633, 2));
	{ void *tmp431 = RML_FETCH(RML_OFFSET(tmp633, 3));
	{ void *tmp441 = RML_FETCH(RML_OFFSET(tmp633, 4));
	{ void *tmp632 = RML_OFFSET(tmp633, 5);
	RML_STORE(RML_OFFSET(tmp632, -1), tmp269);
	RML_STORE(RML_OFFSET(tmp632, -2), tmp270);
	RML_STORE(RML_OFFSET(tmp632, -3), RML_LABVAL(assignment_2dsclam454));
	rmlA1 = tmp431;
	rmlA0 = tmp441;
	rmlFC = tmp269;
	rmlSC = RML_OFFSET(tmp632, -3);
	rmlSP = RML_OFFSET(tmp632, -3);
	RML_TAILCALLQ(assignment__eval,2);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam454)
{

	{ void *tmp636 = rmlSC;
	{ void *tmp270 = RML_FETCH(RML_OFFSET(tmp636, 1));
	{ void *tmp269 = RML_FETCH(RML_OFFSET(tmp636, 2));
	{ void *tmp635 = RML_OFFSET(tmp636, 3);
	{ void *tmp448 = rmlA1;
	RML_STORE(RML_OFFSET(tmp635, -1), tmp270);
	RML_STORE(RML_OFFSET(tmp635, -2), tmp448);
	RML_STORE(RML_OFFSET(tmp635, -3), RML_LABVAL(assignment_2dsclam453));
	rmlA0 = RML_REFSTRINGLIT(lit7);
	rmlFC = tmp269;
	rmlSC = RML_OFFSET(tmp635, -3);
	rmlSP = RML_OFFSET(tmp635, -3);
	RML_TAILCALLQ(RML__print,1);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam453)
{

	{ void *tmp639 = rmlSC;
	{ void *tmp448 = RML_FETCH(RML_OFFSET(tmp639, 1));
	{ void *tmp270 = RML_FETCH(RML_OFFSET(tmp639, 2));
	{ void *tmp638 = RML_OFFSET(tmp639, 3);
	rmlA0 = tmp448;
	rmlSC = tmp270;
	rmlSP = tmp638;
	RML_TAILCALL(RML_FETCH(tmp270),1);}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment__eval)
{

	{ void *tmp262 = rmlSC;
	{ void *tmp261 = rmlFC;
	{ void *tmp580 = rmlSP;
	{ void *tmp263 = rmlA0;
	{ void *tmp264 = rmlA1;
	{ void *tmp346 = RML_FETCH(RML_UNTAGPTR(tmp264));
	switch( RML_HDRCTOR((rml_uint_t)tmp346) ) {
	case 4:
	{ void *tmp347 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp264), 1));
	RML_STORE(RML_OFFSET(tmp580, -1), tmp261);
	RML_STORE(RML_OFFSET(tmp580, -2), tmp262);
	RML_STORE(RML_OFFSET(tmp580, -3), RML_LABVAL(assignment_2dsclam367));
	{ void *tmp258 = RML_OFFSET(tmp580, -3);
	{ void *tmp528 = rml_prim_marker();
	RML_STORE(RML_OFFSET(tmp580, -4), tmp528);
	RML_STORE(RML_OFFSET(tmp580, -5), tmp347);
	RML_STORE(RML_OFFSET(tmp580, -6), tmp263);
	RML_STORE(RML_OFFSET(tmp580, -7), tmp258);
	RML_STORE(RML_OFFSET(tmp580, -8), RML_LABVAL(assignment_2dfclam532));
	RML_STORE(RML_OFFSET(tmp580, -9), tmp258);
	RML_STORE(RML_OFFSET(tmp580, -10), tmp263);
	RML_STORE(RML_OFFSET(tmp580, -11), RML_LABVAL(assignment_2dsclam538));
	rmlA1 = tmp347;
	rmlFC = RML_OFFSET(tmp580, -8);
	rmlSC = RML_OFFSET(tmp580, -11);
	rmlSP = RML_OFFSET(tmp580, -11);
	RML_TAILCALLQ(assignment__lookup,2);}}}
	case 1:
	{ void *tmp368 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp264), 3));
	{ void *tmp369 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp264), 2));
	{ void *tmp370 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp264), 1));
	RML_STORE(RML_OFFSET(tmp580, -1), tmp368);
	RML_STORE(RML_OFFSET(tmp580, -2), tmp261);
	RML_STORE(RML_OFFSET(tmp580, -3), tmp262);
	RML_STORE(RML_OFFSET(tmp580, -4), tmp369);
	RML_STORE(RML_OFFSET(tmp580, -5), RML_LABVAL(assignment_2dsclam392));
	rmlA1 = tmp370;
	rmlSC = RML_OFFSET(tmp580, -5);
	rmlSP = RML_OFFSET(tmp580, -5);
	RML_TAILCALLQ(assignment__eval,2);}}}
	case 2:
	{ void *tmp393 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp264), 2));
	RML_STORE(RML_OFFSET(tmp580, -1), tmp262);
	RML_STORE(RML_OFFSET(tmp580, -2), RML_LABVAL(assignment_2dsclam408));
	rmlA1 = tmp393;
	rmlSC = RML_OFFSET(tmp580, -2);
	rmlSP = RML_OFFSET(tmp580, -2);
	RML_TAILCALLQ(assignment__eval,2);}
	case 3:
	{ void *tmp409 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp264), 2));
	{ void *tmp410 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp264), 1));
	RML_STORE(RML_OFFSET(tmp580, -1), tmp410);
	RML_STORE(RML_OFFSET(tmp580, -2), tmp262);
	RML_STORE(RML_OFFSET(tmp580, -3), RML_LABVAL(assignment_2dsclam424));
	rmlA1 = tmp409;
	rmlSC = RML_OFFSET(tmp580, -3);
	rmlSP = RML_OFFSET(tmp580, -3);
	RML_TAILCALLQ(assignment__eval,2);}}
	/*case 0*/
	default:
	{ void *tmp425 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp264), 1));
	rmlA1 = tmp425;
	RML_TAILCALL(RML_FETCH(tmp262),2);}
	}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam424)
{
	void *tmp614;
	RML_ALLOC(tmp614,6,2,assignment_2dsclam424);
	{ void *tmp616 = rmlSC;
	{ void *tmp262 = RML_FETCH(RML_OFFSET(tmp616, 1));
	{ void *tmp410 = RML_FETCH(RML_OFFSET(tmp616, 2));
	{ void *tmp615 = RML_OFFSET(tmp616, 3);
	{ void *tmp412 = rmlA0;
	{ void *tmp413 = rmlA1;
	RML_STORE(tmp614, RML_IMMEDIATE(RML_STRUCTHDR(2,0)));
	RML_STORE(RML_OFFSET(tmp614, 1), tmp410);
	RML_STORE(RML_OFFSET(tmp614, 2), tmp413);
	{ void *tmp544 = RML_TAGPTR(tmp614);
	RML_STORE(RML_OFFSET(tmp614, 3), RML_IMMEDIATE(RML_STRUCTHDR(2,1)));
	RML_STORE(RML_OFFSET(tmp614, 4), tmp544);
	RML_STORE(RML_OFFSET(tmp614, 5), tmp412);
	{ void *tmp545 = RML_TAGPTR(RML_OFFSET(tmp614, 3));
	rmlA0 = tmp545;
	rmlSC = tmp262;
	rmlSP = tmp615;
	RML_TAILCALL(RML_FETCH(tmp262),2);}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam408)
{

	{ void *tmp613 = rmlSC;
	{ void *tmp262 = RML_FETCH(RML_OFFSET(tmp613, 1));
	{ void *tmp612 = RML_OFFSET(tmp613, 2);
	{ void *tmp397 = rmlA1;
	{ void *tmp547 = RML_PRIM_INT_NEG(tmp397);
	rmlA1 = tmp547;
	rmlSC = tmp262;
	rmlSP = tmp612;
	RML_TAILCALL(RML_FETCH(tmp262),2);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam392)
{

	{ void *tmp604 = rmlSC;
	{ void *tmp369 = RML_FETCH(RML_OFFSET(tmp604, 1));
	{ void *tmp262 = RML_FETCH(RML_OFFSET(tmp604, 2));
	{ void *tmp261 = RML_FETCH(RML_OFFSET(tmp604, 3));
	{ void *tmp368 = RML_FETCH(RML_OFFSET(tmp604, 4));
	{ void *tmp603 = RML_OFFSET(tmp604, 5);
	{ void *tmp373 = rmlA1;
	RML_STORE(RML_OFFSET(tmp603, -1), tmp262);
	RML_STORE(RML_OFFSET(tmp603, -2), tmp369);
	RML_STORE(RML_OFFSET(tmp603, -3), tmp373);
	RML_STORE(RML_OFFSET(tmp603, -4), tmp261);
	RML_STORE(RML_OFFSET(tmp603, -5), RML_LABVAL(assignment_2dsclam391));
	rmlA1 = tmp368;
	rmlFC = tmp261;
	rmlSC = RML_OFFSET(tmp603, -5);
	rmlSP = RML_OFFSET(tmp603, -5);
	RML_TAILCALLQ(assignment__eval,2);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam391)
{

	{ void *tmp607 = rmlSC;
	{ void *tmp261 = RML_FETCH(RML_OFFSET(tmp607, 1));
	{ void *tmp373 = RML_FETCH(RML_OFFSET(tmp607, 2));
	{ void *tmp369 = RML_FETCH(RML_OFFSET(tmp607, 3));
	{ void *tmp262 = RML_FETCH(RML_OFFSET(tmp607, 4));
	{ void *tmp606 = RML_OFFSET(tmp607, 5);
	{ void *tmp379 = rmlA0;
	{ void *tmp380 = rmlA1;
	RML_STORE(RML_OFFSET(tmp606, -1), tmp262);
	RML_STORE(RML_OFFSET(tmp606, -2), tmp379);
	RML_STORE(RML_OFFSET(tmp606, -3), RML_LABVAL(assignment_2dsclam390));
	{ void *tmp244 = RML_OFFSET(tmp606, -3);
	switch( RML_UNTAGFIXNUM(tmp369) ) {
	case 1:
	{ void *tmp550 = RML_PRIM_INT_SUB(tmp373, tmp380);
	rmlA0 = tmp550;
	rmlSC = tmp244;
	rmlSP = RML_OFFSET(tmp606, -3);
	RML_TAILCALL(RML_FETCH(tmp244),1);}
	case 3:
	switch( (rml_sint_t)tmp380 ) {
	case RML_TAGFIXNUM(0):
	rmlFC = tmp261;
	rmlSP = RML_OFFSET(tmp606, -3);
	RML_TAILCALL(RML_FETCH(tmp261),0);
	default:
	{ void *tmp553 = RML_PRIM_INT_DIV(tmp373, tmp380);
	rmlA0 = tmp553;
	rmlSC = tmp244;
	rmlSP = RML_OFFSET(tmp606, -3);
	RML_TAILCALL(RML_FETCH(tmp244),1);}
	}
	case 2:
	{ void *tmp556 = RML_PRIM_INT_MUL(tmp373, tmp380);
	rmlA0 = tmp556;
	rmlSC = tmp244;
	rmlSP = RML_OFFSET(tmp606, -3);
	RML_TAILCALL(RML_FETCH(tmp244),1);}
	/*case 0*/
	default:
	{ void *tmp559 = RML_PRIM_INT_ADD(tmp373, tmp380);
	rmlA0 = tmp559;
	rmlSC = tmp244;
	rmlSP = RML_OFFSET(tmp606, -3);
	RML_TAILCALL(RML_FETCH(tmp244),1);}
	}}}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam390)
{

	{ void *tmp610 = rmlSC;
	{ void *tmp379 = RML_FETCH(RML_OFFSET(tmp610, 1));
	{ void *tmp262 = RML_FETCH(RML_OFFSET(tmp610, 2));
	{ void *tmp609 = RML_OFFSET(tmp610, 3);
	{ void *tmp386 = rmlA0;
	rmlA1 = tmp386;
	rmlA0 = tmp379;
	rmlSC = tmp262;
	rmlSP = tmp609;
	RML_TAILCALL(RML_FETCH(tmp262),2);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam538)
{

	{ void *tmp601 = rmlSC;
	{ void *tmp263 = RML_FETCH(RML_OFFSET(tmp601, 1));
	{ void *tmp258 = RML_FETCH(RML_OFFSET(tmp601, 2));
	{ void *tmp600 = RML_OFFSET(tmp601, 3);
	{ void *tmp534 = rmlA0;
	rmlA1 = tmp534;
	rmlA0 = tmp263;
	rmlSC = tmp258;
	rmlSP = tmp600;
	RML_TAILCALL(RML_FETCH(tmp258),2);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dfclam532)
{
	void *tmp596;
	RML_ALLOC(tmp596,6,0,assignment_2dfclam532);
	{ void *tmp598 = rmlFC;
	{ void *tmp258 = RML_FETCH(RML_OFFSET(tmp598, 1));
	{ void *tmp263 = RML_FETCH(RML_OFFSET(tmp598, 2));
	{ void *tmp347 = RML_FETCH(RML_OFFSET(tmp598, 3));
	{ void *tmp528 = RML_FETCH(RML_OFFSET(tmp598, 4));
	{ void *tmp597 = RML_OFFSET(tmp598, 5);
	rml_prim_unwind(tmp528);
	RML_STORE(tmp596, RML_IMMEDIATE(RML_STRUCTHDR(2,0)));
	RML_STORE(RML_OFFSET(tmp596, 1), tmp347);
	RML_STORE(RML_OFFSET(tmp596, 2), RML_IMMEDIATE(RML_TAGFIXNUM(0)));
	{ void *tmp530 = RML_TAGPTR(tmp596);
	RML_STORE(RML_OFFSET(tmp596, 3), RML_IMMEDIATE(RML_STRUCTHDR(2,1)));
	RML_STORE(RML_OFFSET(tmp596, 4), tmp530);
	RML_STORE(RML_OFFSET(tmp596, 5), tmp263);
	{ void *tmp531 = RML_TAGPTR(RML_OFFSET(tmp596, 3));
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(0));
	rmlA0 = tmp531;
	rmlSC = tmp258;
	rmlSP = tmp597;
	RML_TAILCALL(RML_FETCH(tmp258),2);}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam367)
{

	{ void *tmp583 = rmlSC;
	{ void *tmp262 = RML_FETCH(RML_OFFSET(tmp583, 1));
	{ void *tmp261 = RML_FETCH(RML_OFFSET(tmp583, 2));
	{ void *tmp582 = RML_OFFSET(tmp583, 3);
	{ void *tmp349 = rmlA0;
	{ void *tmp350 = rmlA1;
	RML_STORE(RML_OFFSET(tmp582, -1), tmp261);
	RML_STORE(RML_OFFSET(tmp582, -2), tmp262);
	RML_STORE(RML_OFFSET(tmp582, -3), tmp349);
	RML_STORE(RML_OFFSET(tmp582, -4), tmp350);
	RML_STORE(RML_OFFSET(tmp582, -5), RML_LABVAL(assignment_2dsclam366));
	rmlA0 = tmp350;
	rmlFC = tmp261;
	rmlSC = RML_OFFSET(tmp582, -5);
	rmlSP = RML_OFFSET(tmp582, -5);
	RML_TAILCALLQ(RML__int_5fstring,1);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam366)
{

	{ void *tmp586 = rmlSC;
	{ void *tmp350 = RML_FETCH(RML_OFFSET(tmp586, 1));
	{ void *tmp349 = RML_FETCH(RML_OFFSET(tmp586, 2));
	{ void *tmp262 = RML_FETCH(RML_OFFSET(tmp586, 3));
	{ void *tmp261 = RML_FETCH(RML_OFFSET(tmp586, 4));
	{ void *tmp585 = RML_OFFSET(tmp586, 5);
	{ void *tmp356 = rmlA0;
	RML_STORE(RML_OFFSET(tmp585, -1), tmp356);
	RML_STORE(RML_OFFSET(tmp585, -2), tmp261);
	RML_STORE(RML_OFFSET(tmp585, -3), tmp262);
	RML_STORE(RML_OFFSET(tmp585, -4), tmp349);
	RML_STORE(RML_OFFSET(tmp585, -5), tmp350);
	RML_STORE(RML_OFFSET(tmp585, -6), RML_LABVAL(assignment_2dsclam365));
	rmlA0 = RML_REFSTRINGLIT(lit2);
	rmlFC = tmp261;
	rmlSC = RML_OFFSET(tmp585, -6);
	rmlSP = RML_OFFSET(tmp585, -6);
	RML_TAILCALLQ(RML__print,1);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam365)
{

	{ void *tmp589 = rmlSC;
	{ void *tmp350 = RML_FETCH(RML_OFFSET(tmp589, 1));
	{ void *tmp349 = RML_FETCH(RML_OFFSET(tmp589, 2));
	{ void *tmp262 = RML_FETCH(RML_OFFSET(tmp589, 3));
	{ void *tmp261 = RML_FETCH(RML_OFFSET(tmp589, 4));
	{ void *tmp356 = RML_FETCH(RML_OFFSET(tmp589, 5));
	{ void *tmp588 = RML_OFFSET(tmp589, 6);
	RML_STORE(RML_OFFSET(tmp588, -1), tmp261);
	RML_STORE(RML_OFFSET(tmp588, -2), tmp262);
	RML_STORE(RML_OFFSET(tmp588, -3), tmp349);
	RML_STORE(RML_OFFSET(tmp588, -4), tmp350);
	RML_STORE(RML_OFFSET(tmp588, -5), RML_LABVAL(assignment_2dsclam364));
	rmlA0 = tmp356;
	rmlFC = tmp261;
	rmlSC = RML_OFFSET(tmp588, -5);
	rmlSP = RML_OFFSET(tmp588, -5);
	RML_TAILCALLQ(RML__print,1);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam364)
{

	{ void *tmp592 = rmlSC;
	{ void *tmp350 = RML_FETCH(RML_OFFSET(tmp592, 1));
	{ void *tmp349 = RML_FETCH(RML_OFFSET(tmp592, 2));
	{ void *tmp262 = RML_FETCH(RML_OFFSET(tmp592, 3));
	{ void *tmp261 = RML_FETCH(RML_OFFSET(tmp592, 4));
	{ void *tmp591 = RML_OFFSET(tmp592, 5);
	RML_STORE(RML_OFFSET(tmp591, -1), tmp262);
	RML_STORE(RML_OFFSET(tmp591, -2), tmp349);
	RML_STORE(RML_OFFSET(tmp591, -3), tmp350);
	RML_STORE(RML_OFFSET(tmp591, -4), RML_LABVAL(assignment_2dsclam363));
	rmlA0 = RML_REFSTRINGLIT(lit1);
	rmlFC = tmp261;
	rmlSC = RML_OFFSET(tmp591, -4);
	rmlSP = RML_OFFSET(tmp591, -4);
	RML_TAILCALLQ(RML__print,1);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam363)
{

	{ void *tmp595 = rmlSC;
	{ void *tmp350 = RML_FETCH(RML_OFFSET(tmp595, 1));
	{ void *tmp349 = RML_FETCH(RML_OFFSET(tmp595, 2));
	{ void *tmp262 = RML_FETCH(RML_OFFSET(tmp595, 3));
	{ void *tmp594 = RML_OFFSET(tmp595, 4);
	rmlA1 = tmp350;
	rmlA0 = tmp349;
	rmlSC = tmp262;
	rmlSP = tmp594;
	RML_TAILCALL(RML_FETCH(tmp262),2);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment__evals)
{

	{ void *tmp266 = rmlSC;
	{ void *tmp265 = rmlFC;
	{ void *tmp563 = rmlSP;
	{ void *tmp268 = rmlA1;
	{ void *tmp470 = RML_FETCH(RML_UNTAGPTR(tmp268));
	switch( (rml_sint_t)tmp470 ) {
	case RML_STRUCTHDR(0,0):
	RML_TAILCALL(RML_FETCH(tmp266),1);
	/*case RML_STRUCTHDR(2,1)*/
	default:
	{ void *tmp471 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp268), 2));
	{ void *tmp472 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp268), 1));
	RML_STORE(RML_OFFSET(tmp563, -1), tmp265);
	RML_STORE(RML_OFFSET(tmp563, -2), tmp471);
	RML_STORE(RML_OFFSET(tmp563, -3), tmp266);
	RML_STORE(RML_OFFSET(tmp563, -4), RML_LABVAL(assignment_2dsclam498));
	rmlA1 = tmp472;
	rmlSC = RML_OFFSET(tmp563, -4);
	rmlSP = RML_OFFSET(tmp563, -4);
	RML_TAILCALLQ(assignment__eval,2);}}
	}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam498)
{

	{ void *tmp566 = rmlSC;
	{ void *tmp266 = RML_FETCH(RML_OFFSET(tmp566, 1));
	{ void *tmp471 = RML_FETCH(RML_OFFSET(tmp566, 2));
	{ void *tmp265 = RML_FETCH(RML_OFFSET(tmp566, 3));
	{ void *tmp565 = RML_OFFSET(tmp566, 4);
	{ void *tmp474 = rmlA0;
	{ void *tmp475 = rmlA1;
	RML_STORE(RML_OFFSET(tmp565, -1), tmp265);
	RML_STORE(RML_OFFSET(tmp565, -2), tmp474);
	RML_STORE(RML_OFFSET(tmp565, -3), tmp471);
	RML_STORE(RML_OFFSET(tmp565, -4), tmp266);
	RML_STORE(RML_OFFSET(tmp565, -5), RML_LABVAL(assignment_2dsclam497));
	rmlA0 = tmp475;
	rmlFC = tmp265;
	rmlSC = RML_OFFSET(tmp565, -5);
	rmlSP = RML_OFFSET(tmp565, -5);
	RML_TAILCALLQ(RML__int_5fstring,1);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam497)
{

	{ void *tmp569 = rmlSC;
	{ void *tmp266 = RML_FETCH(RML_OFFSET(tmp569, 1));
	{ void *tmp471 = RML_FETCH(RML_OFFSET(tmp569, 2));
	{ void *tmp474 = RML_FETCH(RML_OFFSET(tmp569, 3));
	{ void *tmp265 = RML_FETCH(RML_OFFSET(tmp569, 4));
	{ void *tmp568 = RML_OFFSET(tmp569, 5);
	{ void *tmp481 = rmlA0;
	RML_STORE(RML_OFFSET(tmp568, -1), tmp481);
	RML_STORE(RML_OFFSET(tmp568, -2), tmp265);
	RML_STORE(RML_OFFSET(tmp568, -3), tmp474);
	RML_STORE(RML_OFFSET(tmp568, -4), tmp471);
	RML_STORE(RML_OFFSET(tmp568, -5), tmp266);
	RML_STORE(RML_OFFSET(tmp568, -6), RML_LABVAL(assignment_2dsclam496));
	rmlA0 = RML_REFSTRINGLIT(lit0);
	rmlFC = tmp265;
	rmlSC = RML_OFFSET(tmp568, -6);
	rmlSP = RML_OFFSET(tmp568, -6);
	RML_TAILCALLQ(RML__print,1);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam496)
{

	{ void *tmp572 = rmlSC;
	{ void *tmp266 = RML_FETCH(RML_OFFSET(tmp572, 1));
	{ void *tmp471 = RML_FETCH(RML_OFFSET(tmp572, 2));
	{ void *tmp474 = RML_FETCH(RML_OFFSET(tmp572, 3));
	{ void *tmp265 = RML_FETCH(RML_OFFSET(tmp572, 4));
	{ void *tmp481 = RML_FETCH(RML_OFFSET(tmp572, 5));
	{ void *tmp571 = RML_OFFSET(tmp572, 6);
	RML_STORE(RML_OFFSET(tmp571, -1), tmp265);
	RML_STORE(RML_OFFSET(tmp571, -2), tmp474);
	RML_STORE(RML_OFFSET(tmp571, -3), tmp471);
	RML_STORE(RML_OFFSET(tmp571, -4), tmp266);
	RML_STORE(RML_OFFSET(tmp571, -5), RML_LABVAL(assignment_2dsclam495));
	rmlA0 = tmp481;
	rmlFC = tmp265;
	rmlSC = RML_OFFSET(tmp571, -5);
	rmlSP = RML_OFFSET(tmp571, -5);
	RML_TAILCALLQ(RML__print,1);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam495)
{

	{ void *tmp575 = rmlSC;
	{ void *tmp266 = RML_FETCH(RML_OFFSET(tmp575, 1));
	{ void *tmp471 = RML_FETCH(RML_OFFSET(tmp575, 2));
	{ void *tmp474 = RML_FETCH(RML_OFFSET(tmp575, 3));
	{ void *tmp265 = RML_FETCH(RML_OFFSET(tmp575, 4));
	{ void *tmp574 = RML_OFFSET(tmp575, 5);
	RML_STORE(RML_OFFSET(tmp574, -1), tmp474);
	RML_STORE(RML_OFFSET(tmp574, -2), tmp471);
	RML_STORE(RML_OFFSET(tmp574, -3), tmp265);
	RML_STORE(RML_OFFSET(tmp574, -4), tmp266);
	RML_STORE(RML_OFFSET(tmp574, -5), RML_LABVAL(assignment_2dsclam494));
	rmlA0 = RML_REFSTRINGLIT(lit1);
	rmlFC = tmp265;
	rmlSC = RML_OFFSET(tmp574, -5);
	rmlSP = RML_OFFSET(tmp574, -5);
	RML_TAILCALLQ(RML__print,1);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam494)
{

	{ void *tmp578 = rmlSC;
	{ void *tmp266 = RML_FETCH(RML_OFFSET(tmp578, 1));
	{ void *tmp265 = RML_FETCH(RML_OFFSET(tmp578, 2));
	{ void *tmp471 = RML_FETCH(RML_OFFSET(tmp578, 3));
	{ void *tmp474 = RML_FETCH(RML_OFFSET(tmp578, 4));
	{ void *tmp577 = RML_OFFSET(tmp578, 5);
	rmlA1 = tmp471;
	rmlA0 = tmp474;
	rmlFC = tmp265;
	rmlSC = tmp266;
	rmlSP = tmp577;
	RML_TAILCALLQ(assignment__evals,2);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment__lookup)
{

	{ void *tmp254 = rmlSC;
	{ void *tmp253 = rmlFC;
	{ void *tmp255 = rmlA0;
	{ void *tmp256 = rmlA1;
	{ void *tmp509 = RML_FETCH(RML_UNTAGPTR(tmp255));
	switch( (rml_sint_t)tmp509 ) {
	case RML_STRUCTHDR(2,1):
	{ void *tmp510 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp255), 2));
	{ void *tmp511 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp255), 1));
	{ void *tmp512 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp511), 2));
	{ void *tmp513 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp511), 1));
	{ void *tmp514 = rml_prim_marker();
	{ void *tmp523 = rml_prim_equal(tmp256, tmp513);
	switch( (rml_sint_t)tmp523 ) {
	case RML_TAGFIXNUM(0):
	rml_prim_unwind(tmp514);
	rmlA0 = tmp510;
	RML_TAILCALLQ(assignment__lookup,2);
	default:
	rmlA0 = tmp512;
	RML_TAILCALL(RML_FETCH(tmp254),1);
	}}}}}}}
	default:
	RML_TAILCALL(RML_FETCH(tmp253),0);
	}}}}}}
}
RML_END_LABEL
