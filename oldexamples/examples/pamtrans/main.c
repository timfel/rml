/* module Main */
#include "rml.h"
#include <stdlib.h>
#include <stdio.h>
RML_DEFINE_MODULE("Main")
extern RML_FORWARD_LABEL(Parse__parse);
extern RML_FORWARD_LABEL(Trans__trans_5fprogram);
extern RML_FORWARD_LABEL(Emit__emit_5fassembly);

RML_FORWARD_LABEL(Main__main);
static RML_FORWARD_LABEL(Main_2dsclam120);
static RML_FORWARD_LABEL(Main_2dsclam119);

extern void Trans_5finit(void);
extern void Parse_5finit(void);
extern void Emit_5finit(void);
extern void RML_5finit(void);

void Main_5finit(void)
{
	static int done = 0;
	if( done ) return;
	done = 1;
	Trans_5finit();
	Parse_5finit();
	Emit_5finit();
	RML_5finit();
}

RML_BEGIN_LABEL(Main__main)
{

	{ void *tmp106 = rmlSC;
	{ void *tmp105 = rmlFC;
	{ void *tmp122 = rmlSP;
	RML_STORE(RML_OFFSET(tmp122, -1), tmp105);
	RML_STORE(RML_OFFSET(tmp122, -2), tmp106);
	RML_STORE(RML_OFFSET(tmp122, -3), RML_LABVAL(Main_2dsclam120));
	rmlSC = RML_OFFSET(tmp122, -3);
	rmlSP = RML_OFFSET(tmp122, -3);
	RML_TAILCALLQ(Parse__parse,0);}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam120)
{

	{ void *tmp125 = rmlSC;
	{ void *tmp106 = RML_FETCH(RML_OFFSET(tmp125, 1));
	{ void *tmp105 = RML_FETCH(RML_OFFSET(tmp125, 2));
	{ void *tmp124 = RML_OFFSET(tmp125, 3);
	RML_STORE(RML_OFFSET(tmp124, -1), tmp105);
	RML_STORE(RML_OFFSET(tmp124, -2), tmp106);
	RML_STORE(RML_OFFSET(tmp124, -3), RML_LABVAL(Main_2dsclam119));
	rmlFC = tmp105;
	rmlSC = RML_OFFSET(tmp124, -3);
	rmlSP = RML_OFFSET(tmp124, -3);
	RML_TAILCALLQ(Trans__trans_5fprogram,1);}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam119)
{

	{ void *tmp128 = rmlSC;
	{ void *tmp106 = RML_FETCH(RML_OFFSET(tmp128, 1));
	{ void *tmp105 = RML_FETCH(RML_OFFSET(tmp128, 2));
	{ void *tmp127 = RML_OFFSET(tmp128, 3);
	rmlFC = tmp105;
	rmlSC = tmp106;
	rmlSP = tmp127;
	RML_TAILCALLQ(Emit__emit_5fassembly,1);}}}}
}
RML_END_LABEL
