
#! /usr/bin/env bash

# Initialize all arrays
soak_duration_array=()
mnemonic_array=()
updated_uptime=()
memfree_array=()

result_array=()

metrics_suffix="_Metrics.txt"

# Create data array
build_metrics_arrays() {
  # Initialize column headers
  header1="Soak Duration"
  header2="Uptime"
  header3="MemFree"

  # Device Array
  readarray -t mnemonic_array < <(grep "the Mnemonic:" Iteration2.txt | cut -d':' -f2 | xargs -I MN echo 'MN')
  
  # Call the function to remove carriage return characters
  remove_delimiter "mnemonic_array" $'\r'

  # Create metrics output files to log data
  # create_files "${mnemonic_array[@]}"

   # Column 1 - Soak Duraion
  soak_duration_array=($(seq 0 8 72))

  # Column 2 - Uptime
  uptime_array=()
  readarray -t uptime_array < <(grep "day" Iteration2.txt | cut -d',' -f1-2 | cut -d' ' -f4-6 | xargs -I UP echo 'UP')

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
  readarray -t memfree_array < <(grep "MemFree:" Iteration2.txt | cut -d':' -f2 | xargs -I MF echo 'MF')

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
  # Print headers with equal spacing
  printf "%-15s %-15s %-15s\n" "$header1,$header2,$header3" >> metrics.csv
  
   for i in "${!mnemonic_array[@]}"; do
    
    # printf "%.2f\n" "${result_array[i]}"
    uptime="${updated_uptime[i]}"
    uptime=$(convert_to_hours "$uptime")
    printf "%-15s %-15s %s\n" "${mnemonic_array[i]},$uptime,${result_array[i]}" >> metrics.csv
    
  done
  write_files
  final_csv

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

print_metrics_arrays() {
  # Initialize column headers
  header1="Mnemonic"
  header2="Uptime"
  header3="MemFree"


   # Define the metrics arrays
  mnemonic_array=()
  readarray -t mnemonic_array < <(grep "the Mnemonic:" Iteration2.txt | cut -d':' -f2 | xargs -I MN echo 'MN')

  #create_files "${mnemonic_array[@]}"

  exit 0
 
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
  #generate_csv
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
  #write_files 
  
}
#write_files() {
  #for i in "${mnemonic_array[@]}"; do
     #row=$(grep "^$i," metrics.csv)
     
     #if [ -n "$row" ]; then
       #column1=$(echo "$row" | cut -d ',' -f 2)
       #column2=$(echo "$row" | cut -d ',' -f 3)
       
       #echo "$column1,$column2" >> "${i}_output.csv"
     #fi
  #done
#}

#write_files() {
 #while IFS=',' read -r col1 col2 col3; do
   #for element in "${mnemonic_array[@]}"; do
     #if [ "$col1" == "$element" ]; then
       #echo "$col2,$col3" > "${element}_output.csv"
     #fi
   #done
 #done < metrics.csv
#}

write_files() {
declare -A extracted_values

# Read each line of the "metrics.csv" file
while IFS=',' read -r col1 col2 col3; do
  for element in "${mnemonic_array[@]}"; do
    if [ "$col1" == "$element" ]; then
      # Print the matching string
      #echo "Matching string found: $element"
      
      # Append the extracted values to the associative array
      extracted_values["$element"]+="$col2,$col3"$'\n'
      echo"$extracted_values["$element"]"
    fi
  done
done < metrics.csv

#header="soak_duration,uptime,free_memory"
# Create separate output files for each matching string
soak=("0" "8" "72")
for element in "${mnemonic_array[@]}"; do
  
 #echo "$header" > "${element}_output.csv"
  if [ -n "${extracted_values["$element"]}" ]; then
    #echo "$header" > "${element}_output.csv"
    echo -e "${extracted_values["$element"]}" > "${element}_output.csv"
    sort "${element}_output.csv" | uniq | sed '1d' > "${element}_temp.csv"
    #paste -d',' <(echo "${soak[@]}") "${element}_output.csv" > "${element}_temp.csv"
    rm "${element}_output.csv"
    mv "${element}_temp.csv" "${element}_output.csv"
    #echo "$header" >> "${element}_output.csv"
  fi
  #paste -d',' <(seq 0 8 16) "${element}_output.csv"
done
}

final_csv() {
  # Define the soak duration sequence
  soak_duration=("0" "8" "16")

  # Directory where CSV files are located
  csv_directory=`pwd`

  # Get a list of CSV files in the specified directory
  csv_files=("$csv_directory"/*.csv)

  # Process each CSV file
  for file in "${csv_files[@]}"; do
      # Create a temporary file to store the modified output
      temp_file="temp_output.csv"

      # Initialize a counter
      counter=0

      # Read the input CSV and add the sequence as the first column
      while IFS=, read -r col2 col3; do
          # Add the soak duration from the sequence
          echo "${soak_duration[counter]},$col2,$col3" >> "$temp_file"
          counter=$((counter + 1))
      done < "$file"

      # Replace the original CSV with the modified file
      mv "$temp_file" "$file"
  done
}

#soak_duration=("0" "8" "72")

# Function to add the first column to a CSV file



#print_metrics_arrays
build_metrics_arrays
print_metrics_arrays
#print_metrics_arrays
#python plot_device_metrics.py
