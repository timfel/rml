/* module Main */
#include "rml.h"
#include <stdlib.h>
#include <stdio.h>
RML_DEFINE_MODULE("Main")
extern RML_FORWARD_LABEL(RML__int_5fstring);
extern RML_FORWARD_LABEL(RML__print);

RML_FORWARD_LABEL(Main__main);
static RML_FORWARD_LABEL(Main_2dsclam192);
static RML_FORWARD_LABEL(Main_2dsclam190);
static RML_FORWARD_LABEL(Main_2dsclam189);
static RML_FORWARD_LABEL(Main_2dsclam188);
static RML_FORWARD_LABEL(Main_2dsclam187);
static RML_FORWARD_LABEL(Main__walk);
static RML_FORWARD_LABEL(Main_2dsclam211);
static RML_FORWARD_LABEL(Main_2dsclam210);

static const RML_DEFSTRUCT0LIT(lit0,0);
static const RML_DEFSTRINGLIT(lit1,1,"1");
static const RML_DEFSTRUCTLIT(lit2,3,1) {RML_REFSTRUCTLIT(lit0),RML_REFSTRINGLIT(lit1),RML_REFSTRUCTLIT(lit0)}};
static const RML_DEFSTRINGLIT(lit3,1,"2");
static const RML_DEFSTRINGLIT(lit4,1,"3");
static const RML_DEFSTRUCTLIT(lit5,3,1) {RML_REFSTRUCTLIT(lit0),RML_REFSTRINGLIT(lit4),RML_REFSTRUCTLIT(lit0)}};
static const RML_DEFSTRUCTLIT(lit6,3,1) {RML_REFSTRUCTLIT(lit2),RML_REFSTRINGLIT(lit3),RML_REFSTRUCTLIT(lit5)}};

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

	{ void *tmp137 = rmlSC;
	{ void *tmp136 = rmlFC;
	{ void *tmp221 = rmlSP;
	RML_STORE(RML_OFFSET(tmp221, -1), tmp136);
	RML_STORE(RML_OFFSET(tmp221, -2), tmp137);
	RML_STORE(RML_OFFSET(tmp221, -3), RML_LABVAL(Main_2dsclam192));
	rmlA0 = RML_IMMEDIATE(RML_TAGFIXNUM(2));
	rmlSC = RML_OFFSET(tmp221, -3);
	rmlSP = RML_OFFSET(tmp221, -3);
	RML_TAILCALLQ(RML__int_5fstring,1);}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam192)
{
	void *tmp222;
	RML_ALLOC(tmp222,3,1,Main_2dsclam192);
	{ void *tmp224 = rmlSC;
	{ void *tmp137 = RML_FETCH(RML_OFFSET(tmp224, 1));
	{ void *tmp136 = RML_FETCH(RML_OFFSET(tmp224, 2));
	{ void *tmp223 = RML_OFFSET(tmp224, 3);
	{ void *tmp151 = rmlA0;
	RML_STORE(tmp222, RML_IMMEDIATE(RML_STRUCTHDR(2,0)));
	RML_STORE(RML_OFFSET(tmp222, 1), tmp151);
	RML_STORE(RML_OFFSET(tmp222, 2), tmp151);
	{ void *tmp143 = RML_TAGPTR(tmp222);
	{ void *tmp170 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp143), 2));
	{ void *tmp171 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp143), 1));
	{ void *tmp178 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp143), 2));
	{ void *tmp179 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp143), 1));
	{ void *tmp180 = rml_prim_equal(tmp143, tmp143);
	switch( (rml_sint_t)tmp180 ) {
	case RML_TAGFIXNUM(0):
	rmlFC = tmp136;
	rmlSP = tmp223;
	RML_TAILCALL(RML_FETCH(tmp136),0);
	default:
	RML_STORE(RML_OFFSET(tmp223, -1), tmp170);
	RML_STORE(RML_OFFSET(tmp223, -2), tmp136);
	RML_STORE(RML_OFFSET(tmp223, -3), tmp179);
	RML_STORE(RML_OFFSET(tmp223, -4), tmp178);
	RML_STORE(RML_OFFSET(tmp223, -5), tmp137);
	RML_STORE(RML_OFFSET(tmp223, -6), RML_LABVAL(Main_2dsclam190));
	rmlA0 = tmp171;
	rmlFC = tmp136;
	rmlSC = RML_OFFSET(tmp223, -6);
	rmlSP = RML_OFFSET(tmp223, -6);
	RML_TAILCALLQ(RML__print,1);
	}}}}}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam190)
{

	{ void *tmp227 = rmlSC;
	{ void *tmp137 = RML_FETCH(RML_OFFSET(tmp227, 1));
	{ void *tmp178 = RML_FETCH(RML_OFFSET(tmp227, 2));
	{ void *tmp179 = RML_FETCH(RML_OFFSET(tmp227, 3));
	{ void *tmp136 = RML_FETCH(RML_OFFSET(tmp227, 4));
	{ void *tmp170 = RML_FETCH(RML_OFFSET(tmp227, 5));
	{ void *tmp226 = RML_OFFSET(tmp227, 6);
	RML_STORE(RML_OFFSET(tmp226, -1), tmp179);
	RML_STORE(RML_OFFSET(tmp226, -2), tmp136);
	RML_STORE(RML_OFFSET(tmp226, -3), tmp178);
	RML_STORE(RML_OFFSET(tmp226, -4), tmp137);
	RML_STORE(RML_OFFSET(tmp226, -5), RML_LABVAL(Main_2dsclam189));
	rmlA0 = tmp170;
	rmlFC = tmp136;
	rmlSC = RML_OFFSET(tmp226, -5);
	rmlSP = RML_OFFSET(tmp226, -5);
	RML_TAILCALLQ(RML__print,1);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam189)
{

	{ void *tmp230 = rmlSC;
	{ void *tmp137 = RML_FETCH(RML_OFFSET(tmp230, 1));
	{ void *tmp178 = RML_FETCH(RML_OFFSET(tmp230, 2));
	{ void *tmp136 = RML_FETCH(RML_OFFSET(tmp230, 3));
	{ void *tmp179 = RML_FETCH(RML_OFFSET(tmp230, 4));
	{ void *tmp229 = RML_OFFSET(tmp230, 5);
	RML_STORE(RML_OFFSET(tmp229, -1), tmp178);
	RML_STORE(RML_OFFSET(tmp229, -2), tmp136);
	RML_STORE(RML_OFFSET(tmp229, -3), tmp137);
	RML_STORE(RML_OFFSET(tmp229, -4), RML_LABVAL(Main_2dsclam188));
	rmlA0 = tmp179;
	rmlFC = tmp136;
	rmlSC = RML_OFFSET(tmp229, -4);
	rmlSP = RML_OFFSET(tmp229, -4);
	RML_TAILCALLQ(RML__print,1);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam188)
{

	{ void *tmp233 = rmlSC;
	{ void *tmp137 = RML_FETCH(RML_OFFSET(tmp233, 1));
	{ void *tmp136 = RML_FETCH(RML_OFFSET(tmp233, 2));
	{ void *tmp178 = RML_FETCH(RML_OFFSET(tmp233, 3));
	{ void *tmp232 = RML_OFFSET(tmp233, 4);
	RML_STORE(RML_OFFSET(tmp232, -1), tmp136);
	RML_STORE(RML_OFFSET(tmp232, -2), tmp137);
	RML_STORE(RML_OFFSET(tmp232, -3), RML_LABVAL(Main_2dsclam187));
	rmlA0 = tmp178;
	rmlFC = tmp136;
	rmlSC = RML_OFFSET(tmp232, -3);
	rmlSP = RML_OFFSET(tmp232, -3);
	RML_TAILCALLQ(RML__print,1);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam187)
{

	{ void *tmp236 = rmlSC;
	{ void *tmp137 = RML_FETCH(RML_OFFSET(tmp236, 1));
	{ void *tmp136 = RML_FETCH(RML_OFFSET(tmp236, 2));
	{ void *tmp235 = RML_OFFSET(tmp236, 3);
	rmlA0 = RML_REFSTRUCTLIT(lit6);
	rmlFC = tmp136;
	rmlSC = tmp137;
	rmlSP = tmp235;
	RML_TAILCALLQ(Main__walk,1);}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main__walk)
{

	{ void *tmp130 = rmlSC;
	{ void *tmp129 = rmlFC;
	{ void *tmp213 = rmlSP;
	{ void *tmp131 = rmlA0;
	{ void *tmp202 = RML_FETCH(RML_UNTAGPTR(tmp131));
	switch( (rml_sint_t)tmp202 ) {
	case RML_STRUCTHDR(0,0):
	RML_TAILCALL(RML_FETCH(tmp130),0);
	/*case RML_STRUCTHDR(3,1)*/
	default:
	{ void *tmp203 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp131), 3));
	{ void *tmp204 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp131), 2));
	{ void *tmp205 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp131), 1));
	RML_STORE(RML_OFFSET(tmp213, -1), tmp204);
	RML_STORE(RML_OFFSET(tmp213, -2), tmp129);
	RML_STORE(RML_OFFSET(tmp213, -3), tmp203);
	RML_STORE(RML_OFFSET(tmp213, -4), tmp130);
	RML_STORE(RML_OFFSET(tmp213, -5), RML_LABVAL(Main_2dsclam211));
	rmlA0 = tmp205;
	rmlSC = RML_OFFSET(tmp213, -5);
	rmlSP = RML_OFFSET(tmp213, -5);
	RML_TAILCALLQ(Main__walk,1);}}}
	}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam211)
{

	{ void *tmp216 = rmlSC;
	{ void *tmp130 = RML_FETCH(RML_OFFSET(tmp216, 1));
	{ void *tmp203 = RML_FETCH(RML_OFFSET(tmp216, 2));
	{ void *tmp129 = RML_FETCH(RML_OFFSET(tmp216, 3));
	{ void *tmp204 = RML_FETCH(RML_OFFSET(tmp216, 4));
	{ void *tmp215 = RML_OFFSET(tmp216, 5);
	RML_STORE(RML_OFFSET(tmp215, -1), tmp203);
	RML_STORE(RML_OFFSET(tmp215, -2), tmp129);
	RML_STORE(RML_OFFSET(tmp215, -3), tmp130);
	RML_STORE(RML_OFFSET(tmp215, -4), RML_LABVAL(Main_2dsclam210));
	rmlA0 = tmp204;
	rmlFC = tmp129;
	rmlSC = RML_OFFSET(tmp215, -4);
	rmlSP = RML_OFFSET(tmp215, -4);
	RML_TAILCALLQ(RML__print,1);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam210)
{

	{ void *tmp219 = rmlSC;
	{ void *tmp130 = RML_FETCH(RML_OFFSET(tmp219, 1));
	{ void *tmp129 = RML_FETCH(RML_OFFSET(tmp219, 2));
	{ void *tmp203 = RML_FETCH(RML_OFFSET(tmp219, 3));
	{ void *tmp218 = RML_OFFSET(tmp219, 4);
	rmlA0 = tmp203;
	rmlFC = tmp129;
	rmlSC = tmp130;
	rmlSP = tmp218;
	RML_TAILCALLQ(Main__walk,1);}}}}}
}
RML_END_LABEL
