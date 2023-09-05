

grep "day" Iteration2.txt | cut -d',' -f2 | xargs -I TIME echo 'TIME'
