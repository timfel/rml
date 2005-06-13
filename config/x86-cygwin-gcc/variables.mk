# variables for Intel x86 / Cygwin / gcc
CC=gcc
CFLAGS=
COFLAGS=-O2 -fomit-frame-pointer
# @TODO fixme so that if _RMLDB_DEFINED_ is undefined will cut out the debug code
#CPFLAGS=-fno-omit-frame-pointer -pg -D_RMLDB_DEFINED_ 
#CGFLAGS=-g -D_RMLDB_DEFINED_
CPFLAGS=-fno-omit-frame-pointer -pg 
CGFLAGS=-g -DRML_DEBUG
RANLIB=ranlib
CPP=gcc -x c -E -ansi
AS=as
LD=ld
