#!/bin/sh

echo -n "Enter some text: "
read INPUT

for var in $INPUT
do
 echo "var contains: $var"
done
