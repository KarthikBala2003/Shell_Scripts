#!/bin/bash

#http://universities.hipolabs.com/search?country=United+States
today=`date +%d-%m-%y`
file_name="test-${today}.json"
echo "${file_name}"
# api_url="https://datausa.io/api/data?drilldowns=Nation&measures=Population"
# curl -s ${api_url}