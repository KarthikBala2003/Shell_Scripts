allThreads=("Sarah", "Ramai", "Karthik Bala", "Vish")
# echo ${allThreads[1]}
# echo ${allThreads[@]}

for i in ${!allThreads[@]}; 
	do
	  echo ${allThreads[$i]}
	  runtime=${allThreads[$i]}
	  allRuntimes+=( $runtime )
	done

