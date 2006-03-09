include ../../config.cache



# -- Variables --


SHELL=/bin/sh
RMLC=$(PREFIX)/bin/rmlc
#uncomment next line for debugging (also, make clean, make)
#RMLCFLAGS=-g
COMPILE.rml=$(RMLC) $(RMLCFLAGS) $(CPPFLAGS) -c
LINK.rml=$(RMLC) $(RMLCFLAGS)
LDLIBS = -lfl -lrml

LCALCOBJS= scanparse.o lexer.o parser.o yacclib.o reducer.o main.o
CLEAN=lcalc $(LCALCOBJS) lexer.c parser.c parser.h reducer.c reducer.h reducer.rdb lcalc.exe lcalc.tgz *~ main.c main.h *.rdb



# -- Explicit Rules --


lcalc: $(LCALCOBJS)
	@$(LINK.rml) $(LCALCOBJS) $(LDLIBS) -o lcalc >/dev/null

scanparse.o: scanparse.c reducer.h

lexer.o:  parser.h reducer.h yacclib.h

parser.o:  reducer.h yacclib.h

reducer.h reducer.c: reducer.rml
	@echo $*.h
	@echo $*.c
	@$(COMPILE.rml) -c $< >/dev/null

main.h main.c: main.rml reducer.h 
	@echo $*.h
	@echo $*.c
	@$(COMPILE.rml) -c $< >/dev/null

# -- Phony Rules --


.PHONY: clean bundle

clean:
	@rm -f $(CLEAN)

bundle: clean
	@tar -czvf lcalc.tgz *



# -- Implicit rules --

%.o : %.c
	@echo $@
	@$(COMPILE.rml) $< >/dev/null

#%.h %.c: %.rml
#	@echo $*.h
#	@echo $*.c
#	@$(COMPILE.rml) -c $< >/dev/null

%.c %.h: %.y
	@echo $*.h
	@echo $*.c
	@bison -d $<
	@mv $*.tab.c $*.c
	@mv $*.tab.h $*.h

%.c: %.l
	@echo $*.c
	@flex -t -l $< >$@
