#!/bin/bash

print_linear_equations_matrix() {
  local num_eqn=$(($#/2))  # Number of equations

  if [ $num_eqn -eq 0 ]; then
    echo "No equations provided."
    return 1
  fi

  local max_len=0
  local matrix=()

  # Determine the maximum length of any equation for formatting
  for ((i = 0; i <num_eqn; i++)); do
    local equation=""
    for ((j = 0; j < 2; j++)); do
      local index=$((i*2+j))
      local item="${!index}"
      equation+=" $item"
    done
    matrix+=("$equation")
    len=${#equation}
    if [ $len -gt $max_len ]; then
      max_len=$len
    fi
  done

  # Print the equations as a matrix with consistent spacing
  for ((i = 0; i <num_eqn; i++)); do
    local equation="${matrix[$i]}"
    printf "%-${max_len}s" "$equation"
    if [ $i -eq 0 ]; then
      printf "\n"
    else
      printf "\n"
    fi
  done
}

# Example usage:
print_linear_equations_matrix 2x -1y 3z 0 4x 2y -2z 1