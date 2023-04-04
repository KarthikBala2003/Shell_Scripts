#! /usr/bin/env bash

input_file=$1
output_file=$2

cat input_file | cut -d'=' -f 1 > output_file