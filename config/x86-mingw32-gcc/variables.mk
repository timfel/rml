# variables for Intel x86 / Mingw32 / gcc
CC=gcc -mno-cygwin
CFLAGS=
COFLAGS=-O2 -fomit-frame-pointer
CPFLAGS=-fno-omit-frame-pointer -pg
# no sockets, no readline... NO DEBUGGING!
CGFLAGS=
RANLIB=ranlib
CPP=gcc -mno-cygwin -x c -E -ansi
AS=as
LD=ld
