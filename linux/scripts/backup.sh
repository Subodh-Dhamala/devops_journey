#!/bin/bash

SOURCE="../notes"
BACKUP="backup.tar.gz"

# -c: create archive, -z: compress with gzip, -f: specify output filename
tar -czf "$BACKUP" "$SOURCE"

echo "BACKUP Created: $BACKUP"

