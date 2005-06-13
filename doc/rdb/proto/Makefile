SHELL=	/bin/sh
SRC=	Makefile sources.cm scan.sig scan.lex parse.sig parse.sml\
	dynamic.sig dynamic.sml rdb.sig rdb.sml link.sml test.sml
GENERATED=CM scan.lex.sml

default:
	echo 'CM.make()' | sml

cat:	$(SRC)
	@cat $(SRC)

realclean:	clean
	rm -rf $(GENERATED)

clean:
