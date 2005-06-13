#
# Makefile for the debug part of the runtime
#
GOROOT=../..

default: rmldb-parse.c rmldb-scan.c rml-db-parse.c rml-db-scan.c

rmldb-parse.c rmldb-scan.h : rmldb-parse.y
	bison -p aa --defines --output-file=rmldb-parse.c rmldb-parse.y

rmldb-scan.c : rmldb-scan.l rmldb-parse.h
	flex -I -Paa rmldb-scan.l

rml-db-parse.c rml-db-scan.h : rml-db-parse.y
	bison -p aarmldb --defines --output-file=rml-db-parse.c rml-db-parse.y

rml-db-scan.c : rml-db-scan.l rml-db-parse.h
	flex -Paarmldb rml-db-scan.l

install: default
	echo "Nothing"

Makefile:	$(GOROOT)/config.cache Make.mk
	echo include $(GOROOT)/config.cache > Makefile
	. $(GOROOT)/config.cache; cat $(GOROOT)/config/$$TARGET/variables.mk >> Makefile
	cat Make.mk >> Makefile

configure:	clean-configure Makefile default

clean-configure:	clean
	rm -f Makefile

distclean:	realclean clean-configure
realclean:	clean

clean:
	rm -f *.o core rmldb rmldb-*.c rmldb-*.h a.out core mon.out gmon.out *~ rml-db-*.c rml-db-*.h


