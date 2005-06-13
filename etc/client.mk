# Generic client makefile
# Parameters:	GOROOT CLEAN
SHELL=/bin/sh
RMLC=$(PREFIX)/bin/rmlc
#RMLCFLAGS=
COMPILE.rml=$(RMLC) $(RMLCFLAGS) $(CPPFLAGS) -c
LINK.rml=$(RMLC) $(RMLCFLAGS)

.SUFFIXES:	.c .o .rml .h .mo

.c.o:
	$(COMPILE.rml) $<
.rml.c:
	$(COMPILE.rml) +C $<
.rml.h:
	$(COMPILE.rml) +C $<
.rml.o:
	$(COMPILE.rml) $<

.mo.c:
	$(COMPILE.rml) +C $<
.mo.h:
	$(COMPILE.rml) +C $<
.mo.o:
	$(COMPILE.rml) $<


Makefile:	$(GOROOT)/config.cache Make.mk
	(echo include $(GOROOT)/config.cache; cat Make.mk) > Makefile

configure:	clean-configure Makefile

clean-configure:	clean
	rm -f Makefile

default:
install:

clean:
	rm -f a.out core mon.out gmon.out $(CLEAN) *.ast *.cps *.fol *~ *.rdb
