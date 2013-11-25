# variables for Intel x86_64 / Mingw32 / gcc
CC=x86_64-w64-mingw32-gcc
CFLAGS=-Wall
COFLAGS=-Wall -O3 -fomit-frame-pointer
CPFLAGS=-Wall -fno-omit-frame-pointer -pg
CGFLAGS=-Wall -g -DRML_DEBUG 
CTFLAGS=-Wall -DRML_TRACE 
RANLIB=ranlib
CPP=x86_64-w64-mingw32-gcc -x c -E -ansi
AS=x86_64-w64-mingw32-as
LD=x86_64-w64-mingw32-ld
