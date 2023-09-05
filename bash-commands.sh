#!/bin/bash

SCRIPT_NAME=`basename $0`
echo $SCRIP_NAME

SCRIPT_NAME=$(basename $0)
echo $SCRIP_NAME

echo "Script name =" $(basename "$0")


echo "data: {"key1": "one", "key2": "two"}," | grep -oP '(?<=data: {).*(?=},)' | cut -d "," -f2

# replace doule quote
echo "data: {"key1": "one", "key2": "two"}," | sed 's/\"//g'
