# VARIABLES

GOROOT = ../../..
LDLIBS =  -lfl -lm

# EVERYTHING
all:	calc


# MAIN PROGRAM

CALCOBJS= main.o lexer.o parser.o yacclib.o AssignTwoType.o
CLEAN=calc calc.exe $(CALCOBJS) lexer.c parser.c parser.h AssignTwoType.c AssignTwoType.h
#uncomment this to have debugging
#RMLCFLAGS=-g -East 

calc: $(CALCOBJS)
	$(LINK.rml) $(CALCOBJS) $(LDLIBS) -o calc

main.o:	 main.c AssignTwoType.h

# LEXER

lexer.o:  lexer.c parser.h AssignTwoType.h
lexer.c:  lexer.l
	flex -t -l lexer.l >lexer.c

# PARSER

parser.o:  parser.c AssignTwoType.h
parser.c parser.h:  parser.y
	bison -d parser.y
	mv parser.tab.c parser.c
	mv parser.tab.h parser.h


# ABSTRACT SYNTAX and EVALUATION

AssignTwoType.o:  AssignTwoType.c
AssignTwoType.c AssignTwoType.h:	AssignTwoType.mo
	$(COMPILE.rml) AssignTwoType.mo

# AUX

include $(GOROOT)/etc/client.mk


