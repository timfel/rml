include ../../../config.cache

# VARIABLES

GOROOT=../../..
SHELL = /bin/sh
LDLIBS = -lfl -lm
CC = gcc
CLEAN= calc $(CALCOBJS) lexer.c parser.c parser.h Assignment.c Assignment.h

# EVERYTHING
all:	calc


# MAIN PROGRAM

CALCOBJS= main.o lexer.o parser.o Assignment.o
CLEAN= calc calc.exe $(CALCOBJS) lexer.c parser.c parser.h Assignment.c Assignment.h *~

calc: $(CALCOBJS)
	$(LINK.rml) $(CALCOBJS) $(LDLIBS) -o calc

main.o:	 main.c Assignment.h

# LEXER

lexer.o:  lexer.c parser.h Assignment.h
lexer.c:  lexer.l
	flex -t -l lexer.l >lexer.c

# PARSER

parser.o:  parser.c Assignment.h
parser.c parser.h:  parser.y
	bison -d parser.y
	mv parser.tab.c parser.c
	mv parser.tab.h parser.h


# ABSTRACT SYNTAX and EVALUATION

Assignment.o:  Assignment.c
Assignment.c Assignment.h:	Assignment.rml
	$(COMPILE.rml) Assignment.rml

include $(GOROOT)/etc/client.mk


