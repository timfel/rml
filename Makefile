#
# Root Makefile
#
SHELL=/bin/sh
SUBDIRS = compiler etc runtime # examples

default:	config.cache
	$(MAKE) MAKETARGET=default all-subdirs

all-subdirs:
	-for dir in $(SUBDIRS); do \
		(cd $$dir; $(MAKE) $(MAKETARGET); cd ..); \
	done

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
