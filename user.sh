#!/bin/bash

IFS=:

while read name number
do
 echo "The phone number for $name is $number"
done < phonelist

