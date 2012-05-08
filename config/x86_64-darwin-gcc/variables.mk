# variables for Intel x86 / Linux / gcc
CC=gcc
CFLAGS=-m64
COFLAGS=-O2 -fomit-frame-pointer
CPFLAGS=-fno-omit-frame-pointer -pg
CGFLAGS=-g -DRML_DEBUG
CTFLAGS=-DRML_TRACE 
RANLIB=ranlib
CPP=gcc -x c -E -ansi
AS=as
LD=ld
