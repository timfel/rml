# Makefile for the rml compiler and interpreter
SHELL=/bin/sh
GOROOT=..

GENERATED=rml.lex.sml rml.grm.sml rml.grm.sig make.sml \
	mod.lex.sml mod.grm.sml mod.grm.sig \
	persistent.lex.sml persistent.grm.sml persistent.grm.sig

TEMP=$(GENERATED) rml.grm.desc mod.grm.desc persistent.grm.desc

default:	rml

rml rml.$(HEAP_SUFFIX):	$(GENERATED)
	cat make.sml | $(SMLCM)
	ls -l rml.$(HEAP_SUFFIX)

install:	install-rml

install-rml:	rml.$(HEAP_SUFFIX)
	$(GOROOT)/etc/install-sml rml $(PREFIX) "$(SMLCM)" $(HEAP_SUFFIX) $(TARGET) $(GOROOT)

rml.lex.sml:	rml.lex
	$(MLLEX) rml.lex

rml.grm.sml rml.grm.sig:	rml.grm
	$(MLYACC) rml.grm

mod.lex.sml:	mod.lex
	$(MLLEX) mod.lex

mod.grm.sml mod.grm.sig:	mod.grm
	$(MLYACC) mod.grm

persistent.lex.sml:	persistent.lex
	$(MLLEX) persistent.lex

persistent.grm.sml persistent.grm.sig:	persistent.grm
	$(MLYACC) persistent.grm

Makefile:	$(GOROOT)/config.cache Make.mk
	(echo include $(GOROOT)/config.cache; cat Make.mk) > Makefile

make.sml:	$(GOROOT)/config.cache
	. $(GOROOT)/config.cache; ./mkmake.sh $$SMLCM > ./make.sml || (rm -f ./make.sml; exit 1)

configure:	clean-configure Makefile ./make.sml

clean-configure:
	rm -f Makefile

distclean:	realclean clean-configure

realclean:
	rm -f rml.*-*
	rm -rf */CM
	rm -rf */.cm
	rm -rf .cm
	rm -f $(TEMP)
	rm -rf .smlnetdep
	rm -rf .smlnetobj

clean:
	rm -f rml.*-*
