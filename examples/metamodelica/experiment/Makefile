include ../../../config.cache

GOROOT=../../..
LDLIBS=-lfl
CLEAN=calc calc.exe $(CALCOBJS) main.c main.h *~ *.rdb *.fol *.ast *.cps *.exe *.stackdump 
#uncomment this to have debugging
#RMLCFLAGS=-g -Wr,-East

# EVERYTHING
all:	calc


# MAIN PROGRAM

CALCOBJS= main.o  
calc: $(CALCOBJS)
	$(LINK.rml) -o calc $(CALCOBJS) $(LDLIBS)

main.o:	 main.c main.h
main.c main.h: main.mo
	$(COMPILE.rml) main.mo

include $(GOROOT)/etc/client.mk



