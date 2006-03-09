#!/bin/bash

for file in `ls  *.rml`
do
  echo "generating rdb for $file.."   
  sfile=`echo $file | cut -d . -f 1`	    
  #echo "$sfile" 
  mfile="$sfile.mo"
  #echo $mfile
  /home/adrpo/dev/rml-2.2.4/x86-linux-gcc/bin/rml -frdb-only $file
#~/project/parser/modeq/yaccpar/ptest -bench $sfile > $mfile           
  
done
