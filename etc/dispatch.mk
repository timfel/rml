# Generic dispatcher makefile
# Parameters:	SUBDIRS
SHELL=/bin/sh

default:
	$(MAKE) MAKETARGET=default all-subdirs

all-subdirs:
	-for dir in $(SUBDIRS); do \
		(cd $$dir; $(MAKE) $(MAKETARGET); cd ..); \
	done

Makefile:	Make.mk
	cp Make.mk Makefile

local-clean-configure:
	rm -f Makefile

configure:	local-clean-configure Makefile
	$(MAKE) -f Make.mk MAKETARGET="-f Make.mk configure" all-subdirs

install:
	$(MAKE) MAKETARGET="install" all-subdirs

distclean:	distclean-subdirs local-clean-configure
distclean-subdirs:
	$(MAKE) -f Make.mk MAKETARGET="-f Make.mk distclean" all-subdirs

realclean:	realclean-subdirs
realclean-subdirs:
	$(MAKE) -f Make.mk MAKETARGET="-f Make.mk realclean" all-subdirs

clean:
	$(MAKE) -f Make.mk MAKETARGET="-f Make.mk clean" all-subdirs
