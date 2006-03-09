#!/bin/bash

echo Program for the pamtrans language:
cat program.txt
echo "
"
echo Running pamtrans translator on the program
echo 3 | (cat program.txt | pamtrans) 

echo "

"
