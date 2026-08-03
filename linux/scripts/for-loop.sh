#!/bin/bash

for i in 1 2 3 4 5
do 
	echo  "Number $i"
done

for i in {2..8}
do 
	echo "$i * $i : $((i*i))"
done

for file in *.sh

do 
	echo "$file"
done


for arg in "$@"
 do 
	echo "$arg"
done
