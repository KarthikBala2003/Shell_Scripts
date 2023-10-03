#!/usr/bin/env bash

declare -A arr
arr[0,0]=2
arr[0,1]=-1
arr[1,0]=-1
arr[1,1]=2
echo "${arr[0,0]} ${arr[0,1]}" # will print 0 1