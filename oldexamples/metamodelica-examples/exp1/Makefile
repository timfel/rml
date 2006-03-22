include ../../config.cache

GOROOT=../..
LDLIBS=-lfl
CLEAN=calc calc.exe $(CALCOBJS) lexer.c parser.c parser.h exp1.c exp1.h *~
RMLCFLAGS=-Wr,-East

# EVERYTHING
all:	calc


# MAIN PROGRAM

CALCOBJS= main.o lexer.o parser.o yacclib.o exp1.o
calc: $(CALCOBJS)
	$(LINK.rml) -o calc $(CALCOBJS) $(LDLIBS)

main.o:	 main.c exp1.h

# LEXER

lexer.o:  lexer.c parser.h exp1.h
lexer.c:  lexer.l
	flex -t -l lexer.l >lexer.c

# PARSER

parser.o:  parser.c exp1.h
parser.c parser.h:  parser.y
	bison -d parser.y
	mv parser.tab.c parser.c
	mv parser.tab.h parser.h


# ABSTRACT SYNTAX and EVALUATION

exp1.o:  exp1.c
exp1.c exp1.h:	exp1.mo
	$(COMPILE.rml) exp1.mo

include $(GOROOT)/etc/client.mk
