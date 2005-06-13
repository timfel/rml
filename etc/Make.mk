# Makefile for the auxiliary programs
# Parameters:	PREFIX TARGET
SHELL=/bin/sh
GOROOT=..

default:

Makefile:	$(GOROOT)/config.cache Make.mk
	echo include $(GOROOT)/config.cache > Makefile
	cat Make.mk >> Makefile

configure:	clean-configure Makefile

clean-configure:
	rm -f Makefile

install:	install-rmlc

install-rmlc:	$(GOROOT)/config.cache $(GOROOT)/config/$(TARGET)/variables.mk
	./mkdirhier $(PREFIX)/bin
	(if [ -x /bin/ksh ]; then echo '#!/bin/ksh'; elif [ -x /usr/bin/ksh ]; then echo '#!/usr/bin/ksh'; else echo '#!/bin/sh'; fi) > $(PREFIX)/bin/rmlc
	echo '# installation parameters' >> $(PREFIX)/bin/rmlc
	grep PREFIX $(GOROOT)/config.cache >> $(PREFIX)/bin/rmlc
	echo '# configuration parameters' >> $(PREFIX)/bin/rmlc
	./mktosh $(GOROOT)/config/$(TARGET)/variables.mk >> $(PREFIX)/bin/rmlc
	cat skel.rmlc >> $(PREFIX)/bin/rmlc
	chmod +x $(PREFIX)/bin/rmlc

distclean:	clean-configure
realclean:
clean:
