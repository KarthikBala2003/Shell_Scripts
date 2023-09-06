#! /usr/bin/env bash

print_arrays() {
  # Define the three arrays
  array1=("G-120G-E" "G-120G-A" "G-120G-G")
  array2=("1 day, 18:44" "1 day, 20:44" "1 day, 08:44")
  array3=("2320 kB" "2120 kB" "2100 kB")

  # Get the length of any of the arrays (assuming they all have the same length)
  length=${#array1[@]}

  # Iterate through the arrays and print elements in a one-to-one relationship
  for ((i = 0; i < length; i++)); do
    printf "%-15s %-17s %s\n" "${array1[i]}" "${array2[i]}" "${array3[i]}"
  done
}

# Call the function to print the arrays
print_arrays
