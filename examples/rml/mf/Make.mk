#
# Makefile for the mf example
#
GOROOT=../../..

SRCRML=	absyn.rml eval.rml main.rml test.rml
SRCC=	$(SRCRML:.rml=.c)
SRCH=	$(SRCRML:.rml=.h)
SRCO=	$(SRCRML:.rml=.o)

BINARIES=mf mf.exe
CLEAN=	$(SRCO) $(BINARIES) $(SRCC) $(SRCH) *~

# default target
mf:	$(SRCO)
	$(LINK.rml) -o mf $(SRCO)

benchexe:	mf
benchrun:	mf
	$(RUN) ./mf -bench 70
benchrun10:	mf
	for i in 0 1 2 3 4 5 6 7 8 9; do $(RUN) ./mf -bench 70; done

objects:	$(SRCO)
csources:	$(SRCC)

clean-binaries:
	rm -f $(BINARIES)
clean-objects:
	rm -f $(SRCO)
clean-csources:
	rm -f $(SRCC) $(SRCH)

distclean:	realclean clean-configure

realclean:	clean-csources clean

include $(GOROOT)/etc/client.mk
