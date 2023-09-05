#!/bin/bash
# include this boilerplate
s=t1.txt

sed 's/this/these/' $s
echo -e "\\n\\n"

sed 's/this/hi/1' $s
echo -e "\\n\\n"

sed 's/this/cow/2' $s
echo -e "\\n\\n"

sed 's/this/vow/2g' $s
echo -e "\\n\\n"

sed 's/this/fi/g' $s

#This sed example prints the first character of every word in parenthesis.
#(W)elcome (T)o (T)he (G)eek (S)tuff
echo "Welcome To The Geek Stuff" | sed 's/\(\b[A-Z]\)/\(\1\)/g'




 