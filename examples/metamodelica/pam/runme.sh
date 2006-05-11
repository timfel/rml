#!/bin/sh

echo Program for the pam language:
cat program.txt
echo "
"
echo Running pam interpretor on the program
echo 3 | (cat program.txt | ./pam) 

echo "

"
