#!/bin/bash

EQs="C[1]+C[2]=1,C[1]-C[2]=3"
EQ_VARS="C[1],C[2]"

OUT_VALS=( \
    $(maxima --very-quiet \
        --batch-string="display2d:false\$linel:9999\$print(map(rhs,float(solve([$EQs],[$EQ_VARS]))[1]))\$" \
        | tail -n 1 \
        | tr -c '0-9-.e' ' ') )

echo $OUT_VALS