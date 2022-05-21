#! /bin/bash
FILE=/usr/share/elasticsearch/credentials.json
if [ -f "$FILE" ]; then
    echo "$FILE exist"
    exit 0
fi