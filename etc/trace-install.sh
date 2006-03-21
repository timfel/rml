#!/bin/bash
# If you run into building on installation errors, please run: 
# ./trace-install.sh configure-parameters
# where configure-parameters are the parameters you gave to the ./configure script
# Run trace-install.sh in your rml directory and send the 
# generated file called 'trace-install.txt' to Adrian Pop [adrpo@ida.liu.se]
# Thank you,
# Adrian Pop, 2006-03-21

rm -f trace-install.txt
echo Cleaning the distribution first.....
make clean realclean distclean >> trace-install.txt 2>&1
echo Tracing into trace-install.txt started....
echo PLEASE WAIT AS THIS WILL TAKE A WHILE....
echo Calling: \'./configure $*\'
echo "TRACE -> Calling: \'./configure $*\'" >> trace-install.txt
./configure $* >> trace-install.txt 2>&1
echo Calling: \'make\'
echo "TRACE -> Calling: \'make\'" >> trace-install.txt
make >> trace-install.txt 2>&1
echo Calling: \'make install\'
echo "TRACE -> Calling: \'make install\'" >> trace-install.txt
make install >> trace-install.txt 2>&1
echo Appending: \'config.cache\' to \'trace-install.txt\'
echo "TRACE -> Appending: \'config.cache' to \'trace-install.txt\'" >> trace-install.txt
cat config.cache >> trace-install.txt
echo "TRACE -> System:" >> trace-install.txt
echo `uname -a` >> trace-install.txt
echo "TRACE -> Flex:" >> trace-install.txt
echo `flex --version` >> trace-install.txt
echo "TRACE -> Bison:" >> trace-install.txt
echo `bison --version` >> trace-install.txt
echo "TRACE -> Gcc:" >> trace-install.txt
gcc -v >> trace-install.txt 2>&1
echo "TRACE -> SML/NJ:" >> trace-install.txt
echo `echo '' | sml` >> trace-install.txt
echo Trace was finished.
echo Please sent the file called 'trace-install.txt' to Adrian Pop [adrpo@ida.liu.se]
