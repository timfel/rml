#!/bin/bash

for file in `ls  *.mo`
do
  echo "translating $file.."   
  rml.sh -East $file  
done
