# Makefile for the rml compiler and interpreter
SHELL=/bin/sh
ifeq (${SMLNJ_HOME},)
$(warning no SMLNJ_HOME variable is not defined!)
$(warning Assuming SMLNJ_HOME=/usr/lib/smlnj)
$(warning Please define SMLNJ_HOME if is not /usr/lib/smlnj)
SMLNJ_HOME_=/usr/lib/smlnj
else
SMLNJ_HOME_=${SMLNJ_HOME}
endif
	
GOROOT=..

GENERATED=rml.lex.sml rml.grm.sml rml.grm.sig make.sml \
	mod.lex.sml mod.grm.sml mod.grm.sig \
	persistent.lex.sml persistent.grm.sml persistent.grm.sig

TEMP=$(GENERATED) rml.grm.desc mod.grm.desc persistent.grm.desc

default:	rml.$(HEAP_SUFFIX)

rml.$(HEAP_SUFFIX):	$(GENERATED) *.sml *.sig *.cm
	SMLNJ_HOME="${SMLNJ_HOME_}" ; export SMLNJ_HOME ; cat make.sml | $(SMLCM)
	ls -l rml.$(HEAP_SUFFIX)

install:	install-rml

install-rml:	rml.$(HEAP_SUFFIX)
	$(GOROOT)/etc/install-sml rml $(PREFIX) "$(SMLCM)" $(HEAP_SUFFIX) $(TARGET) $(GOROOT) $(DESTDIR)

install-mlton:  rml
	cp rml $(DESTDIR)$(PREFIX)/bin/rml
	rm -f $(DESTDIR)$(PREFIX)/bin/rml.$(HEAP_SUFFIX)
rml-mlton:
	mlton -verbose 3 -target self rml.mlb

rml.lex.sml:	rml.lex
	SMLNJ_HOME="${SMLNJ_HOME_}" ; export SMLNJ_HOME ; $(MLLEX) rml.lex

rml.grm.sml rml.grm.sig:	rml.grm
	SMLNJ_HOME="${SMLNJ_HOME_}" ; export SMLNJ_HOME ; $(MLYACC) rml.grm

mod.lex.sml:	mod.lex
	SMLNJ_HOME="${SMLNJ_HOME_}" ; export SMLNJ_HOME ; $(MLLEX) mod.lex

mod.grm.sml mod.grm.sig:	mod.grm
	SMLNJ_HOME="${SMLNJ_HOME_}" ; export SMLNJ_HOME ; $(MLYACC) mod.grm

persistent.lex.sml:	persistent.lex
	SMLNJ_HOME="${SMLNJ_HOME_}" ; export SMLNJ_HOME ; $(MLLEX) persistent.lex

persistent.grm.sml persistent.grm.sig:	persistent.grm
	SMLNJ_HOME="${SMLNJ_HOME_}" ; export SMLNJ_HOME ; $(MLYACC) persistent.grm

Makefile:	$(GOROOT)/config.cache Make.mk
	(echo include $(GOROOT)/config.cache; cat Make.mk) > Makefile

make.sml:	$(GOROOT)/config.cache
	. $(GOROOT)/config.cache; ./mkmake.sh $$SMLCM > ./make.sml || (rm -f ./make.sml; exit 1)

configure:	clean-configure Makefile ./make.sml

clean-configure:
	rm -f Makefile

distclean:	realclean clean-configure

realclean:
	rm -f rml.*-* rml
	rm -rf */CM
	rm -rf */.cm
	rm -rf */*/.cm
	rm -rf .cm
	rm -f $(TEMP)
	rm -rf .smlnetdep
	rm -rf .smlnetobj
	rm -rf */.smlnetdep
	rm -rf */.smlnetdep
	rm -rf */*/.smlnetdep
	rm -rf */*/.smlnetdep

clean:
	rm -f rml.*-* rml
