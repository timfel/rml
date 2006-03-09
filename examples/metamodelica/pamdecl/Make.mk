

# VARIABLES

GOROOT = ../../..
 
SHELL = /bin/sh
LDLIBS = -lrml -lfl

 
# EVERYTHING
all:    pamdecl
 
# EXECUTABLE
 
COMMONOBJS=yacclib.o
VSLOBJS=Main.o lexer.o parser.o ScanParse.o Absyn.o Env.o Eval.o
CLEAN=pamdecl pamdecl.exe $(COMMONOBJS) $(VSLOBJS) Main.c Main.h lexer.c parser.c parser.h Absyn.c Absyn.h Env.c Env.h Eval.c Eval.h *~
 
pamdecl: $(VSLOBJS) $(COMMONOBJS)
	$(LINK.rml) $(VSLOBJS) $(COMMONOBJS) $(LDLIBS) -o pamdecl
 
# MAIN ROUTINE WRITTEN IN RML NOW
 
Main.o: Main.c
Main.c Main.h: Main.mo
	$(COMPILE.rml) -c Main.mo
 
# YACCLIB
 
yacclib.o:  yacclib.c
	$(COMPILE.rml) -c -o yacclib.o yacclib.c
 
# LEXER
 
lexer.o:  lexer.c parser.h Absyn.h
lexer.c:  lexer.l
	flex -t -l lexer.l >lexer.c
 
# PARSER
 
parser.o:  parser.c Absyn.h
parser.c parser.h:  parser.y
	bison -d parser.y
	mv parser.tab.c parser.c
	mv parser.tab.h parser.h
 
# INTERFACE TO SCANNER/PARSER (RML CALLING C)
 
ScanParse.o:  ScanParse.c Absyn.h

# ABSTRACT SYNTAX
 
Absyn.o:  Absyn.c
Absyn.c Absyn.h:  Absyn.mo
	$(COMPILE.rml) Absyn.mo
 
# ENVIRONMENTS
 
Env.o:  Env.c
Env.c Env.h:  Env.mo
	$(COMPILE.rml) Env.mo
 
# EVALUATION
 
Eval.o:  Eval.c 
Eval.c Eval.h:  Eval.mo Absyn.h Env.h
	$(COMPILE.rml) Eval.mo
 
# AUX

include $(GOROOT)/etc/client.mk 



