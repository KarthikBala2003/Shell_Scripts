#!/bin/bash

matrix_A=(2 -1 -1 2)
matrix_B=(0 3)
matrix_X=(x y)

print_matrix() {
  # Check if the number of arguments is correct
  if [ "$#" -ne 2 ]; then
    echo "Usage: print_matrix <array> <num_columns>"
    return 1
  fi

  # Extract the array and num_columns from arguments
  local array=("${!1}")
  local num_columns="$2"

  # Get the total number of elements in the array
  local num_elements="${#array[@]}"

  # Calculate the number of rows based on the number of columns
  local num_rows=$(( (num_elements + num_columns - 1) / num_columns ))

  # Iterate through the array and print elements in matrix format
  local index=0
  for ((row = 0; row < num_rows; row++)); do
    for ((col = 0; col < num_columns; col++)); do
     local array_index=$((row * num_columns + col))
      if [ "$array_index" -lt "$num_elements" ]; then
        printf "%-5d" "${array[array_index]}"
      fi
    done
    echo
  done
}


mat_A_num_columns=2
mat_B_num_columns=1

echo "Matrix A"
print_matrix matrix_A[@] "$mat_A_num_columns"

echo 
echo "Matrix B"
print_matrix matrix_B[@] "$mat_B_num_columns"
