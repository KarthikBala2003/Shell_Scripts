#!/bin/bash
var1=$(grep "the Mnemonic:" iteration2.txt | cut -d':' -f2)
var2=$(grep "day" iteration2.txt | cut -d ',' -f 1-2 | cut -d ' ' -f 4-6)
var3=$(grep "MemFree:" iteration2.txt | cut -d ':' -f2)

while IFS= read -r -u3 a && read -r -u4 b && read -r -u5 c; do
printf '%s\t%s\t%s\n' "$a" "$b" "$c" >> result.xls
done 3<<<"$var1" 4<<<"$var2" 5<<<"$var3"
