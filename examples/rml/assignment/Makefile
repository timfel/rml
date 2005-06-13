include ../../../config.cache

# VARIABLES

GOROOT=../../..
SHELL = /bin/sh
LDLIBS = -lfl
CC = gcc
CLEAN= calc $(CALCOBJS) lexer.c parser.c parser.h assignment.c assignment.h


# EVERYTHING
all:	calc


# MAIN PROGRAM

CALCOBJS= main.o lexer.o parser.o yacclib.o assignment.o
CLEAN= calc calc.exe $(CALCOBJS) lexer.c parser.c parser.h assignment.c assignment.h *~

calc: $(CALCOBJS)
	$(LINK.rml) $(CALCOBJS) $(LDLIBS) -o calc

main.o:	 main.c assignment.h

# LEXER

lexer.o:  lexer.c parser.h assignment.h
lexer.c:  lexer.l
	flex -t -l lexer.l >lexer.c

# PARSER

parser.o:  parser.c assignment.h
parser.c parser.h:  parser.y
	bison -d parser.y
	mv parser.tab.c parser.c
	mv parser.tab.h parser.h


# ABSTRACT SYNTAX and EVALUATION

assignment.o:  assignment.c
assignment.c assignment.h:	assignment.rml
	$(COMPILE.rml) assignment.rml

include $(GOROOT)/etc/client.mk


