#!/bin/bash

for file in `ls  *.rml`
do
  echo "translating $file.."   
  sfile=`echo $file | cut -d . -f 1`	    
  #echo "$sfile" 
  mfile="$sfile.mo"
  #echo $mfile
  ~/project/yaccpar/rml2mod -bench $sfile -ip > $mfile           
  
done
