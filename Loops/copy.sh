# Function to calculate the average of every three elements
calculate_average() {

  local input_array=("$@")
  local num_elements=${#input_array[@]}
  echo $num_elements
  exit 0
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
    sum=$((val1 + val2 + val3))
    
    # Calculate the average and store it in a new array
    average=$((sum / 3))
    
    # Format the average with two decimal places
    formatted_average=$(printf "%.2f" "$(bc -l <<< "$average / 1.0")")

    # Add the formatted average to the result array
    result_array+=("$formatted_average")

  done

  # Print the result array
  # echo "${result_array[@]}"

}

# Define a function to populate Excel spreadsheet from arrays
populate_excel() {
  local file_name="$1"         # The name of the Excel file to be created
  local sheet_name="$2"        # The name of the Excel sheet
  # local mnemonic_array=("${@:3}")     # Array containing mnemonic data
  # local uptime_array=("${@:4}")       # Array containing uptime data
  # local memfree_array=("${@:5}")      # Array containing MemFree data

  # Check if the arrays have the same length
  if [ ${#mnemonic_array[@]} -ne ${#uptime_array[@]} ] || [ ${#mnemonic_array[@]} -ne ${#result_array[@]} ]; then
    echo "Arrays must have the same length."
    return 1
  fi

  # Remove the Excel file if it already exists
  if [ -e "$file_name" ]; then
    rm "$file_name"
  fi

  # Create a Python script to generate the Excel spreadsheet
  cat <<EOF > excel_generator.py
import xlsxwriter
import json

# Define the file name and sheet name
file_name = "$file_name"
sheet_name = "$sheet_name"

# Define arrays from JSON strings
mnemonic_array = json.loads('''${mnemonic_array[*]}''')
uptime_array = json.loads('''${uptime_array[*]}''')
memfree_array = json.loads('''${memfree_array[*]}''')

# Create a new Excel workbook and sheet
workbook = xlsxwriter.Workbook(file_name)
worksheet = workbook.add_worksheet(sheet_name)

# Write headers to the Excel sheet
worksheet.write(0, 0, "Mnemonic")
worksheet.write(0, 1, "Uptime")
worksheet.write(0, 2, "MemFree")

# Write data from arrays to the Excel sheet
for i in range(len(mnemonic_array)):
    worksheet.write(i + 1, 0, mnemonic_array[i])
    worksheet.write(i + 1, 1, uptime_array[i])
    worksheet.write(i + 1, 2, memfree_array[i])

# Close the workbook
workbook.close()
print(f"Excel spreadsheet '{file_name}' created successfully.")
EOF

  # Execute the Python script to generate the Excel file
  python3 excel_generator.py

  # Remove the temporary Python script
  rm excel_generator.py

  echo "Excel spreadsheet '$file_name' created successfully."
}

# Example usage:
# Call the populate_excel function with the sample data
echo "${#mnemonic_array[@]} ${#uptime_array[@]} ${#result_array[@]}"
# populate_excel "output.xlsx" "Sheet1" "${mnemonic_array[@]}" "${uptime_array[@]}" "${result_array[@]}"
