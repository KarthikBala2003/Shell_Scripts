export VAR1="ONE" VAR2="TWO" VAR3="THREE"
envsubst "${VAR1} ${VAR2}" <infile.txt >outfile.txt