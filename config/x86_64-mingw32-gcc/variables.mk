# variables for Intel x86_64 / Mingw32 / gcc
CC=x86_64-w64-mingw32-gcc
CFLAGS=
COFLAGS=-O3 -fomit-frame-pointer
CPFLAGS=-fno-omit-frame-pointer -pg
CGFLAGS=-g -DRML_DEBUG 
CTFLAGS=-DRML_TRACE 
RANLIB=ranlib
CPP=x86_64-w64-mingw32-gcc -x c -E -ansi
AS=x86_64-w64-mingw32-as
LD=x86_64-w64-mingw32-ld
