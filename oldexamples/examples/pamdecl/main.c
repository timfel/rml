/* module Main */
#include "rml.h"
#include <stdlib.h>
#include <stdio.h>
RML_DEFINE_MODULE("Main")
extern RML_FORWARD_LABEL(ScanParse__scanparse);
extern RML_FORWARD_LABEL(RML__debug_5fpush_5fout01);
extern RML_FORWARD_LABEL(RML__debug_5fpush_5fin01);
extern RML_FORWARD_LABEL(RML__debug);
extern RML_FORWARD_LABEL(Eval__evalprog);

RML_FORWARD_LABEL(Main__main);
static RML_FORWARD_LABEL(Main_2dsclam125);
static RML_FORWARD_LABEL(Main_2dsclam124);
static RML_FORWARD_LABEL(Main_2dsclam123);
static RML_FORWARD_LABEL(Main_2dsclam122);
static RML_FORWARD_LABEL(Main_2dsclam121);

static const RML_DEFSTRINGLIT(lit0,8,"main.rml");
static const RML_DEFSTRINGLIT(lit1,4,"main");
static const RML_DEFSTRINGLIT(lit2,35,"call:ScanParse.scanparse() => (ast)");
static const RML_DEFSTRINGLIT(lit3,3,"ast");
static const RML_DEFSTRINGLIT(lit4,29,"call:Eval.evalprog(ast) => ()");

extern void ScanParse_5finit(void);
extern void Eval_5finit(void);
extern void RML_5finit(void);

void Main_5finit(void)
{
	static int done = 0;
	if( done ) return;
	done = 1;
	ScanParse_5finit();
	Eval_5finit();
	RML_5finit();
	rmldb_load_db("main.rdb");
}

RML_BEGIN_LABEL(Main__main)
{

	{ void *tmp106 = rmlSC;
	{ void *tmp105 = rmlFC;
	{ void *tmp127 = rmlSP;
	RML_STORE(RML_OFFSET(tmp127, -1), tmp105);
	RML_STORE(RML_OFFSET(tmp127, -2), tmp106);
	RML_STORE(RML_OFFSET(tmp127, -3), RML_LABVAL(Main_2dsclam125));
	rmlA6 = RML_REFSTRINGLIT(lit2);
	rmlA5 = RML_REFSTRINGLIT(lit1);
	rmlA4 = RML_IMMEDIATE(RML_TAGFIXNUM(30));
	rmlA3 = RML_IMMEDIATE(RML_TAGFIXNUM(10));
	rmlA2 = RML_IMMEDIATE(RML_TAGFIXNUM(9));
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(10));
	rmlA0 = RML_REFSTRINGLIT(lit0);
	rmlSC = RML_OFFSET(tmp127, -3);
	rmlSP = RML_OFFSET(tmp127, -3);
	RML_TAILCALLQ(RML__debug,7);}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam125)
{

	{ void *tmp130 = rmlSC;
	{ void *tmp106 = RML_FETCH(RML_OFFSET(tmp130, 1));
	{ void *tmp105 = RML_FETCH(RML_OFFSET(tmp130, 2));
	{ void *tmp129 = RML_OFFSET(tmp130, 3);
	RML_STORE(RML_OFFSET(tmp129, -1), tmp105);
	RML_STORE(RML_OFFSET(tmp129, -2), tmp106);
	RML_STORE(RML_OFFSET(tmp129, -3), RML_LABVAL(Main_2dsclam124));
	rmlFC = tmp105;
	rmlSC = RML_OFFSET(tmp129, -3);
	rmlSP = RML_OFFSET(tmp129, -3);
	RML_TAILCALLQ(ScanParse__scanparse,0);}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam124)
{

	{ void *tmp133 = rmlSC;
	{ void *tmp106 = RML_FETCH(RML_OFFSET(tmp133, 1));
	{ void *tmp105 = RML_FETCH(RML_OFFSET(tmp133, 2));
	{ void *tmp132 = RML_OFFSET(tmp133, 3);
	{ void *tmp112 = rmlA0;
	RML_STORE(RML_OFFSET(tmp132, -1), tmp112);
	RML_STORE(RML_OFFSET(tmp132, -2), tmp105);
	RML_STORE(RML_OFFSET(tmp132, -3), tmp106);
	RML_STORE(RML_OFFSET(tmp132, -4), RML_LABVAL(Main_2dsclam123));
	rmlA1 = tmp112;
	rmlA0 = RML_REFSTRINGLIT(lit3);
	rmlFC = tmp105;
	rmlSC = RML_OFFSET(tmp132, -4);
	rmlSP = RML_OFFSET(tmp132, -4);
	RML_TAILCALLQ(RML__debug_5fpush_5fout01,2);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam123)
{

	{ void *tmp136 = rmlSC;
	{ void *tmp106 = RML_FETCH(RML_OFFSET(tmp136, 1));
	{ void *tmp105 = RML_FETCH(RML_OFFSET(tmp136, 2));
	{ void *tmp112 = RML_FETCH(RML_OFFSET(tmp136, 3));
	{ void *tmp135 = RML_OFFSET(tmp136, 4);
	RML_STORE(RML_OFFSET(tmp135, -1), tmp105);
	RML_STORE(RML_OFFSET(tmp135, -2), tmp112);
	RML_STORE(RML_OFFSET(tmp135, -3), tmp106);
	RML_STORE(RML_OFFSET(tmp135, -4), RML_LABVAL(Main_2dsclam122));
	rmlA1 = tmp112;
	rmlA0 = RML_REFSTRINGLIT(lit3);
	rmlFC = tmp105;
	rmlSC = RML_OFFSET(tmp135, -4);
	rmlSP = RML_OFFSET(tmp135, -4);
	RML_TAILCALLQ(RML__debug_5fpush_5fin01,2);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam122)
{

	{ void *tmp139 = rmlSC;
	{ void *tmp106 = RML_FETCH(RML_OFFSET(tmp139, 1));
	{ void *tmp112 = RML_FETCH(RML_OFFSET(tmp139, 2));
	{ void *tmp105 = RML_FETCH(RML_OFFSET(tmp139, 3));
	{ void *tmp138 = RML_OFFSET(tmp139, 4);
	RML_STORE(RML_OFFSET(tmp138, -1), tmp112);
	RML_STORE(RML_OFFSET(tmp138, -2), tmp105);
	RML_STORE(RML_OFFSET(tmp138, -3), tmp106);
	RML_STORE(RML_OFFSET(tmp138, -4), RML_LABVAL(Main_2dsclam121));
	rmlA6 = RML_REFSTRINGLIT(lit4);
	rmlA5 = RML_REFSTRINGLIT(lit1);
	rmlA4 = RML_IMMEDIATE(RML_TAGFIXNUM(25));
	rmlA3 = RML_IMMEDIATE(RML_TAGFIXNUM(11));
	rmlA2 = RML_IMMEDIATE(RML_TAGFIXNUM(9));
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(11));
	rmlA0 = RML_REFSTRINGLIT(lit0);
	rmlFC = tmp105;
	rmlSC = RML_OFFSET(tmp138, -4);
	rmlSP = RML_OFFSET(tmp138, -4);
	RML_TAILCALLQ(RML__debug,7);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam121)
{

	{ void *tmp142 = rmlSC;
	{ void *tmp106 = RML_FETCH(RML_OFFSET(tmp142, 1));
	{ void *tmp105 = RML_FETCH(RML_OFFSET(tmp142, 2));
	{ void *tmp112 = RML_FETCH(RML_OFFSET(tmp142, 3));
	{ void *tmp141 = RML_OFFSET(tmp142, 4);
	rmlA0 = tmp112;
	rmlFC = tmp105;
	rmlSC = tmp106;
	rmlSP = tmp141;
	RML_TAILCALLQ(Eval__evalprog,1);}}}}}
}
RML_END_LABEL
