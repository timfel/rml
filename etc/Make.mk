# Makefile for the auxiliary programs
# Parameters:	PREFIX TARGET DESTDIR
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
	./mkdirhier $(DESTDIR)$(PREFIX)/bin
	(if [ -x /bin/ksh ]; then echo '#!/bin/ksh'; elif [ -x /usr/bin/ksh ]; then echo '#!/usr/bin/ksh'; else echo '#!/bin/sh'; fi) > $(DESTDIR)$(PREFIX)/bin/rmlc
	echo '# installation parameters' >> $(DESTDIR)$(PREFIX)/bin/rmlc
	grep PREFIX $(GOROOT)/config.cache >> $(DESTDIR)$(PREFIX)/bin/rmlc
	echo '# configuration parameters' >> $(DESTDIR)$(PREFIX)/bin/rmlc
	./mktosh $(GOROOT)/config/$(TARGET)/variables.mk >> $(DESTDIR)$(PREFIX)/bin/rmlc
	cat skel.rmlc >> $(DESTDIR)$(PREFIX)/bin/rmlc
	chmod +x $(DESTDIR)$(PREFIX)/bin/rmlc

distclean:	clean-configure
realclean:
clean:
