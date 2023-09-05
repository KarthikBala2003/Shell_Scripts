#! /usr/bin/env bash

grep "day" Iteration2.txt | cut -d',' -f2 | xargs -I TIME echo 'TIME'
# grep "day" Iteration2.txt | cut -d',' -f1-2 | cut -d' ' -f4-6 | xargs -n 3 bash -c 'echo $2'