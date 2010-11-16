# variables for MIPS-based DECstation / Ultrix 4.x / cc
CC=cc
CFLAGS=-Dconst=
COFLAGS=-O2 -Olimit 1600
CPFLAGS=-p
CGFLAGS=-g -DRML_DEBUG
CTFLAGS=-DRML_TRACE 
RANLIB=ranlib
CPP=/lib/cpp
AS=/usr/bin/as -nocpp
LD=/usr/bin/ld
