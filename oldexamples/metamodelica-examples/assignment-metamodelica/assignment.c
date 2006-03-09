/* module assignment */
#include "rml.h"
#include <stdlib.h>
#include <stdio.h>
RML_DEFINE_MODULE("assignment")
extern RML_FORWARD_LABEL(RML__list_5freverse);
extern RML_FORWARD_LABEL(RML__int_5fstring);
extern RML_FORWARD_LABEL(RML__print);

RML_FORWARD_LABEL(assignment__evalprogram);
static RML_FORWARD_LABEL(assignment_2dsclam466);
static RML_FORWARD_LABEL(assignment_2dsclam465);
static RML_FORWARD_LABEL(assignment_2dsclam464);
static RML_FORWARD_LABEL(assignment_2dsclam463);
static RML_FORWARD_LABEL(assignment_2dsclam462);
static RML_FORWARD_LABEL(assignment_2dsclam461);
static RML_FORWARD_LABEL(assignment_2dsclam460);
static RML_FORWARD_LABEL(assignment__eval);
static RML_FORWARD_LABEL(assignment_2dsclam431);
static RML_FORWARD_LABEL(assignment_2dsclam415);
static RML_FORWARD_LABEL(assignment_2dsclam399);
static RML_FORWARD_LABEL(assignment_2dsclam398);
static RML_FORWARD_LABEL(assignment_2dsclam397);
static RML_FORWARD_LABEL(assignment_2dsclam545);
static RML_FORWARD_LABEL(assignment_2dfclam539);
static RML_FORWARD_LABEL(assignment_2dsclam374);
static RML_FORWARD_LABEL(assignment_2dsclam373);
static RML_FORWARD_LABEL(assignment_2dsclam372);
static RML_FORWARD_LABEL(assignment_2dsclam371);
static RML_FORWARD_LABEL(assignment_2dsclam370);
static RML_FORWARD_LABEL(assignment__evals);
static RML_FORWARD_LABEL(assignment_2dsclam505);
static RML_FORWARD_LABEL(assignment_2dsclam504);
static RML_FORWARD_LABEL(assignment_2dsclam503);
static RML_FORWARD_LABEL(assignment_2dsclam502);
static RML_FORWARD_LABEL(assignment_2dsclam501);
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

	{ void *tmp275 = rmlSC;
	{ void *tmp274 = rmlFC;
	{ void *tmp625 = rmlSP;
	{ void *tmp276 = rmlA0;
	{ void *tmp438 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp276), 2));
	{ void *tmp439 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp276), 1));
	RML_STORE(RML_OFFSET(tmp625, -1), tmp439);
	RML_STORE(RML_OFFSET(tmp625, -2), tmp274);
	RML_STORE(RML_OFFSET(tmp625, -3), tmp438);
	RML_STORE(RML_OFFSET(tmp625, -4), tmp275);
	RML_STORE(RML_OFFSET(tmp625, -5), RML_LABVAL(assignment_2dsclam466));
	rmlA0 = RML_REFSTRINGLIT(lit3);
	rmlSC = RML_OFFSET(tmp625, -5);
	rmlSP = RML_OFFSET(tmp625, -5);
	RML_TAILCALLQ(RML__print,1);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam466)
{

	{ void *tmp628 = rmlSC;
	{ void *tmp275 = RML_FETCH(RML_OFFSET(tmp628, 1));
	{ void *tmp438 = RML_FETCH(RML_OFFSET(tmp628, 2));
	{ void *tmp274 = RML_FETCH(RML_OFFSET(tmp628, 3));
	{ void *tmp439 = RML_FETCH(RML_OFFSET(tmp628, 4));
	{ void *tmp627 = RML_OFFSET(tmp628, 5);
	RML_STORE(RML_OFFSET(tmp627, -1), tmp274);
	RML_STORE(RML_OFFSET(tmp627, -2), tmp438);
	RML_STORE(RML_OFFSET(tmp627, -3), tmp275);
	RML_STORE(RML_OFFSET(tmp627, -4), RML_LABVAL(assignment_2dsclam465));
	rmlA0 = tmp439;
	rmlFC = tmp274;
	rmlSC = RML_OFFSET(tmp627, -4);
	rmlSP = RML_OFFSET(tmp627, -4);
	RML_TAILCALLQ(RML__list_5freverse,1);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam465)
{

	{ void *tmp631 = rmlSC;
	{ void *tmp275 = RML_FETCH(RML_OFFSET(tmp631, 1));
	{ void *tmp438 = RML_FETCH(RML_OFFSET(tmp631, 2));
	{ void *tmp274 = RML_FETCH(RML_OFFSET(tmp631, 3));
	{ void *tmp630 = RML_OFFSET(tmp631, 4);
	{ void *tmp442 = rmlA0;
	RML_STORE(RML_OFFSET(tmp630, -1), tmp442);
	RML_STORE(RML_OFFSET(tmp630, -2), tmp274);
	RML_STORE(RML_OFFSET(tmp630, -3), tmp438);
	RML_STORE(RML_OFFSET(tmp630, -4), tmp275);
	RML_STORE(RML_OFFSET(tmp630, -5), RML_LABVAL(assignment_2dsclam464));
	rmlA0 = RML_REFSTRINGLIT(lit4);
	rmlFC = tmp274;
	rmlSC = RML_OFFSET(tmp630, -5);
	rmlSP = RML_OFFSET(tmp630, -5);
	RML_TAILCALLQ(RML__print,1);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam464)
{

	{ void *tmp634 = rmlSC;
	{ void *tmp275 = RML_FETCH(RML_OFFSET(tmp634, 1));
	{ void *tmp438 = RML_FETCH(RML_OFFSET(tmp634, 2));
	{ void *tmp274 = RML_FETCH(RML_OFFSET(tmp634, 3));
	{ void *tmp442 = RML_FETCH(RML_OFFSET(tmp634, 4));
	{ void *tmp633 = RML_OFFSET(tmp634, 5);
	RML_STORE(RML_OFFSET(tmp633, -1), tmp274);
	RML_STORE(RML_OFFSET(tmp633, -2), tmp438);
	RML_STORE(RML_OFFSET(tmp633, -3), tmp275);
	RML_STORE(RML_OFFSET(tmp633, -4), RML_LABVAL(assignment_2dsclam463));
	rmlA1 = tmp442;
	rmlA0 = RML_REFSTRUCTLIT(lit5);
	rmlFC = tmp274;
	rmlSC = RML_OFFSET(tmp633, -4);
	rmlSP = RML_OFFSET(tmp633, -4);
	RML_TAILCALLQ(assignment__evals,2);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam463)
{

	{ void *tmp637 = rmlSC;
	{ void *tmp275 = RML_FETCH(RML_OFFSET(tmp637, 1));
	{ void *tmp438 = RML_FETCH(RML_OFFSET(tmp637, 2));
	{ void *tmp274 = RML_FETCH(RML_OFFSET(tmp637, 3));
	{ void *tmp636 = RML_OFFSET(tmp637, 4);
	{ void *tmp448 = rmlA0;
	RML_STORE(RML_OFFSET(tmp636, -1), tmp448);
	RML_STORE(RML_OFFSET(tmp636, -2), tmp438);
	RML_STORE(RML_OFFSET(tmp636, -3), tmp274);
	RML_STORE(RML_OFFSET(tmp636, -4), tmp275);
	RML_STORE(RML_OFFSET(tmp636, -5), RML_LABVAL(assignment_2dsclam462));
	rmlA0 = RML_REFSTRINGLIT(lit6);
	rmlFC = tmp274;
	rmlSC = RML_OFFSET(tmp636, -5);
	rmlSP = RML_OFFSET(tmp636, -5);
	RML_TAILCALLQ(RML__print,1);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam462)
{

	{ void *tmp640 = rmlSC;
	{ void *tmp275 = RML_FETCH(RML_OFFSET(tmp640, 1));
	{ void *tmp274 = RML_FETCH(RML_OFFSET(tmp640, 2));
	{ void *tmp438 = RML_FETCH(RML_OFFSET(tmp640, 3));
	{ void *tmp448 = RML_FETCH(RML_OFFSET(tmp640, 4));
	{ void *tmp639 = RML_OFFSET(tmp640, 5);
	RML_STORE(RML_OFFSET(tmp639, -1), tmp274);
	RML_STORE(RML_OFFSET(tmp639, -2), tmp275);
	RML_STORE(RML_OFFSET(tmp639, -3), RML_LABVAL(assignment_2dsclam461));
	rmlA1 = tmp438;
	rmlA0 = tmp448;
	rmlFC = tmp274;
	rmlSC = RML_OFFSET(tmp639, -3);
	rmlSP = RML_OFFSET(tmp639, -3);
	RML_TAILCALLQ(assignment__eval,2);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam461)
{

	{ void *tmp643 = rmlSC;
	{ void *tmp275 = RML_FETCH(RML_OFFSET(tmp643, 1));
	{ void *tmp274 = RML_FETCH(RML_OFFSET(tmp643, 2));
	{ void *tmp642 = RML_OFFSET(tmp643, 3);
	{ void *tmp455 = rmlA1;
	RML_STORE(RML_OFFSET(tmp642, -1), tmp275);
	RML_STORE(RML_OFFSET(tmp642, -2), tmp455);
	RML_STORE(RML_OFFSET(tmp642, -3), RML_LABVAL(assignment_2dsclam460));
	rmlA0 = RML_REFSTRINGLIT(lit7);
	rmlFC = tmp274;
	rmlSC = RML_OFFSET(tmp642, -3);
	rmlSP = RML_OFFSET(tmp642, -3);
	RML_TAILCALLQ(RML__print,1);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam460)
{

	{ void *tmp646 = rmlSC;
	{ void *tmp455 = RML_FETCH(RML_OFFSET(tmp646, 1));
	{ void *tmp275 = RML_FETCH(RML_OFFSET(tmp646, 2));
	{ void *tmp645 = RML_OFFSET(tmp646, 3);
	rmlA0 = tmp455;
	rmlSC = tmp275;
	rmlSP = tmp645;
	RML_TAILCALL(RML_FETCH(tmp275),1);}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment__eval)
{

	{ void *tmp267 = rmlSC;
	{ void *tmp266 = rmlFC;
	{ void *tmp587 = rmlSP;
	{ void *tmp268 = rmlA0;
	{ void *tmp269 = rmlA1;
	{ void *tmp353 = RML_FETCH(RML_UNTAGPTR(tmp269));
	switch( RML_HDRCTOR((rml_uint_t)tmp353) ) {
	case 4:
	{ void *tmp354 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp269), 1));
	RML_STORE(RML_OFFSET(tmp587, -1), tmp266);
	RML_STORE(RML_OFFSET(tmp587, -2), tmp267);
	RML_STORE(RML_OFFSET(tmp587, -3), RML_LABVAL(assignment_2dsclam374));
	{ void *tmp263 = RML_OFFSET(tmp587, -3);
	{ void *tmp535 = rml_prim_marker();
	RML_STORE(RML_OFFSET(tmp587, -4), tmp535);
	RML_STORE(RML_OFFSET(tmp587, -5), tmp354);
	RML_STORE(RML_OFFSET(tmp587, -6), tmp268);
	RML_STORE(RML_OFFSET(tmp587, -7), tmp263);
	RML_STORE(RML_OFFSET(tmp587, -8), RML_LABVAL(assignment_2dfclam539));
	RML_STORE(RML_OFFSET(tmp587, -9), tmp263);
	RML_STORE(RML_OFFSET(tmp587, -10), tmp268);
	RML_STORE(RML_OFFSET(tmp587, -11), RML_LABVAL(assignment_2dsclam545));
	rmlA1 = tmp354;
	rmlFC = RML_OFFSET(tmp587, -8);
	rmlSC = RML_OFFSET(tmp587, -11);
	rmlSP = RML_OFFSET(tmp587, -11);
	RML_TAILCALLQ(assignment__lookup,2);}}}
	case 1:
	{ void *tmp375 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp269), 3));
	{ void *tmp376 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp269), 2));
	{ void *tmp377 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp269), 1));
	RML_STORE(RML_OFFSET(tmp587, -1), tmp375);
	RML_STORE(RML_OFFSET(tmp587, -2), tmp266);
	RML_STORE(RML_OFFSET(tmp587, -3), tmp267);
	RML_STORE(RML_OFFSET(tmp587, -4), tmp376);
	RML_STORE(RML_OFFSET(tmp587, -5), RML_LABVAL(assignment_2dsclam399));
	rmlA1 = tmp377;
	rmlSC = RML_OFFSET(tmp587, -5);
	rmlSP = RML_OFFSET(tmp587, -5);
	RML_TAILCALLQ(assignment__eval,2);}}}
	case 2:
	{ void *tmp400 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp269), 2));
	RML_STORE(RML_OFFSET(tmp587, -1), tmp267);
	RML_STORE(RML_OFFSET(tmp587, -2), RML_LABVAL(assignment_2dsclam415));
	rmlA1 = tmp400;
	rmlSC = RML_OFFSET(tmp587, -2);
	rmlSP = RML_OFFSET(tmp587, -2);
	RML_TAILCALLQ(assignment__eval,2);}
	case 3:
	{ void *tmp416 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp269), 2));
	{ void *tmp417 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp269), 1));
	RML_STORE(RML_OFFSET(tmp587, -1), tmp417);
	RML_STORE(RML_OFFSET(tmp587, -2), tmp267);
	RML_STORE(RML_OFFSET(tmp587, -3), RML_LABVAL(assignment_2dsclam431));
	rmlA1 = tmp416;
	rmlSC = RML_OFFSET(tmp587, -3);
	rmlSP = RML_OFFSET(tmp587, -3);
	RML_TAILCALLQ(assignment__eval,2);}}
	/*case 0*/
	default:
	{ void *tmp432 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp269), 1));
	rmlA1 = tmp432;
	RML_TAILCALL(RML_FETCH(tmp267),2);}
	}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam431)
{
	void *tmp621;
	RML_ALLOC(tmp621,6,2,assignment_2dsclam431);
	{ void *tmp623 = rmlSC;
	{ void *tmp267 = RML_FETCH(RML_OFFSET(tmp623, 1));
	{ void *tmp417 = RML_FETCH(RML_OFFSET(tmp623, 2));
	{ void *tmp622 = RML_OFFSET(tmp623, 3);
	{ void *tmp419 = rmlA0;
	{ void *tmp420 = rmlA1;
	RML_STORE(tmp621, RML_IMMEDIATE(RML_STRUCTHDR(2,0)));
	RML_STORE(RML_OFFSET(tmp621, 1), tmp417);
	RML_STORE(RML_OFFSET(tmp621, 2), tmp420);
	{ void *tmp551 = RML_TAGPTR(tmp621);
	RML_STORE(RML_OFFSET(tmp621, 3), RML_IMMEDIATE(RML_STRUCTHDR(2,1)));
	RML_STORE(RML_OFFSET(tmp621, 4), tmp551);
	RML_STORE(RML_OFFSET(tmp621, 5), tmp419);
	{ void *tmp552 = RML_TAGPTR(RML_OFFSET(tmp621, 3));
	rmlA0 = tmp552;
	rmlSC = tmp267;
	rmlSP = tmp622;
	RML_TAILCALL(RML_FETCH(tmp267),2);}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam415)
{

	{ void *tmp620 = rmlSC;
	{ void *tmp267 = RML_FETCH(RML_OFFSET(tmp620, 1));
	{ void *tmp619 = RML_OFFSET(tmp620, 2);
	{ void *tmp404 = rmlA1;
	{ void *tmp554 = RML_PRIM_INT_NEG(tmp404);
	rmlA1 = tmp554;
	rmlSC = tmp267;
	rmlSP = tmp619;
	RML_TAILCALL(RML_FETCH(tmp267),2);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam399)
{

	{ void *tmp611 = rmlSC;
	{ void *tmp376 = RML_FETCH(RML_OFFSET(tmp611, 1));
	{ void *tmp267 = RML_FETCH(RML_OFFSET(tmp611, 2));
	{ void *tmp266 = RML_FETCH(RML_OFFSET(tmp611, 3));
	{ void *tmp375 = RML_FETCH(RML_OFFSET(tmp611, 4));
	{ void *tmp610 = RML_OFFSET(tmp611, 5);
	{ void *tmp380 = rmlA1;
	RML_STORE(RML_OFFSET(tmp610, -1), tmp267);
	RML_STORE(RML_OFFSET(tmp610, -2), tmp376);
	RML_STORE(RML_OFFSET(tmp610, -3), tmp380);
	RML_STORE(RML_OFFSET(tmp610, -4), tmp266);
	RML_STORE(RML_OFFSET(tmp610, -5), RML_LABVAL(assignment_2dsclam398));
	rmlA1 = tmp375;
	rmlFC = tmp266;
	rmlSC = RML_OFFSET(tmp610, -5);
	rmlSP = RML_OFFSET(tmp610, -5);
	RML_TAILCALLQ(assignment__eval,2);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam398)
{

	{ void *tmp614 = rmlSC;
	{ void *tmp266 = RML_FETCH(RML_OFFSET(tmp614, 1));
	{ void *tmp380 = RML_FETCH(RML_OFFSET(tmp614, 2));
	{ void *tmp376 = RML_FETCH(RML_OFFSET(tmp614, 3));
	{ void *tmp267 = RML_FETCH(RML_OFFSET(tmp614, 4));
	{ void *tmp613 = RML_OFFSET(tmp614, 5);
	{ void *tmp386 = rmlA0;
	{ void *tmp387 = rmlA1;
	RML_STORE(RML_OFFSET(tmp613, -1), tmp267);
	RML_STORE(RML_OFFSET(tmp613, -2), tmp386);
	RML_STORE(RML_OFFSET(tmp613, -3), RML_LABVAL(assignment_2dsclam397));
	{ void *tmp249 = RML_OFFSET(tmp613, -3);
	{ void *tmp292 = RML_FETCH(RML_UNTAGPTR(tmp376));
	switch( RML_HDRCTOR((rml_uint_t)tmp292) ) {
	case 1:
	{ void *tmp557 = RML_PRIM_INT_SUB(tmp380, tmp387);
	rmlA0 = tmp557;
	rmlSC = tmp249;
	rmlSP = RML_OFFSET(tmp613, -3);
	RML_TAILCALL(RML_FETCH(tmp249),1);}
	case 3:
	switch( (rml_sint_t)tmp387 ) {
	case RML_TAGFIXNUM(0):
	rmlFC = tmp266;
	rmlSP = RML_OFFSET(tmp613, -3);
	RML_TAILCALL(RML_FETCH(tmp266),0);
	default:
	{ void *tmp560 = RML_PRIM_INT_DIV(tmp380, tmp387);
	rmlA0 = tmp560;
	rmlSC = tmp249;
	rmlSP = RML_OFFSET(tmp613, -3);
	RML_TAILCALL(RML_FETCH(tmp249),1);}
	}
	case 2:
	{ void *tmp563 = RML_PRIM_INT_MUL(tmp380, tmp387);
	rmlA0 = tmp563;
	rmlSC = tmp249;
	rmlSP = RML_OFFSET(tmp613, -3);
	RML_TAILCALL(RML_FETCH(tmp249),1);}
	/*case 0*/
	default:
	{ void *tmp566 = RML_PRIM_INT_ADD(tmp380, tmp387);
	rmlA0 = tmp566;
	rmlSC = tmp249;
	rmlSP = RML_OFFSET(tmp613, -3);
	RML_TAILCALL(RML_FETCH(tmp249),1);}
	}}}}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam397)
{

	{ void *tmp617 = rmlSC;
	{ void *tmp386 = RML_FETCH(RML_OFFSET(tmp617, 1));
	{ void *tmp267 = RML_FETCH(RML_OFFSET(tmp617, 2));
	{ void *tmp616 = RML_OFFSET(tmp617, 3);
	{ void *tmp393 = rmlA0;
	rmlA1 = tmp393;
	rmlA0 = tmp386;
	rmlSC = tmp267;
	rmlSP = tmp616;
	RML_TAILCALL(RML_FETCH(tmp267),2);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam545)
{

	{ void *tmp608 = rmlSC;
	{ void *tmp268 = RML_FETCH(RML_OFFSET(tmp608, 1));
	{ void *tmp263 = RML_FETCH(RML_OFFSET(tmp608, 2));
	{ void *tmp607 = RML_OFFSET(tmp608, 3);
	{ void *tmp541 = rmlA0;
	rmlA1 = tmp541;
	rmlA0 = tmp268;
	rmlSC = tmp263;
	rmlSP = tmp607;
	RML_TAILCALL(RML_FETCH(tmp263),2);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dfclam539)
{
	void *tmp603;
	RML_ALLOC(tmp603,6,0,assignment_2dfclam539);
	{ void *tmp605 = rmlFC;
	{ void *tmp263 = RML_FETCH(RML_OFFSET(tmp605, 1));
	{ void *tmp268 = RML_FETCH(RML_OFFSET(tmp605, 2));
	{ void *tmp354 = RML_FETCH(RML_OFFSET(tmp605, 3));
	{ void *tmp535 = RML_FETCH(RML_OFFSET(tmp605, 4));
	{ void *tmp604 = RML_OFFSET(tmp605, 5);
	rml_prim_unwind(tmp535);
	RML_STORE(tmp603, RML_IMMEDIATE(RML_STRUCTHDR(2,0)));
	RML_STORE(RML_OFFSET(tmp603, 1), tmp354);
	RML_STORE(RML_OFFSET(tmp603, 2), RML_IMMEDIATE(RML_TAGFIXNUM(0)));
	{ void *tmp537 = RML_TAGPTR(tmp603);
	RML_STORE(RML_OFFSET(tmp603, 3), RML_IMMEDIATE(RML_STRUCTHDR(2,1)));
	RML_STORE(RML_OFFSET(tmp603, 4), tmp537);
	RML_STORE(RML_OFFSET(tmp603, 5), tmp268);
	{ void *tmp538 = RML_TAGPTR(RML_OFFSET(tmp603, 3));
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(0));
	rmlA0 = tmp538;
	rmlSC = tmp263;
	rmlSP = tmp604;
	RML_TAILCALL(RML_FETCH(tmp263),2);}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam374)
{

	{ void *tmp590 = rmlSC;
	{ void *tmp267 = RML_FETCH(RML_OFFSET(tmp590, 1));
	{ void *tmp266 = RML_FETCH(RML_OFFSET(tmp590, 2));
	{ void *tmp589 = RML_OFFSET(tmp590, 3);
	{ void *tmp356 = rmlA0;
	{ void *tmp357 = rmlA1;
	RML_STORE(RML_OFFSET(tmp589, -1), tmp266);
	RML_STORE(RML_OFFSET(tmp589, -2), tmp267);
	RML_STORE(RML_OFFSET(tmp589, -3), tmp356);
	RML_STORE(RML_OFFSET(tmp589, -4), tmp357);
	RML_STORE(RML_OFFSET(tmp589, -5), RML_LABVAL(assignment_2dsclam373));
	rmlA0 = tmp357;
	rmlFC = tmp266;
	rmlSC = RML_OFFSET(tmp589, -5);
	rmlSP = RML_OFFSET(tmp589, -5);
	RML_TAILCALLQ(RML__int_5fstring,1);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam373)
{

	{ void *tmp593 = rmlSC;
	{ void *tmp357 = RML_FETCH(RML_OFFSET(tmp593, 1));
	{ void *tmp356 = RML_FETCH(RML_OFFSET(tmp593, 2));
	{ void *tmp267 = RML_FETCH(RML_OFFSET(tmp593, 3));
	{ void *tmp266 = RML_FETCH(RML_OFFSET(tmp593, 4));
	{ void *tmp592 = RML_OFFSET(tmp593, 5);
	{ void *tmp363 = rmlA0;
	RML_STORE(RML_OFFSET(tmp592, -1), tmp363);
	RML_STORE(RML_OFFSET(tmp592, -2), tmp266);
	RML_STORE(RML_OFFSET(tmp592, -3), tmp267);
	RML_STORE(RML_OFFSET(tmp592, -4), tmp356);
	RML_STORE(RML_OFFSET(tmp592, -5), tmp357);
	RML_STORE(RML_OFFSET(tmp592, -6), RML_LABVAL(assignment_2dsclam372));
	rmlA0 = RML_REFSTRINGLIT(lit2);
	rmlFC = tmp266;
	rmlSC = RML_OFFSET(tmp592, -6);
	rmlSP = RML_OFFSET(tmp592, -6);
	RML_TAILCALLQ(RML__print,1);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam372)
{

	{ void *tmp596 = rmlSC;
	{ void *tmp357 = RML_FETCH(RML_OFFSET(tmp596, 1));
	{ void *tmp356 = RML_FETCH(RML_OFFSET(tmp596, 2));
	{ void *tmp267 = RML_FETCH(RML_OFFSET(tmp596, 3));
	{ void *tmp266 = RML_FETCH(RML_OFFSET(tmp596, 4));
	{ void *tmp363 = RML_FETCH(RML_OFFSET(tmp596, 5));
	{ void *tmp595 = RML_OFFSET(tmp596, 6);
	RML_STORE(RML_OFFSET(tmp595, -1), tmp266);
	RML_STORE(RML_OFFSET(tmp595, -2), tmp267);
	RML_STORE(RML_OFFSET(tmp595, -3), tmp356);
	RML_STORE(RML_OFFSET(tmp595, -4), tmp357);
	RML_STORE(RML_OFFSET(tmp595, -5), RML_LABVAL(assignment_2dsclam371));
	rmlA0 = tmp363;
	rmlFC = tmp266;
	rmlSC = RML_OFFSET(tmp595, -5);
	rmlSP = RML_OFFSET(tmp595, -5);
	RML_TAILCALLQ(RML__print,1);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam371)
{

	{ void *tmp599 = rmlSC;
	{ void *tmp357 = RML_FETCH(RML_OFFSET(tmp599, 1));
	{ void *tmp356 = RML_FETCH(RML_OFFSET(tmp599, 2));
	{ void *tmp267 = RML_FETCH(RML_OFFSET(tmp599, 3));
	{ void *tmp266 = RML_FETCH(RML_OFFSET(tmp599, 4));
	{ void *tmp598 = RML_OFFSET(tmp599, 5);
	RML_STORE(RML_OFFSET(tmp598, -1), tmp267);
	RML_STORE(RML_OFFSET(tmp598, -2), tmp356);
	RML_STORE(RML_OFFSET(tmp598, -3), tmp357);
	RML_STORE(RML_OFFSET(tmp598, -4), RML_LABVAL(assignment_2dsclam370));
	rmlA0 = RML_REFSTRINGLIT(lit1);
	rmlFC = tmp266;
	rmlSC = RML_OFFSET(tmp598, -4);
	rmlSP = RML_OFFSET(tmp598, -4);
	RML_TAILCALLQ(RML__print,1);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam370)
{

	{ void *tmp602 = rmlSC;
	{ void *tmp357 = RML_FETCH(RML_OFFSET(tmp602, 1));
	{ void *tmp356 = RML_FETCH(RML_OFFSET(tmp602, 2));
	{ void *tmp267 = RML_FETCH(RML_OFFSET(tmp602, 3));
	{ void *tmp601 = RML_OFFSET(tmp602, 4);
	rmlA1 = tmp357;
	rmlA0 = tmp356;
	rmlSC = tmp267;
	rmlSP = tmp601;
	RML_TAILCALL(RML_FETCH(tmp267),2);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment__evals)
{

	{ void *tmp271 = rmlSC;
	{ void *tmp270 = rmlFC;
	{ void *tmp570 = rmlSP;
	{ void *tmp273 = rmlA1;
	{ void *tmp477 = RML_FETCH(RML_UNTAGPTR(tmp273));
	switch( (rml_sint_t)tmp477 ) {
	case RML_STRUCTHDR(0,0):
	RML_TAILCALL(RML_FETCH(tmp271),1);
	/*case RML_STRUCTHDR(2,1)*/
	default:
	{ void *tmp478 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp273), 2));
	{ void *tmp479 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp273), 1));
	RML_STORE(RML_OFFSET(tmp570, -1), tmp270);
	RML_STORE(RML_OFFSET(tmp570, -2), tmp478);
	RML_STORE(RML_OFFSET(tmp570, -3), tmp271);
	RML_STORE(RML_OFFSET(tmp570, -4), RML_LABVAL(assignment_2dsclam505));
	rmlA1 = tmp479;
	rmlSC = RML_OFFSET(tmp570, -4);
	rmlSP = RML_OFFSET(tmp570, -4);
	RML_TAILCALLQ(assignment__eval,2);}}
	}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam505)
{

	{ void *tmp573 = rmlSC;
	{ void *tmp271 = RML_FETCH(RML_OFFSET(tmp573, 1));
	{ void *tmp478 = RML_FETCH(RML_OFFSET(tmp573, 2));
	{ void *tmp270 = RML_FETCH(RML_OFFSET(tmp573, 3));
	{ void *tmp572 = RML_OFFSET(tmp573, 4);
	{ void *tmp481 = rmlA0;
	{ void *tmp482 = rmlA1;
	RML_STORE(RML_OFFSET(tmp572, -1), tmp270);
	RML_STORE(RML_OFFSET(tmp572, -2), tmp481);
	RML_STORE(RML_OFFSET(tmp572, -3), tmp478);
	RML_STORE(RML_OFFSET(tmp572, -4), tmp271);
	RML_STORE(RML_OFFSET(tmp572, -5), RML_LABVAL(assignment_2dsclam504));
	rmlA0 = tmp482;
	rmlFC = tmp270;
	rmlSC = RML_OFFSET(tmp572, -5);
	rmlSP = RML_OFFSET(tmp572, -5);
	RML_TAILCALLQ(RML__int_5fstring,1);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam504)
{

	{ void *tmp576 = rmlSC;
	{ void *tmp271 = RML_FETCH(RML_OFFSET(tmp576, 1));
	{ void *tmp478 = RML_FETCH(RML_OFFSET(tmp576, 2));
	{ void *tmp481 = RML_FETCH(RML_OFFSET(tmp576, 3));
	{ void *tmp270 = RML_FETCH(RML_OFFSET(tmp576, 4));
	{ void *tmp575 = RML_OFFSET(tmp576, 5);
	{ void *tmp488 = rmlA0;
	RML_STORE(RML_OFFSET(tmp575, -1), tmp488);
	RML_STORE(RML_OFFSET(tmp575, -2), tmp270);
	RML_STORE(RML_OFFSET(tmp575, -3), tmp481);
	RML_STORE(RML_OFFSET(tmp575, -4), tmp478);
	RML_STORE(RML_OFFSET(tmp575, -5), tmp271);
	RML_STORE(RML_OFFSET(tmp575, -6), RML_LABVAL(assignment_2dsclam503));
	rmlA0 = RML_REFSTRINGLIT(lit0);
	rmlFC = tmp270;
	rmlSC = RML_OFFSET(tmp575, -6);
	rmlSP = RML_OFFSET(tmp575, -6);
	RML_TAILCALLQ(RML__print,1);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam503)
{

	{ void *tmp579 = rmlSC;
	{ void *tmp271 = RML_FETCH(RML_OFFSET(tmp579, 1));
	{ void *tmp478 = RML_FETCH(RML_OFFSET(tmp579, 2));
	{ void *tmp481 = RML_FETCH(RML_OFFSET(tmp579, 3));
	{ void *tmp270 = RML_FETCH(RML_OFFSET(tmp579, 4));
	{ void *tmp488 = RML_FETCH(RML_OFFSET(tmp579, 5));
	{ void *tmp578 = RML_OFFSET(tmp579, 6);
	RML_STORE(RML_OFFSET(tmp578, -1), tmp270);
	RML_STORE(RML_OFFSET(tmp578, -2), tmp481);
	RML_STORE(RML_OFFSET(tmp578, -3), tmp478);
	RML_STORE(RML_OFFSET(tmp578, -4), tmp271);
	RML_STORE(RML_OFFSET(tmp578, -5), RML_LABVAL(assignment_2dsclam502));
	rmlA0 = tmp488;
	rmlFC = tmp270;
	rmlSC = RML_OFFSET(tmp578, -5);
	rmlSP = RML_OFFSET(tmp578, -5);
	RML_TAILCALLQ(RML__print,1);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam502)
{

	{ void *tmp582 = rmlSC;
	{ void *tmp271 = RML_FETCH(RML_OFFSET(tmp582, 1));
	{ void *tmp478 = RML_FETCH(RML_OFFSET(tmp582, 2));
	{ void *tmp481 = RML_FETCH(RML_OFFSET(tmp582, 3));
	{ void *tmp270 = RML_FETCH(RML_OFFSET(tmp582, 4));
	{ void *tmp581 = RML_OFFSET(tmp582, 5);
	RML_STORE(RML_OFFSET(tmp581, -1), tmp481);
	RML_STORE(RML_OFFSET(tmp581, -2), tmp478);
	RML_STORE(RML_OFFSET(tmp581, -3), tmp270);
	RML_STORE(RML_OFFSET(tmp581, -4), tmp271);
	RML_STORE(RML_OFFSET(tmp581, -5), RML_LABVAL(assignment_2dsclam501));
	rmlA0 = RML_REFSTRINGLIT(lit1);
	rmlFC = tmp270;
	rmlSC = RML_OFFSET(tmp581, -5);
	rmlSP = RML_OFFSET(tmp581, -5);
	RML_TAILCALLQ(RML__print,1);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment_2dsclam501)
{

	{ void *tmp585 = rmlSC;
	{ void *tmp271 = RML_FETCH(RML_OFFSET(tmp585, 1));
	{ void *tmp270 = RML_FETCH(RML_OFFSET(tmp585, 2));
	{ void *tmp478 = RML_FETCH(RML_OFFSET(tmp585, 3));
	{ void *tmp481 = RML_FETCH(RML_OFFSET(tmp585, 4));
	{ void *tmp584 = RML_OFFSET(tmp585, 5);
	rmlA1 = tmp478;
	rmlA0 = tmp481;
	rmlFC = tmp270;
	rmlSC = tmp271;
	rmlSP = tmp584;
	RML_TAILCALLQ(assignment__evals,2);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(assignment__lookup)
{

	{ void *tmp259 = rmlSC;
	{ void *tmp258 = rmlFC;
	{ void *tmp260 = rmlA0;
	{ void *tmp261 = rmlA1;
	{ void *tmp516 = RML_FETCH(RML_UNTAGPTR(tmp260));
	switch( (rml_sint_t)tmp516 ) {
	case RML_STRUCTHDR(2,1):
	{ void *tmp517 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp260), 2));
	{ void *tmp518 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp260), 1));
	{ void *tmp519 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp518), 2));
	{ void *tmp520 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp518), 1));
	{ void *tmp521 = rml_prim_marker();
	{ void *tmp530 = rml_prim_equal(tmp261, tmp520);
	switch( (rml_sint_t)tmp530 ) {
	case RML_TAGFIXNUM(0):
	rml_prim_unwind(tmp521);
	rmlA0 = tmp517;
	RML_TAILCALLQ(assignment__lookup,2);
	default:
	rmlA0 = tmp519;
	RML_TAILCALL(RML_FETCH(tmp259),1);
	}}}}}}}
	default:
	RML_TAILCALL(RML_FETCH(tmp258),0);
	}}}}}}
}
RML_END_LABEL
