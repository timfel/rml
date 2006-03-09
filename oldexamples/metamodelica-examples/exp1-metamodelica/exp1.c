/* module exp1 */
#include "rml.h"
#include <stdlib.h>
#include <stdio.h>
RML_DEFINE_MODULE("exp1")

RML_FORWARD_LABEL(exp1__eval);
static RML_FORWARD_LABEL(exp1_2dsclam272);
static RML_FORWARD_LABEL(exp1_2dsclam271);
static RML_FORWARD_LABEL(exp1_2dsclam252);
static RML_FORWARD_LABEL(exp1_2dsclam251);
static RML_FORWARD_LABEL(exp1_2dsclam232);
static RML_FORWARD_LABEL(exp1_2dsclam219);
static RML_FORWARD_LABEL(exp1_2dsclam218);
static RML_FORWARD_LABEL(exp1_2dsclam199);
static RML_FORWARD_LABEL(exp1_2dsclam198);

static const RML_DEFSTRUCTLIT(lit0,1,0) {RML_IMMEDIATE(RML_TAGFIXNUM(10))}};
static const RML_DEFSTRUCTLIT(lit1,2,4) {RML_REFSTRUCTLIT(lit0),RML_REFSTRUCTLIT(lit0)}};

const struct rml_gval exp1__z = {{RML_REFSTRUCTLIT(lit1)},0,"exp1__z"};

extern void RML_5finit(void);

void exp1_5finit(void)
{
	static int done = 0;
	if( done ) return;
	done = 1;
	RML_5finit();
}

RML_BEGIN_LABEL(exp1__eval)
{

	{ void *tmp152 = rmlSC;
	{ void *tmp151 = rmlFC;
	{ void *tmp289 = rmlSP;
	{ void *tmp153 = rmlA0;
	{ void *tmp179 = RML_FETCH(RML_UNTAGPTR(tmp153));
	switch( RML_HDRCTOR((rml_uint_t)tmp179) ) {
	case 1:
	{ void *tmp180 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp153), 2));
	{ void *tmp181 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp153), 1));
	RML_STORE(RML_OFFSET(tmp289, -1), tmp180);
	RML_STORE(RML_OFFSET(tmp289, -2), tmp151);
	RML_STORE(RML_OFFSET(tmp289, -3), tmp152);
	RML_STORE(RML_OFFSET(tmp289, -4), RML_LABVAL(exp1_2dsclam199));
	rmlA0 = tmp181;
	rmlSC = RML_OFFSET(tmp289, -4);
	rmlSP = RML_OFFSET(tmp289, -4);
	RML_TAILCALLQ(exp1__eval,1);}}
	case 3:
	{ void *tmp200 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp153), 2));
	{ void *tmp201 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp153), 1));
	RML_STORE(RML_OFFSET(tmp289, -1), tmp200);
	RML_STORE(RML_OFFSET(tmp289, -2), tmp151);
	RML_STORE(RML_OFFSET(tmp289, -3), tmp152);
	RML_STORE(RML_OFFSET(tmp289, -4), RML_LABVAL(exp1_2dsclam219));
	rmlA0 = tmp201;
	rmlSC = RML_OFFSET(tmp289, -4);
	rmlSP = RML_OFFSET(tmp289, -4);
	RML_TAILCALLQ(exp1__eval,1);}}
	case 5:
	{ void *tmp220 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp153), 1));
	RML_STORE(RML_OFFSET(tmp289, -1), tmp152);
	RML_STORE(RML_OFFSET(tmp289, -2), RML_LABVAL(exp1_2dsclam232));
	rmlA0 = tmp220;
	rmlSC = RML_OFFSET(tmp289, -2);
	rmlSP = RML_OFFSET(tmp289, -2);
	RML_TAILCALLQ(exp1__eval,1);}
	case 4:
	{ void *tmp233 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp153), 2));
	{ void *tmp234 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp153), 1));
	RML_STORE(RML_OFFSET(tmp289, -1), tmp233);
	RML_STORE(RML_OFFSET(tmp289, -2), tmp151);
	RML_STORE(RML_OFFSET(tmp289, -3), tmp152);
	RML_STORE(RML_OFFSET(tmp289, -4), RML_LABVAL(exp1_2dsclam252));
	rmlA0 = tmp234;
	rmlSC = RML_OFFSET(tmp289, -4);
	rmlSP = RML_OFFSET(tmp289, -4);
	RML_TAILCALLQ(exp1__eval,1);}}
	case 2:
	{ void *tmp253 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp153), 2));
	{ void *tmp254 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp153), 1));
	RML_STORE(RML_OFFSET(tmp289, -1), tmp253);
	RML_STORE(RML_OFFSET(tmp289, -2), tmp151);
	RML_STORE(RML_OFFSET(tmp289, -3), tmp152);
	RML_STORE(RML_OFFSET(tmp289, -4), RML_LABVAL(exp1_2dsclam272));
	rmlA0 = tmp254;
	rmlSC = RML_OFFSET(tmp289, -4);
	rmlSP = RML_OFFSET(tmp289, -4);
	RML_TAILCALLQ(exp1__eval,1);}}
	/*case 0*/
	default:
	{ void *tmp273 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp153), 1));
	rmlA0 = tmp273;
	RML_TAILCALL(RML_FETCH(tmp152),1);}
	}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp1_2dsclam272)
{

	{ void *tmp313 = rmlSC;
	{ void *tmp152 = RML_FETCH(RML_OFFSET(tmp313, 1));
	{ void *tmp151 = RML_FETCH(RML_OFFSET(tmp313, 2));
	{ void *tmp253 = RML_FETCH(RML_OFFSET(tmp313, 3));
	{ void *tmp312 = RML_OFFSET(tmp313, 4);
	{ void *tmp256 = rmlA0;
	RML_STORE(RML_OFFSET(tmp312, -1), tmp256);
	RML_STORE(RML_OFFSET(tmp312, -2), tmp152);
	RML_STORE(RML_OFFSET(tmp312, -3), RML_LABVAL(exp1_2dsclam271));
	rmlA0 = tmp253;
	rmlFC = tmp151;
	rmlSC = RML_OFFSET(tmp312, -3);
	rmlSP = RML_OFFSET(tmp312, -3);
	RML_TAILCALLQ(exp1__eval,1);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp1_2dsclam271)
{

	{ void *tmp316 = rmlSC;
	{ void *tmp152 = RML_FETCH(RML_OFFSET(tmp316, 1));
	{ void *tmp256 = RML_FETCH(RML_OFFSET(tmp316, 2));
	{ void *tmp315 = RML_OFFSET(tmp316, 3);
	{ void *tmp261 = rmlA0;
	{ void *tmp287 = RML_PRIM_INT_SUB(tmp256, tmp261);
	rmlA0 = tmp287;
	rmlSC = tmp152;
	rmlSP = tmp315;
	RML_TAILCALL(RML_FETCH(tmp152),1);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp1_2dsclam252)
{

	{ void *tmp307 = rmlSC;
	{ void *tmp152 = RML_FETCH(RML_OFFSET(tmp307, 1));
	{ void *tmp151 = RML_FETCH(RML_OFFSET(tmp307, 2));
	{ void *tmp233 = RML_FETCH(RML_OFFSET(tmp307, 3));
	{ void *tmp306 = RML_OFFSET(tmp307, 4);
	{ void *tmp236 = rmlA0;
	RML_STORE(RML_OFFSET(tmp306, -1), tmp151);
	RML_STORE(RML_OFFSET(tmp306, -2), tmp236);
	RML_STORE(RML_OFFSET(tmp306, -3), tmp152);
	RML_STORE(RML_OFFSET(tmp306, -4), RML_LABVAL(exp1_2dsclam251));
	rmlA0 = tmp233;
	rmlFC = tmp151;
	rmlSC = RML_OFFSET(tmp306, -4);
	rmlSP = RML_OFFSET(tmp306, -4);
	RML_TAILCALLQ(exp1__eval,1);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp1_2dsclam251)
{

	{ void *tmp310 = rmlSC;
	{ void *tmp152 = RML_FETCH(RML_OFFSET(tmp310, 1));
	{ void *tmp236 = RML_FETCH(RML_OFFSET(tmp310, 2));
	{ void *tmp151 = RML_FETCH(RML_OFFSET(tmp310, 3));
	{ void *tmp309 = RML_OFFSET(tmp310, 4);
	{ void *tmp241 = rmlA0;
	switch( (rml_sint_t)tmp241 ) {
	case RML_TAGFIXNUM(0):
	rmlFC = tmp151;
	rmlSP = tmp309;
	RML_TAILCALL(RML_FETCH(tmp151),0);
	default:
	{ void *tmp284 = RML_PRIM_INT_DIV(tmp236, tmp241);
	rmlA0 = tmp284;
	rmlSC = tmp152;
	rmlSP = tmp309;
	RML_TAILCALL(RML_FETCH(tmp152),1);}
	}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp1_2dsclam232)
{

	{ void *tmp304 = rmlSC;
	{ void *tmp152 = RML_FETCH(RML_OFFSET(tmp304, 1));
	{ void *tmp303 = RML_OFFSET(tmp304, 2);
	{ void *tmp222 = rmlA0;
	{ void *tmp281 = RML_PRIM_INT_NEG(tmp222);
	rmlA0 = tmp281;
	rmlSC = tmp152;
	rmlSP = tmp303;
	RML_TAILCALL(RML_FETCH(tmp152),1);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp1_2dsclam219)
{

	{ void *tmp298 = rmlSC;
	{ void *tmp152 = RML_FETCH(RML_OFFSET(tmp298, 1));
	{ void *tmp151 = RML_FETCH(RML_OFFSET(tmp298, 2));
	{ void *tmp200 = RML_FETCH(RML_OFFSET(tmp298, 3));
	{ void *tmp297 = RML_OFFSET(tmp298, 4);
	{ void *tmp203 = rmlA0;
	RML_STORE(RML_OFFSET(tmp297, -1), tmp203);
	RML_STORE(RML_OFFSET(tmp297, -2), tmp152);
	RML_STORE(RML_OFFSET(tmp297, -3), RML_LABVAL(exp1_2dsclam218));
	rmlA0 = tmp200;
	rmlFC = tmp151;
	rmlSC = RML_OFFSET(tmp297, -3);
	rmlSP = RML_OFFSET(tmp297, -3);
	RML_TAILCALLQ(exp1__eval,1);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp1_2dsclam218)
{

	{ void *tmp301 = rmlSC;
	{ void *tmp152 = RML_FETCH(RML_OFFSET(tmp301, 1));
	{ void *tmp203 = RML_FETCH(RML_OFFSET(tmp301, 2));
	{ void *tmp300 = RML_OFFSET(tmp301, 3);
	{ void *tmp208 = rmlA0;
	{ void *tmp279 = RML_PRIM_INT_MUL(tmp203, tmp208);
	rmlA0 = tmp279;
	rmlSC = tmp152;
	rmlSP = tmp300;
	RML_TAILCALL(RML_FETCH(tmp152),1);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp1_2dsclam199)
{

	{ void *tmp292 = rmlSC;
	{ void *tmp152 = RML_FETCH(RML_OFFSET(tmp292, 1));
	{ void *tmp151 = RML_FETCH(RML_OFFSET(tmp292, 2));
	{ void *tmp180 = RML_FETCH(RML_OFFSET(tmp292, 3));
	{ void *tmp291 = RML_OFFSET(tmp292, 4);
	{ void *tmp183 = rmlA0;
	RML_STORE(RML_OFFSET(tmp291, -1), tmp183);
	RML_STORE(RML_OFFSET(tmp291, -2), tmp152);
	RML_STORE(RML_OFFSET(tmp291, -3), RML_LABVAL(exp1_2dsclam198));
	rmlA0 = tmp180;
	rmlFC = tmp151;
	rmlSC = RML_OFFSET(tmp291, -3);
	rmlSP = RML_OFFSET(tmp291, -3);
	RML_TAILCALLQ(exp1__eval,1);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(exp1_2dsclam198)
{

	{ void *tmp295 = rmlSC;
	{ void *tmp152 = RML_FETCH(RML_OFFSET(tmp295, 1));
	{ void *tmp183 = RML_FETCH(RML_OFFSET(tmp295, 2));
	{ void *tmp294 = RML_OFFSET(tmp295, 3);
	{ void *tmp188 = rmlA0;
	{ void *tmp276 = RML_PRIM_INT_ADD(tmp183, tmp188);
	rmlA0 = tmp276;
	rmlSC = tmp152;
	rmlSP = tmp294;
	RML_TAILCALL(RML_FETCH(tmp152),1);}}}}}}
}
RML_END_LABEL
