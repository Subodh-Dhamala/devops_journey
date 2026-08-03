#!/bin/bash

read -p "Enter your age: " age

if [ "$age"  -ge 18 ]
then
	echo "you are an adult"
else
	echo  "you are a minor"

fi
