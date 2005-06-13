include ../../../config.cache
# VARIABLES

GOROOT=../../..

LDLIBS = -lrml -lfl -lm
CALCOBJS= main.o lexer.o gram.o yacclib.o absyn.o eval.o parse.o
CLEAN=calc $(CALCOBJS) lexer.c main.c main.h absyn.c absyn.h eval.c eval.h gram.c gram.h lexer.c *~ calc.exe
CPPFLAGS=-DDEBUG -Dg -DEBUG -g -DLEXDEBUG=1 -DYYDEBUG=1

# EVERYTHING
all:	calc


# MAIN PROGRAM
calc: $(CALCOBJS)
	$(LINK.rml) $(CALCOBJS) $(LDLIBS) -o calc


# LEXER

lexer.o:  lexer.c gram.h absyn.h
lexer.c:  lexer.l
	flex -t lexer.l >lexer.c

# PARSER

gram.o:  gram.c gram.h
gram.c gram.h:  gram.y
	bison -t -d gram.y
	mv gram.tab.c gram.c
	mv gram.tab.h gram.h


# ABSTRACT SYNTAX and EVALUATION

absyn.o:  absyn.c
absyn.c absyn.h:	absyn.rml
	$(COMPILE.rml) -c absyn.rml

eval.o:  eval.c
eval.c eval.h:	eval.rml
	$(COMPILE.rml) eval.rml

main.o:  main.c
main.c main.h:	main.rml
	$(COMPILE.rml) main.rml

parse.o:  parse.c

# AUX

include $(GOROOT)/etc/client.mk




