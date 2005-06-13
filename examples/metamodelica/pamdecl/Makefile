include ../../../config.cache


# VARIABLES

GOROOT = ../../..
 
SHELL = /bin/sh
LDLIBS = -lrml -lfl

 
# EVERYTHING
all:    pamdecl
 
# EXECUTABLE
 
COMMONOBJS=yacclib.o
VSLOBJS=main.o lexer.o parser.o scanparse.o absyn.o env.o eval.o
CLEAN=pamdecl pamdecl.exe $(COMMONOBJS) $(VSLOBJS) main.c main.h lexer.c parser.c parser.h absyn.c absyn.h env.c env.h eval.c eval.h *~
 
pamdecl: $(VSLOBJS) $(COMMONOBJS)
	$(LINK.rml) $(VSLOBJS) $(COMMONOBJS) $(LDLIBS) -o pamdecl
 
# MAIN ROUTINE WRITTEN IN RML NOW
 
main.o: main.c
main.c main.h: main.rml
	$(COMPILE.rml) -c main.rml
 
# YACCLIB
 
yacclib.o:  yacclib.c
	$(COMPILE.rml) -c -o yacclib.o yacclib.c
 
# LEXER
 
lexer.o:  lexer.c parser.h absyn.h
lexer.c:  lexer.l
	flex -t -l lexer.l >lexer.c
 
# PARSER
 
parser.o:  parser.c absyn.h
parser.c parser.h:  parser.y
	bison -d parser.y
	mv parser.tab.c parser.c
	mv parser.tab.h parser.h
 
# INTERFACE TO SCANNER/PARSER (RML CALLING C)
 
scanparse.o:  scanparse.c absyn.h
 
# ABSTRACT SYNTAX
 
absyn.o:  absyn.c
absyn.c absyn.h:  absyn.rml
	$(COMPILE.rml) absyn.rml
 
# ENVIRONMENTS
 
env.o:  env.c
env.c env.h:  env.rml
	$(COMPILE.rml) env.rml
 
# EVALUATION
 
eval.o:  eval.c 
eval.c eval.h:  eval.rml absyn.h env.h
	$(COMPILE.rml) eval.rml
 
# AUX

include $(GOROOT)/etc/client.mk 



