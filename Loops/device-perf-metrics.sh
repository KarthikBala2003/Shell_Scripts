#! /usr/bin/env bash

result_array=()

print_metrics_arrays() {
  # Initialize column headers
  header1="Mnemonic"
  header2="Uptime"
  header3="MemFree"

  # Print headers with equal spacing
  printf "%-15s %-15s %-15s\n" "$header1" "$header2" "$header3" >> metrics.txt

  # Define the metrics arrays
  mnemonic_array=()
  readarray -t mnemonic_array < <(grep "the Mnemonic:" Iteration2.txt | cut -d':' -f2 | xargs -I MN echo 'MN')
 
  uptime_array=()
  readarray -t uptime_array < <(grep "day" Iteration2.txt | cut -d',' -f1-2 | cut -d' ' -f4-6 | xargs -I UP echo 'UP') 

  memfree_array=()
  readarray -t memfree_array < <(grep "MemFree:" Iteration2.txt | cut -d':' -f2 | xargs -I MF echo 'MF')

  len_memfree_array=${#memfree_array[@]}
  memfree_avg="$((len_memfree_array/3))"
     
  # Check if all three arrays have the same length
  if [ ${#mnemonic_array[@]} -ne ${#uptime_array[@]} ] || [ ${#mnemonic_array[@]} -ne $memfree_avg ]; then
      echo -e "Error: All arrays must have the same length.\n$header1: ${#mnemonic_array[@]}  $header2: ${#uptime_array[@]}  $header3: $len_memfree_array"
      return 1
  fi
  
  #creating empty array updated_uptime
  updated_uptime=()

  for i in "${uptime_array[@]}"; do
  #removing comma from data in uptime_array and storing it in updated_uptime array
    updated_uptime+=("$(echo "$i" | tr -d ',')")
  done

  # Call the function to calculate averages and store them in a n
  calculate_average "${memfree_array[@]}"

  for i in "${!mnemonic_array[@]}"; do
    
    # printf "%.2f\n" "${result_array[i]}"
    mnemonic="${mnemonic_array[i]//[$'\r']}"
    uptime="${updated_uptime[i]//[$'\r']}"
   
    uptime=$(convert_to_hours "$uptime")
    printf "%-15s %-15s %.2f %s\n" "$mnemonic" "$uptime" "${result_array[i]}" >> metrics.txt
    
  done
  generate_csv
}

# Function to calculate the average of every three elements
calculate_average() {
  local input_array=("$@")
  local num_elements=${#input_array[@]}
  # echo $num_elements
  # Initialize variables
  local sum=0
  local count=0
  i=0
 
  # while [ $i -lt $num_elements ]; do
  for ((i = 0; i < num_elements; i += 3)); do
    # Extract numeric values from the array elements
    # sample usage t="5678 kb" && echo ${t%% kb} --> 5678
    # echo "5678 kb" | xargs -I xxx echo ${xxx%% kb}

    e1="${input_array[i]//[$'\r']}"
    val1=$(echo ${e1%% kB})
    
    e2="${input_array[i+1]//[$'\r']}"
    val2=$(echo ${e2%% kB})
    
    e3="${input_array[i+2]//[$'\r']}"
    val3=$(echo ${e3%% kB})
        
    # Calculate the sum of the numeric values
    #sum=$((val1 + val2 + val3))
    
    # Calculate the average and store it in a new array
    #average=$((sum / 3))
    average=$(echo "scale=2; ($val1 + $val2 + $val3) / 3" | bc)
    
    # Format the average with two decimal places
    #formatted_average=$(printf "%.2f" "$(bc -l <<< "$average / 1.0")")
    formatted_average=$(printf "%.2f" $average)

    # Add the formatted average to the result array
    result_array+=("$formatted_average")

  done

  # Print the result array
  # echo "${result_array[@]}"

}
#function to generate csv file
generate_csv() {
    check_file="metrics.txt"
    if [ -e "$check_file" ]; then
      input="metrics.txt"
      output="metrics.csv"

      echo "Mnemonic,Uptime,Memfree" > "$output"
      #reading from second line of input text file
      tail -n +2 "$input" | while IFS= read -r line; do
          mnemonic=$(echo "$line" | awk '{print $1}')
          uptime=$(echo "$line" | awk '{print $2 " " $3 " " $4}')
          memfree=$(echo "$line" | awk '{print $5}')
          echo "$mnemonic,$uptime,$memfree" >> "$output"
       done
       echo "CSV file saved as metrics.csv"
     else
       echo "file does not exist"
    fi
}

convert_to_hours() {
    # input="1 day 18:44"
    input="$1"
    IFS=' ' read -ra parts <<< "$input"
    day_part="${parts[0]}"  # Extract the day part
    time_part="${parts[2]}"  # Extract the time part
    IFS=':' read -ra time_parts <<< "$time_part"
    hours="${time_parts[0]}"  # Extract the hours
    minutes="${time_parts[1]}"  # Extract the minutes

    # Convert day_part and hours to hours and then add them together
    total_hours=$((day_part * 24 + hours))

    # Format the result as "total_hours:minutes"
    result="${total_hours}:${minutes}"

    echo "$result"
}

# Call the function to print the arrays
print_metrics_arrays