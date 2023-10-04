#!/bin/bash


# Initialize a variable to store the product of diagonal elements
diagonal_product=1

print_matrix_and_multiply_diagonal() {
  # Check if the number of arguments is correct
  if [ "$#" -ne 2 ]; then
    echo "Usage: print_matrix_and_multiply_diagonal <array> <num_columns>"
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
        local element="${array[array_index]}"
        printf "%-5d" "$element"
        
        # Check if the element is on the diagonal (row == col)
        if [ "$row" -eq "$col" ]; then
          diagonal_product=$((diagonal_product * element))
        fi
      fi
    done
    echo
  done

  # Print the product of diagonal elements at the end
  echo "Product of diagonal elements: $diagonal_product"
}

# Example usage:
matrix_A=(2 -1 -1 2)
num_columns=2

print_matrix_and_multiply_diagonal matrix_A[@] "$num_columns"
