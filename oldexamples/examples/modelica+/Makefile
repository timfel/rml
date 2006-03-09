include ../../config.cache

GOROOT=../..
LDLIBS=-lfl
CLEAN=calc calc.exe $(CALCOBJS) lexer.c parser.c parser.h eval.c eval.h *~ *.rdb *.fol *.ast *.cps 
RMLCFLAGS=-g -Wr,-East,-Ecps,-Efol

# EVERYTHING
all:	calc


# MAIN PROGRAM

CALCOBJS= main.o lexer.o parser.o yacclib.o eval.o
calc: $(CALCOBJS)
	$(LINK.rml) -o calc $(CALCOBJS) $(LDLIBS)

main.o:	 main.c eval.h

# LEXER

lexer.o:  lexer.c parser.h eval.h
lexer.c:  lexer.l
	flex -t -l lexer.l >lexer.c

# PARSER

parser.o:  parser.c eval.h
parser.c parser.h:  parser.y
	bison -d parser.y
	mv parser.tab.c parser.c
	mv parser.tab.h parser.h


# ABSTRACT SYNTAX and EVALUATION

eval.o:  eval.c
eval.c eval.h:	eval.mo
	$(COMPILE.rml) eval.mo

include $(GOROOT)/etc/client.mk



