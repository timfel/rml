include ../../../config.cache
#
# Makefile for the miniml example
#
GOROOT=../../..
ETCDIR=../../etc

CPPFLAGS=-DLEXDEBUG=1 -DYYDEBUG=1 -I$(ETCDIR)

SRCRML=	absyn.rml dynamic.rml main1.rml main2.rml scheme.rml static.rml types.rml unify.rml util.rml
SRCC=	$(SRCRML:.rml=.c)
SRCH=	$(SRCRML:.rml=.h)
SRCO=	$(SRCRML:.rml=.o)

EXTRAO=	lexer.o parser.o parsutil.o 
EXTRAC=	parser.c parser.h y.tab.c y.tab.h
EXTRARM=y.output ccall1.o ccall2.o
BINARIES=miniml benchexe miniml.exe benchexe.exe
CLEAN=	$(SRCO) $(EXTRAO) $(EXTRARM) $(BINARIES) $(SRCC) $(SRCH) *~ $(EXTRAC)
ccall.c=$(ETCDIR)/ccall.c

ALMOSTML=	absyn.o scheme.o static.o types.o unify.o util.o $(EXTRAO)

# default target
miniml:	$(ALMOSTML) dynamic.o main1.o ccall1.o
	$(LINK.rml) -o miniml $(ALMOSTML) dynamic.o main1.o ccall1.o -lm

benchexe:	$(ALMOSTML) main2.o ccall2.o
	$(LINK.rml) -o benchexe $(ALMOSTML) main2.o ccall2.o -lm

benchrun:	benchexe
	$(RUN) ./benchexe -bench tests/big.ml
benchrun10:	benchexe
	for i in 0 1 2 3 4 5 6 7 8 9; do $(RUN) ./benchexe -bench tests/big.ml; done

csources:	$(SRCC) $(EXTRAC)

ccall1.o:	$(ccall.c)
	$(COMPILE.rml) -UBENCH -o ccall1.o $(ccall.c)

ccall2.o:	$(ccall.c)
	$(COMPILE.rml) -DBENCH -o ccall2.o $(ccall.c)

lexer.o:	parsutil.h parser.h lexer.h
parser.o:	parser.c parsutil.h lexer.h
parsutil.o:	absyn.h parsutil.h

y.tab.c y.tab.h:	parser.y
	$(YACC) -d parser.y
	$(GOROOT)/etc/fixyacc < y.tab.c > y-tab-c
	mv y-tab-c y.tab.c

parser.c:	y.tab.c
	$(GOROOT)/etc/cp-if-change y.tab.c parser.c

parser.h:	y.tab.h
	$(GOROOT)/etc/cp-if-change y.tab.h parser.h

clean-binaries:
	rm -f $(BINARIES)
clean-objects:
	rm -f $(SRCO) $(EXTRAO) ccall1.o ccall2.o
clean-csources:
	rm -f $(SRCC) $(SRCH) $(EXTRAC)

distclean:	realclean clean-configure

realclean:	clean-csources clean

include $(GOROOT)/etc/client.mk
