#!/usr/bin/sh
echo petrol generates from file factorial.d
cat factorial.d
echo this C code
./petrol factorial.d
echo compiling from petrol to C
./petrol factorial.d > a.c
echo compiling from C to executable
gcc -o a.exe a.c
echo running the executable
echo 9 | ./a.exe
echo delete garbage
rm -f a.c a a.exe


