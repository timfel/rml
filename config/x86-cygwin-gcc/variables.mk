# variables for Intel x86 / Cygwin / gcc
CC=gcc
CFLAGS=
COFLAGS=-O2 -fomit-frame-pointer
CPFLAGS=-fno-omit-frame-pointer -pg 
CGFLAGS=-g -DRML_DEBUG
RANLIB=ranlib
CPP=gcc -x c -E -ansi
AS=as
LD=ld
