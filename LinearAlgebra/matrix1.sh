#!/bin/bash

# Define the array of integers
# int_array=(1 2 3 4 5 6 7 8 9)

matrix_A=(2 -1 -1 2)
matrix_B=(0 3)
matrix_X=(x y)

# Function to print the array in matrix format
print_matrix() {
    local arr=("$@")
    # local arr=("$1")
    local index=0
    local cols=$2

    array_length=${#arr[@]}
    rows=$((array_length / cols))

    for ((i = 0; i < $rows; i++)); do
        for ((j = 0; j < $cols; j++)); do
            printf "%4d " "${arr[index]}"
            ((index++))
        done
        echo # Newline after each row
    done
}

# Call the function to print the matrix
print_matrix "${matrix_A[@]}" 3
