#!/usr/bin/sh
echo petrol generates from file testp/a.d
cat testp/a.d
echo this C code
./petrol testp/a.d
echo compiling from petrol to C
./petrol testp/a.d > a.c
echo compiling from C to executable
gcc -o a.exe a.c
echo running the executable
./a.exe
echo delete garbage
rm -f a.c a a.exe


