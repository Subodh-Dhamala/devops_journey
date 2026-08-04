#!/bin/bash

read -p "First number: " num1
read -p "second number"  num2

add(){
	echo $((num1+num2))
}

echo "Sum = $(add)"
