#!/bin/bash

# Function to populate data from a text file into an Excel file
populate_excel() {
  local text_file="$1"          # Input text file
  local excel_file="$2"         # Output Excel file
  local sheet_name="$3"         # Excel sheet name

  if [ ! -f "$text_file" ]; then
    echo "Input text file '$text_file' does not exist."
    return 1
  fi

  # Create a Python script to generate the Excel spreadsheet
  cat <<EOF > excel_generator.py
import xlsxwriter

text_file = "$text_file"
excel_file = "$excel_file"
sheet_name = "$sheet_name"

# Open the text file for reading
with open(text_file, 'r') as file:
    lines = file.readlines()

# Create an Excel workbook and add a worksheet
workbook = xlsxwriter.Workbook(excel_file)
worksheet = workbook.add_worksheet(sheet_name)

# Write headers to the Excel sheet
headers = lines[0].split()
for col, header in enumerate(headers):
    worksheet.write(0, col, header)

# Write data to the Excel sheet
for row, line in enumerate(lines[1:]):
    data = line.split(None, 1)  # Split only at the first space
    mnemonic = data[0]
    rest = data[1].split(None, 1)  # Split the remaining data at the first space
    uptime = rest[0]
    memfree = rest[1].strip()
    worksheet.write(row + 1, 0, mnemonic)  # Write the first column
    worksheet.write(row + 1, 1, uptime)    # Write the second column
    worksheet.write(row + 1, 2, memfree)   # Write the third column

workbook.close()

EOF

  # Execute the Python script to generate the Excel file
  python3 excel_generator.py

  # Remove the temporary Python script
  # rm excel_generator.py

  echo "Excel spreadsheet '$excel_file' created successfully."
}

# Example usage:
# Call the populate_excel function with the input text file, output Excel file, and sheet name
populate_excel "metrics.txt" "output.xlsx" "Sheet1"
