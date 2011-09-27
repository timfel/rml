#
# Root Makefile
#
SHELL=/bin/sh
SUBDIRS = compiler etc runtime # examples

default:	config.cache
	$(MAKE) MAKETARGET=default all-subdirs

.PHONY: $(SUBDIRS)

all-subdirs: $(SUBDIRS)

compiler:
	$(MAKE) -C $@ $(MAKETARGET)
etc:
	$(MAKE) -C $@ $(MAKETARGET)
runtime:
	$(MAKE) -C $@ $(MAKETARGET)

configure:	config.cache
	$(MAKE) MAKETARGET="-f Make.mk configure" all-subdirs

install:	config.cache
	$(MAKE) MAKETARGET=install all-subdirs

distclean:
	$(MAKE) MAKETARGET="-f Make.mk distclean" all-subdirs
	rm -f config.cache

realclean:
	$(MAKE) MAKETARGET="-f Make.mk realclean" all-subdirs

clean:
	$(MAKE) MAKETARGET="-f Make.mk clean" all-subdirs
