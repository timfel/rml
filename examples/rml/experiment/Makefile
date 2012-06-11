include ../../../config.cache

GOROOT=../../..
LDLIBS=-lfl
CLEAN=calc calc.exe $(CALCOBJS) main.c main.h *~ *.rdb *.fol *.ast *.cps *.exe *.stackdump hash.c hash.h
RMLCFLAGS=#-g -Wr,-East,-Ecps,-Efol

# EVERYTHING
all:	calc


# MAIN PROGRAM

CALCOBJS= hash.o main.o 
calc: $(CALCOBJS)
	$(LINK.rml) -o calc $(CALCOBJS) $(LDLIBS)

main.o:	 main.c main.h hash.o
main.c main.h: main.rml
	$(COMPILE.rml) main.rml

hash.o:	 hash.c hash.h
hash.c hash.h: hash.rml
	$(COMPILE.rml) hash.rml
include $(GOROOT)/etc/client.mk



