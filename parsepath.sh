#!/bin/bash
if [ $# -ne 1 ]; then
 echo "Usage: $0 /pathname"
 exit 2
fi
name=$1
echo
echo "The pathname is:$name"

while [[ -n $name ]]
do
 echo $name
 name=${name%/*}
done
echo
