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

  # memfree_array=()
  # readarray -t memfree_array < <(grep "MemFree:" Iteration2.txt | cut -d':' -f2 | xargs -I MF echo 'MF')
   
  # Check if all three arrays have the same length
  # if [ ${#mnemonic_array[@]} -ne ${#uptime_array[@]} ] || [ ${#mnemonic_array[@]} -ne ${#memfree_array[@]} ]; then
  #     echo "Error: All arrays must have the same length."
  #     return 1
  # fi

  if [ ${#mnemonic_array[@]} -ne ${#uptime_array[@]} ]; then
    echo "Error: All arrays must have the same length."
    return 1
  fi

  for i in "${!mnemonic_array[@]}"; do
    echo -e "${mnemonic_array[i]}\t${uptime_array[i]}" >> metrics.txt
    # printf "%-15s %-16s %s\n" "${mnemonic_array[i]}" "${uptime_array[i]}" "${memfree_array[i]}"
    # printf "%-5s %-15s %s\n" "${mnemonic_array[i]}" "${uptime_array[i]}"
    # printf ""%-20s %-20s"\n" "${mnemonic_array[i]}" "\t${uptime_array[i]}" 
  done
}

# Call the function to print the arrays
print_metrics_arrays

# ===============================================================================================================================================

# printf 'Mnemonic\tUptime\tMemFree\n' >> metrics.txt

# grep "the Mnemonic:" Iteration2.txt | cut -d':' -f2 | xargs -I MN echo 'MN' >> metrics.txt

# mnemonic_array=()
# readarray -t mnemonic_array < <(grep "the Mnemonic:" Iteration2.txt | cut -d':' -f2 | xargs -I MN echo 'MN')
# echo "${mnemonic_array[0]}"

# uptime_array=()
# readarray -t uptime_array < <(grep "day" Iteration2.txt | cut -d',' -f1-2 | cut -d' ' -f4-6 | xargs -I UP echo 'UP')
# echo "${uptime_array[0]}"

# memfree_array=()
# readarray -t memfree_array < <(grep "MemFree:" Iteration2.txt | cut -d':' -f2 | xargs -I MF echo 'MF')
# echo "${memfree_array[0]}"

# grep "day" Iteration2.txt | cut -d',' -f1-2 | cut -d' ' -f4-6 | xargs -I UP echo 'UP' >> metrics.txt
# grep "MemFree:" Iteration2.txt | cut -d':' -f2 | xargs -I MF echo 'MF' >> metrics.txt
# grep "day" Iteration2.txt | cut -d',' -f2 | xargs -I TIME echo 'TIME' >> metrics.txt
# grep "day" Iteration2.txt | cut -d',' -f1-2 | cut -d' ' -f4-6 | xargs -n 3 bash -c 'echo $2'