
# VARIABLES

GOROOT = ../../..

SHELL = /bin/sh
LDLIBS = -lrml -lfl 


# EVERYTHING
all:    pam

# EXECUTABLE

COMMONOBJS=yacclib.o
VSLOBJS=Main.o lexer.o gram.o Parse.o Pam.o Input.o
CLEAN=pam $(COMMONOBJS) $(VSLOBJS) Main.c Main.h lexer.c gram.c gram.h Parse.o Pam.h Pam.c *~ pam.exe

pam: $(VSLOBJS) $(COMMONOBJS)
	$(LINK.rml) $(VSLOBJS) $(COMMONOBJS) $(LDLIBS) -o pam

# MAIN ROUTINE WRITTEN IN RML NOW

Main.o: Main.c
Main.c Main.h: Main.mo
	$(COMPILE.rml) -c Main.mo

# PAM

Pam.o: Pam.c
Pam.c Pam.h: Pam.mo
	$(COMPILE.rml) -c Pam.mo

# YACCLIB

yacclib.o:  yacclib.c
	$(COMPILE.rml) $(CFLAGS) -o yacclib.o yacclib.c

# LEXER

lexer.o:  lexer.c gram.h Pam.h
lexer.c:  lexer.l
	flex -t -l lexer.l >lexer.c

# PARSER

gram.o:  gram.c gram.h
gram.c gram.h:  gram.y
	bison -d gram.y
	mv gram.tab.c gram.c
	mv gram.tab.h gram.h

# INTERFACE TO SCANNER/PARSER (OMC CALLING C)

Parse.o:  Parse.c 

# INTERFACE TO INPUT (OMC CALLING C)

Input.o:  Input.c 

# AUX

include $(GOROOT)/etc/client.mk

