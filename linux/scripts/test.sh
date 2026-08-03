#!/bin/bash

read -s -p "Enter password : "  password

if [ "$password" ==  "password" ]
then
	echo "Access granted!"
elif [ "$password"  ==  "admin" ]
then 
	echo "Admin access granted"

else 
	echo "Access denied!"

fi
