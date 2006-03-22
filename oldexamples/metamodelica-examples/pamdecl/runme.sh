#!/bin/bash

echo Program for the pamdecl language:
cat program.txt
echo "
"
echo Running pamdecl interpretor on the program
echo 3 | (cat program.txt | ./pamdecl) 

echo "

"
