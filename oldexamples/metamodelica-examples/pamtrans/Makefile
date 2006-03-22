include ../../config.cache

 
# VARIABLES
GOROOT=../..
 
SHELL = /bin/sh
LDLIBS = -lrml -lfl 
 
# EVERYTHING
all:    pamtrans
 
# EXECUTABLE
 
COMMONOBJS=yacclib.o
VSLOBJS=main.o lexer.o gram.o parse.o absyn.o mcode.o trans.o emit.o
CLEAN=pamtrans pamtrans.exe $(COMMONOBJS) $(VSLOBJS) main.c main.h lexer.c parser.c parser.h gram.c gram.h absyn.c absyn.h emit.c emit.h mcode.c mcode.h trans.c trans.h *~ 

pamtrans: $(VSLOBJS) $(COMMONOBJS)
	$(LINK.rml) $(VSLOBJS) $(COMMONOBJS) $(LDLIBS) -o pamtrans
 
# MAIN ROUTINE WRITTEN IN RML NOW
 
main.o: main.c
main.c main.h: main.rml
	$(COMPILE.rml) main.rml
 
# YACCLIB
 
yacclib.o:  yacclib.c
	$(COMPILE.rml) $(CFLAGS) -o yacclib.o yacclib.c
 
# LEXER
 
lexer.o:  lexer.c gram.h absyn.h
lexer.c:  lexer.l
	flex -t -l lexer.l >lexer.c
 
# PARSER
 
gram.o:  gram.c gram.h
gram.c gram.h:  gram.y
	bison -d gram.y
	mv gram.tab.c gram.c
	mv gram.tab.h gram.h

# INTERFACE TO SCANNER/PARSER (RML CALLING C)
 
parse.o:  parse.c absyn.h
 
# ABSTRACT SYNTAX
 
absyn.o:  absyn.c
absyn.c absyn.h:  absyn.rml
	$(COMPILE.rml) absyn.rml
 
# TRANSLATION
 
trans.o:  trans.c 
trans.c trans.h:  trans.rml absyn.h 
	$(COMPILE.rml) trans.rml

# EMISSION
 
emit.o:  emit.c 
emit.c emit.h:  emit.rml
	$(COMPILE.rml) emit.rml

# INTERMEDIATE FORM
 
mcode.o:  mcode.c 
mcode.c mcode.h:  mcode.rml
	$(COMPILE.rml) mcode.rml

 
# AUX
 
include $(GOROOT)/etc/client.mk



