allThreads=(1 2 4 8 16 32 64 128)
# echo ${allThreads[1]}
# echo ${allThreads[@]}
for i in ${!allThreads[@]}; 
	do
	  # echo ${allThreads[$i]}
	  runtime=${allThreads[$i]}
	  allRuntimes+=( $runtime )
	done

allRuntimes+=( 222 333 )
echo ${allRuntimes[@]}