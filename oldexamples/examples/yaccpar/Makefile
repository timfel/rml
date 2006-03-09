## RMLHOME=/home/x05emica/utils/rml/rml-2.2/x86-linux-gcc/ 
RMLHOME=/home/adrpo/rml-2.2/x86-cygwin-gcc/
CC = gcc -g
LD = gcc -g
RML=${RMLHOME}/bin/rmlc 
#debug flags
#RMLFLAGS=-g -Wc,-g
#normal flags
RMLFLAGS=

CCFLAGS=-I${RMLHOME}/include/plain/ 
LDFLAGS=-L${RMLHOME}/lib/plain/ -lrml 

all: ptest

build: parser.o lexer.o yacclib.o absyn.o rmldump.o \
	rmlrefactor.o rmltomod.o moddump.o rml-db-parse.o rml-db-scan.o loadprogramdb.o

parser.o parser.h: parser.y absyn.h 
	bison -t -d -v --output-file="parser.c" parser.y
	$(CC) $(CCFLAGS) -c parser.c

lexer.o: lexer.c parser.h 
	$(CC) -c lexer.c

yacclib.o: yacclib.c yacclib.h
	$(CC) $(CCFLAGS) -c yacclib.c

rmldump.h rmldump.c:rmldump.rml absyn.h
	$(RML) $(RMLFLAGS) -c rmldump.rml

rmldump.o: rmldump.c rmldump.h absyn.h
	$(RML) $(RMLFLAGS) -c rmldump.c

rmlrefactor.h rmlrefactor.c:rmlrefactor.rml absyn.h
	$(RML) $(RMLFLAGS) -c rmlrefactor.rml

rmlrefactor.o: rmlrefactor.c  absyn.h
	$(CC) $(CCFLAGS) -c rmlrefactor.c

rmltomod.h rmltomod.c:rmltomod.rml absyn.h
	$(RML) $(RMLFLAGS) -c rmltomod.rml

rmltomod.o: rmltomod.c  absyn.h
	$(CC) $(CCFLAGS) -c rmltomod.c

moddump.h moddump.c:moddump.rml absyn.h
	$(RML) $(RMLFLAGS) -c moddump.rml

moddump.o: moddump.c absyn.h 
	$(CC) $(CCFLAGS) -c moddump.c

#print.h print.c:print.rml 
#	$(RML) $(RMLFLAGS) -c print.rml

#print.o: print.c print.h 
#	$(RML) -c print.o

absyn.h absyn.c: absyn.rml
	$(RML) $(RMLFLAGS) -c absyn.rml

absyn.o: absyn.c absyn.h
	$(CC) -c absyn.c

scanparse.o: scanparse.c absyn.h
	$(RML) -c scanparse.c

rml-db-parse.c rml-db-parse.h: rml-db-parse.y
	bison -p yyrmldb --defines --output-file=rml-db-parse.c rml-db-parse.y

rml-db-scan.c: rml-db-scan.l rml-db-parse.h
	flex -Pyyrmldb rml-db-scan.l

rml-db-scan.o: rml-db-scan.c rml-db-parse.h
	$(CC) $(CCFLAGS) -c rml-db-scan.c

rml-db-parse.o: rml-db-parse.c rml-db-scan.o
	$(CC) $(CCFLAGS) -c rml-db-parse.c

loadprogramdb.o: loadprogramdb.c absyn.h rml-db-parse.h
	$(RML) -c loadprogramdb.c

main.c main.h: main.rml scanparse.o loadprogramdb.o rml-db-parse.o
	$(RML) $(RMLFLAGS) -c main.rml

main.o: main.c main.h scanparse.o rmldump.h rmldump.o rmlrefactor.h rmlrefactor.o \
	rmltomod.h  rmltomod.o moddump.h moddump.o parser.o yacclib.o lexer.o \
        rml-db-parse.o rml-db-scan.o loadprogramdb.o
	$(RML) -c main.c `ls *.o`

ptest: main.o
	$(RML) $(RMLFLAGS) -o ptest `ls *.o`

clean:
	rm -f *~ *.o *.rdb scanparse.h main.h main.c ptpest parser.h \
		parser.c rmldump.h rmldump.c absyn.h absyn.c \
		rmlrefactor.h rmlrefactor.c rmltomod.h rmltomod.c \
		moddump.h moddump.c ptest rml-db-*.c rml-db-*.h \
		loadprogramdb.h 
