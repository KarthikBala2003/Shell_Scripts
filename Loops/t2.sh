#!/bin/bash

# Define the metrics_suffix
metrics_suffix="_Metrics.txt"

# Define the mnemonic_array
mnemonic_array=()
readarray -t mnemonic_array < <(grep "the Mnemonic:" Iteration2.txt | cut -d':' -f2 | xargs -I MN echo 'MN')

# Function to add metrics_suffix to each element
add_suffix_to_array_elements() {
  local array_name=("$@")  # Get the array as an argument
  local array=("${!array_name}")  # Access the array using its name
  local modified_array=("${array[@]/%$metrics_suffix}")  # Add the suffix to each element
  echo "${modified_array[@]}"
}

# Call the function to modify the mnemonic_array
modified_mnemonic_array=($(add_suffix_to_array_elements mnemonic_array))

# Print the modified array
echo "Modified Mnemonic Array:"
for element in "${modified_mnemonic_array[@]}"; do
  echo "$element"
done
