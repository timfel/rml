include ../../config.cache
# VARIABLES


GOROOT=../..
LDLIBS = -lfl -lrml

CALCOBJS= main.o lexer.o parser.o yacclib.o exp2.o
CLEAN=calc $(CALCOBJS) lexer.c parser.c parser.h exp2.c exp2.h calc.exe *~

# EVERYTHING
all:	calc


# MAIN PROGRAM
calc: $(CALCOBJS)
	$(LINK.rml) $(CALCOBJS) $(LDLIBS) -o calc

main.o:	 main.c exp2.h

# LEXER

lexer.o:  lexer.c parser.h exp2.h
lexer.c:  lexer.l
	flex -t -l lexer.l >lexer.c

# PARSER

parser.o:  parser.c exp2.h
parser.c parser.h:  parser.y
	bison -d parser.y
	mv parser.tab.c parser.c
	mv parser.tab.h parser.h


# ABSTRACT SYNTAX and EVALUATION

exp2.o:  exp2.c
exp2.c exp2.h:	exp2.rml
	$(COMPILE.rml) -c exp2.rml

# AUX

include $(GOROOT)/etc/client.mk

