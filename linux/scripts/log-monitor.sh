#!/bin/bash

LOG="../app.log"

COUNT=$(grep -c "ERROR" "$LOG")

echo "Errors found: $COUNT"


