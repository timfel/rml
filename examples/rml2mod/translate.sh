#!/bin/bash

RML_FILES=`ls  *.rml`
for file in $RML_FILES
do
  echo "generating rdb for $file.."   
  sfile=`echo $file | cut -d . -f 1`	    
  #echo "$sfile" 
  mfile="$sfile.mo"
  #echo $mfile
  rml.sh -frdb-only $file
done

echo Calling the translator 
~/dev/yaccpar/rml2mod -bench -young-size=1024000 $RML_FILES -napAll 
