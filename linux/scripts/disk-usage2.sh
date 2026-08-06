#!/bin/bash

echo "Checking disk usage..."

df -h /

echo

USAGE=$(df / | awk 'NR==2 {print $5}')

echo "Root usage: $USAGE"

# Get root filesystem disk usage percentage
# df /        -> Show disk usage of the root filesystem (/)
# |           -> Send the output to awk
# NR==2       -> Select the second line (actual filesystem data)
# print $5    -> Print the 5th column (Use% column, e.g., 45%)
USAGE=$(df / | awk 'NR==2 {print $5}')

