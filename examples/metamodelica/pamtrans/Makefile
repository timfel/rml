include ../../../config.cache

 
# VARIABLES
GOROOT=../../..
 
SHELL = /bin/sh
LDLIBS = -lrml -lfl 
 
# EVERYTHING
all:    pamTrans
 
# EXECUTABLE
 
COMMONOBJS=yacclib.o
VSLOBJS=Main.o lexer.o gram.o Parse.o Absyn.o Mcode.o Trans.o Emit.o
CLEAN=pamTrans pamTrans.exe $(COMMONOBJS) $(VSLOBJS) Main.c Main.h lexer.c Parser.c Parser.h gram.c gram.h Absyn.c Absyn.h Emit.c Emit.h Mcode.c Mcode.h Trans.c Trans.h *~ 

pamTrans: $(VSLOBJS) $(COMMONOBJS)
	$(LINK.rml) $(VSLOBJS) $(COMMONOBJS) $(LDLIBS) -o pamTrans
 
# Main ROUTINE WRITTEN IN RML NOW
 
Main.o: Main.c
Main.c Main.h: Main.rml
	$(COMPILE.rml) Main.rml
 
# YACCLIB
 
yacclib.o:  yacclib.c
	$(COMPILE.rml) $(CFLAGS) -o yacclib.o yacclib.c
 
# LEXER
 
lexer.o:  lexer.c gram.h Absyn.h
lexer.c:  lexer.l
	flex -t -l lexer.l >lexer.c
 
# ParseR
 
gram.o:  gram.c gram.h
gram.c gram.h:  gram.y
	bison -d gram.y
	mv gram.tab.c gram.c
	mv gram.tab.h gram.h

# INTERFACE TO SCANNER/ParseR (RML CALLING C)
 
Parse.o:  Parse.c Absyn.h
 
# ABSTRACT SYNTAX
 
Absyn.o:  Absyn.c
Absyn.c Absyn.h:  Absyn.rml
	$(COMPILE.rml) Absyn.rml
 
# TransLATION
 
Trans.o:  Trans.c 
Trans.c Trans.h:  Trans.rml Absyn.h 
	$(COMPILE.rml) Trans.rml

# EMISSION
 
Emit.o:  Emit.c 
Emit.c Emit.h:  Emit.rml
	$(COMPILE.rml) Emit.rml

# INTERMEDIATE FORM
 
Mcode.o:  Mcode.c 
Mcode.c Mcode.h:  Mcode.rml
	$(COMPILE.rml) Mcode.rml

 
# AUX
 
include $(GOROOT)/etc/client.mk



