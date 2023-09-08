#! /usr/bin/env bash

#! /usr/bin/env bash

print_metrics_arrays() {

# Initialize column headers
header1="Mnemonic"
header2="Uptime"
header3="MemFree"

# Print headers with equal spacing
printf "%-15s %-15s %-15s\n" "$header1" "$header2" "$header3" >> metrics.txt

# Define the three arrays
mnemonic_array=()
readarray -t mnemonic_array < <(grep "the Mnemonic:" Iteration2.txt | cut -d':' -f2 | xargs -I MN echo 'MN')
 
uptime_array=()
readarray -t uptime_array < <(grep "day" Iteration2.txt | cut -d',' -f1-2 | cut -d' ' -f4-6 | xargs -I UP echo 'UP') 

memfree_array=()
readarray -t memfree_array < <(grep "MemFree:" Iteration2.txt | cut -d':' -f2 | xargs -I MF echo 'MF')
  
memfreeavg_array=()
  
#finding sum of consecutive triplets from memfree_array
len_memfree_array=${#memfree_array[@]}
#memfree_avg="$((len_memfree_array/3))"

#finding average of consecutive triplets from memfree_array  
for ((i = 0; i < len_memfree_array; i += 3)); do
	sum=0
  	sum=$((memfree_array[i] + memfree_array[i+1] + memfree_array[i+2]))
  	average=$(echo "scale=2; $sum / 3" | bc)
  	printf "%s\n" "$average" | readarray -t memfreeavg_array
  	
done
     
  # Check if all three arrays have the same length
if [ ${#mnemonic_array[@]} -ne ${#uptime_array[@]} ] || [ ${#mnemonic_array[@]} -ne ${#memfree_array[@]} ]; then
	echo "Error: All arrays must have the same length."
        return 1
fi
  
for i in "${!mnemonic_array[@]}"; do
	#mnemonic="${mnemonic_array[i]//[$'\r']}"
    	#uptime="${uptime_array[i]//[$'\r']}"
    	#freememory="${memfreeavg_array[i]//[$'\r']}
    	#printf "%-15s %-15s %s\n" "$mnemonic" "$uptime" "$freememory" >> metrics.txt
    	printf "%-15s %-16s %s\n" "${mnemonic_array[i]}" "${uptime_array[i]}" "${memfreeavg_array[i]}" >> metrics.txt
done


}


# Call the function to print the arrays
print_metrics_arrays