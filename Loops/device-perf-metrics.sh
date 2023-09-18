#! /usr/bin/env bash

# Initialize all arrays
soak_duration_array=()
mnemonic_array=()
updated_uptime=()
memfree_array=()

result_array=()

# declare variables for file names
metrics_suffix="_Metrics.txt"
combined_csv_file="metrics.txt"
first_input_file="Iteration1.txt"

search_string1="the Mnemonic:"

# Initialize column headers
header1="Device"
header2="Uptime"
header3="MemFree"

# Print headers with equal spacing
printf "%-15s %-15s %-15s\n" "$header1,$header2,$header3" >> "$combined_csv_file"

# For source file Device Array wrrriten in Column 1
readarray -t mnemonic_array < <(grep "$search_string1" "$first_input_file" | cut -d':' -f2 | xargs -I MN echo 'MN')

# Create data array
build_metrics_arrays() {
  local input_file="$1"
  local search_string2="day"
  local search_string3="MemFree:"

  # rm metrics.csv
  
  # Call the function to remove carriage return characters
  remove_delimiter "mnemonic_array" $'\r'

  # Create metrics output files to log data - e.g G-120G-E_Metrics.txt
  # create_files "${mnemonic_array[@]}"

  # Column 1 - Soak Duraion
  soak_duration_array=($(seq 0 8 72))

  # Column 2 - Uptime
  uptime_array=()
  readarray -t uptime_array < <(grep "$search_string2" "$input_file" | cut -d',' -f1-2 | cut -d' ' -f4-6 | xargs -I UP echo 'UP')

  # Call the function to remove carriage return characters
  remove_delimiter "uptime_array" $'\r'

  #creating empty array updated_uptime
  for i in "${uptime_array[@]}"; do
    #removing comma from data in uptime_array and storing it in updated_uptime array
    updated_uptime+=("$(echo "$i" | tr -d ',')")
  done

  # Print the Uptime array elements
  # echo "Uptime"
  # for element in "${updated_uptime[@]}"; do
  #   echo "$element"
  # done
  
  # Column 3 - Free Memory
  readarray -t memfree_array < <(grep "$search_string3" "$input_file" | cut -d':' -f2 | xargs -I MF echo 'MF')

  len_memfree_array=${#memfree_array[@]}
  memfree_avg="$((len_memfree_array/3))"

  # Call the function to calculate averages and store them in a n
  calculate_average "${memfree_array[@]}"

    # Call the function to remove carriage return characters
  remove_delimiter "memfree_array" $' kB'

  # Print the Uptime array elements
  # echo "MemFree"
  # for element in "${memfree_array[@]}"; do
  #   echo "$element"
  # done

  # Print the data metrics array
  
  for i in "${!mnemonic_array[@]}"; do
  #for i in "${!soak_duration_array[@]}"; do
    
    # printf "%.2f\n" "${result_array[i]}"
    uptime="${updated_uptime[i]}"
    uptime=$(convert_to_hours "$uptime")
    # printf "%-15s %-15s %s\n" "${soak_duration_array[i]},$uptime,${result_array[i]}" >> "$combined_csv_file"
    printf "%-15s %-15s %s\n" "${mnemonic_array[i]},$uptime,${result_array[i]}" >> "$combined_csv_file"
    
  done

}

## Function to remove a specified delimiter from array elements
remove_delimiter() {
  local array_name=("$1")      # Get the array name as the first argument
  local delimiter="$2"         # Get the delimiter to remove as the second argument
  local -n array_ref="$array_name"  # Create a reference to the array

  for i in "${!array_ref[@]}"; do
    array_ref[$i]=${array_ref[$i]//$delimiter/}  # Use parameter expansion to remove the delimiter
  done
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
    formatted_average=$(printf "%.0f" $average)

    # Add the formatted average to the result array
    result_array+=("$formatted_average")

  done

  # Print the result array
  # echo "${result_array[@]}"

}

# Convert hours from day and skip minutes
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
    # result="${total_hours}:${minutes},"
    result="${total_hours}"

    echo "$result"
}

# Create metrics output file for logging metrics details
create_files() {

  local device_array=("$@")  # Get the array as an argument
  
  for i in "${!device_array[@]}"; do
     mnemonic="${device_array[i]//[$'\r']}"
     filename="$mnemonic""_$metrics_suffix"
     touch "$filename" 
  done
}

build_metrics_arrays "Iteration1.txt"
build_metrics_arrays "Iteration2.txt"
build_metrics_arrays "Iteration3.txt"
# python plot_device_metrics.py