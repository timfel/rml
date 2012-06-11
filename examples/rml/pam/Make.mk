
# VARIABLES

GOROOT = ../../..

SHELL = /bin/sh
LDLIBS = -lrml -lfl -lm


# EVERYTHING
all:    pam

# EXECUTABLE

VSLOBJS=main.o lexer.o gram.o parse.o pam.o input.o
CLEAN=pam $(VSLOBJS) main.c main.h lexer.c gram.c gram.h parse.o pam.h pam.c *~ pam.exe

pam: $(VSLOBJS) 
	$(LINK.rml) $(VSLOBJS) $(LDLIBS) -o pam

# MAIN ROUTINE WRITTEN IN RML NOW

main.o: main.c
main.c main.h: main.rml
	$(COMPILE.rml) -c main.rml

# PAM

pam.o: pam.c
pam.c pam.h: pam.rml
	$(COMPILE.rml) -c pam.rml

# LEXER

lexer.o:  lexer.c gram.h pam.h
lexer.c:  lexer.l
	flex -t -l lexer.l >lexer.c

# PARSER

gram.o:  gram.c gram.h
gram.c gram.h:  gram.y
	bison -d gram.y
	mv gram.tab.c gram.c
	mv gram.tab.h gram.h

# INTERFACE TO SCANNER/PARSER (RML CALLING C)

parse.o:  parse.c 

# INTERFACE TO INPUT (RML CALLING C)

input.o:  input.c 

# AUX

include $(GOROOT)/etc/client.mk

