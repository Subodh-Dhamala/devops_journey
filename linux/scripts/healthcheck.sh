#!/bin/bash

URL="https://subodhdhamala.com.np"

if curl -s --head --fail "$URL" > /dev/null; then
    echo "$(date): UP" >> health.log
else
    echo "$(date): DOWN" >> health.log
fi

