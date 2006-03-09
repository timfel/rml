/* module Eval */
#include "rml.h"
#include <stdlib.h>
#include <stdio.h>
RML_DEFINE_MODULE("Eval")
extern RML_FORWARD_LABEL(RML__print);
extern RML_FORWARD_LABEL(RML__int_5freal);

RML_FORWARD_LABEL(Eval__relz);
static RML_FORWARD_LABEL(Eval_2dsclam147);
static RML_FORWARD_LABEL(Eval_2dsclam146);
RML_FORWARD_LABEL(Eval__rely);
static RML_FORWARD_LABEL(Eval_2dsclam159);
static RML_FORWARD_LABEL(Eval_2dsclam158);

extern void RML_5finit(void);

void Eval_5finit(void)
{
	static int done = 0;
	if( done ) return;
	done = 1;
	RML_5finit();
}

RML_BEGIN_LABEL(Eval__relz)
{

	{ void *tmp122 = rmlSC;
	{ void *tmp121 = rmlFC;
	{ void *tmp169 = rmlSP;
	{ void *tmp123 = rmlA0;
	{ void *tmp133 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp123), 2));
	{ void *tmp134 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp123), 1));
	RML_STORE(RML_OFFSET(tmp169, -1), tmp133);
	RML_STORE(RML_OFFSET(tmp169, -2), tmp121);
	RML_STORE(RML_OFFSET(tmp169, -3), tmp134);
	RML_STORE(RML_OFFSET(tmp169, -4), tmp122);
	RML_STORE(RML_OFFSET(tmp169, -5), RML_LABVAL(Eval_2dsclam147));
	rmlA0 = tmp134;
	rmlSC = RML_OFFSET(tmp169, -5);
	rmlSP = RML_OFFSET(tmp169, -5);
	RML_TAILCALLQ(RML__print,1);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Eval_2dsclam147)
{

	{ void *tmp172 = rmlSC;
	{ void *tmp122 = RML_FETCH(RML_OFFSET(tmp172, 1));
	{ void *tmp134 = RML_FETCH(RML_OFFSET(tmp172, 2));
	{ void *tmp121 = RML_FETCH(RML_OFFSET(tmp172, 3));
	{ void *tmp133 = RML_FETCH(RML_OFFSET(tmp172, 4));
	{ void *tmp171 = RML_OFFSET(tmp172, 5);
	RML_STORE(RML_OFFSET(tmp171, -1), tmp134);
	RML_STORE(RML_OFFSET(tmp171, -2), tmp122);
	RML_STORE(RML_OFFSET(tmp171, -3), RML_LABVAL(Eval_2dsclam146));
	rmlA0 = tmp133;
	rmlFC = tmp121;
	rmlSC = RML_OFFSET(tmp171, -3);
	rmlSP = RML_OFFSET(tmp171, -3);
	RML_TAILCALLQ(RML__int_5freal,1);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Eval_2dsclam146)
{
	void *tmp173;
	RML_ALLOC(tmp173,3,1,Eval_2dsclam146);
	{ void *tmp175 = rmlSC;
	{ void *tmp122 = RML_FETCH(RML_OFFSET(tmp175, 1));
	{ void *tmp134 = RML_FETCH(RML_OFFSET(tmp175, 2));
	{ void *tmp174 = RML_OFFSET(tmp175, 3);
	{ void *tmp137 = rmlA0;
	RML_STORE(tmp173, RML_IMMEDIATE(RML_STRUCTHDR(2,0)));
	RML_STORE(RML_OFFSET(tmp173, 1), tmp134);
	RML_STORE(RML_OFFSET(tmp173, 2), tmp137);
	{ void *tmp141 = RML_TAGPTR(tmp173);
	rmlA0 = tmp141;
	rmlSC = tmp122;
	rmlSP = tmp174;
	RML_TAILCALL(RML_FETCH(tmp122),1);}}}}}}
}
RML_END_LABEL

RML_BEGIN_LABEL(Eval__rely)
{

	{ void *tmp118 = rmlSC;
	{ void *tmp117 = rmlFC;
	{ void *tmp161 = rmlSP;
	{ void *tmp119 = rmlA0;
	{ void *tmp120 = rmlA1;
	RML_STORE(RML_OFFSET(tmp161, -1), tmp120);
	RML_STORE(RML_OFFSET(tmp161, -2), tmp117);
	RML_STORE(RML_OFFSET(tmp161, -3), tmp118);
	RML_STORE(RML_OFFSET(tmp161, -4), tmp119);
	RML_STORE(RML_OFFSET(tmp161, -5), RML_LABVAL(Eval_2dsclam159));
	rmlSC = RML_OFFSET(tmp161, -5);
	rmlSP = RML_OFFSET(tmp161, -5);
	RML_TAILCALLQ(RML__print,1);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Eval_2dsclam159)
{

	{ void *tmp164 = rmlSC;
	{ void *tmp119 = RML_FETCH(RML_OFFSET(tmp164, 1));
	{ void *tmp118 = RML_FETCH(RML_OFFSET(tmp164, 2));
	{ void *tmp117 = RML_FETCH(RML_OFFSET(tmp164, 3));
	{ void *tmp120 = RML_FETCH(RML_OFFSET(tmp164, 4));
	{ void *tmp163 = RML_OFFSET(tmp164, 5);
	RML_STORE(RML_OFFSET(tmp163, -1), tmp118);
	RML_STORE(RML_OFFSET(tmp163, -2), tmp119);
	RML_STORE(RML_OFFSET(tmp163, -3), RML_LABVAL(Eval_2dsclam158));
	rmlA0 = tmp120;
	rmlFC = tmp117;
	rmlSC = RML_OFFSET(tmp163, -3);
	rmlSP = RML_OFFSET(tmp163, -3);
	RML_TAILCALLQ(RML__int_5freal,1);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Eval_2dsclam158)
{

	{ void *tmp167 = rmlSC;
	{ void *tmp119 = RML_FETCH(RML_OFFSET(tmp167, 1));
	{ void *tmp118 = RML_FETCH(RML_OFFSET(tmp167, 2));
	{ void *tmp166 = RML_OFFSET(tmp167, 3);
	{ void *tmp154 = rmlA0;
	rmlA1 = tmp154;
	rmlA0 = tmp119;
	rmlSC = tmp118;
	rmlSP = tmp166;
	RML_TAILCALL(RML_FETCH(tmp118),2);}}}}}
}
RML_END_LABEL
