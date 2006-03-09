
GOROOT=../..
LDLIBS=-lfl
CLEAN=calc calc.exe $(CALCOBJS) main.c main.h *~ *.rdb *.fol *.ast *.cps *.exe *.stackdump 
RMLCFLAGS=-Wr,-East,-Ecps,-Efol -Wc,-g

# EVERYTHING
all:	calc


# MAIN PROGRAM

CALCOBJS= main.o  
calc: $(CALCOBJS)
	$(LINK.rml) -o calc $(CALCOBJS) $(LDLIBS)

main.o:	 main.c main.h
main.c main.h: main.rml
	$(COMPILE.rml) main.rml

include $(GOROOT)/etc/client.mk



