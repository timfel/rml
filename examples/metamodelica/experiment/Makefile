include ../../../config.cache

GOROOT=../../..
LDLIBS=-lfl
CLEAN=main main.exe $(CALCOBJS) Main.c Main.h *~ *.rdb *.fol *.ast *.cps *.exe *.stackdump 
#uncomment this to have debugging
#RMLCFLAGS=-g -Wr,-East

# EVERYTHING
all:	main


# MAIN PROGRAM

CALCOBJS= Main.o  
main: $(CALCOBJS)
	$(LINK.rml) -o calc $(CALCOBJS) $(LDLIBS)

Main.o:	 Main.c Main.h
Main.c Main.h: Main.mo
	$(COMPILE.rml) Main.mo

include $(GOROOT)/etc/client.mk



