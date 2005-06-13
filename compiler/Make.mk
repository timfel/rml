# Makefile for the rml compiler and interpreter
SHELL=/bin/sh
GOROOT=..

GENERATED=rml.lex.sml rml.grm.sml rml.grm.sig make.sml
TEMP=$(GENERATED) rml.grm.desc

default:	rml

rml rml.$(HEAP_SUFFIX):	$(GENERATED)
	cat make.sml | $(SMLCM)
	ls -l rml.$(HEAP_SUFFIX)

install:	install-rml

install-rml:	rml.$(HEAP_SUFFIX)
	$(GOROOT)/etc/install-sml rml $(PREFIX) $(SMLCM) $(HEAP_SUFFIX) $(GOROOT)

rml.lex.sml:	rml.lex
	$(MLLEX) rml.lex

rml.grm.sml rml.grm.sig:	rml.grm
	$(MLYACC) rml.grm

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

clean:
	rm -f rml.*-*
