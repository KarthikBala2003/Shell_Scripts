#!/bin/bash

# Define arrays
# mnemonic_array=("G-120G-E", "G-140W-F", "G-140W-G", "G-120W-F", "G-40W-H")
# uptime_array=("1 day, 18:44" "1 day, 18:46" "1 day, 18:48" "1 day, 18:37" "1 day, 18:52")

# Define the three arrays
mnemonic_array=()
readarray -t mnemonic_array < <(grep "the Mnemonic:" Iteration2.txt | cut -d':' -f2 | xargs -I MN echo 'MN')

uptime_array=()
readarray -t uptime_array < <(grep "day" Iteration2.txt | cut -d',' -f1-2 | cut -d' ' -f4-6 | xargs -I UP echo 'UP') 

# Create a Python script to generate the Excel file
cat <<EOF > generate_excel.py
import xlsxwriter

# Create a new Excel workbook
workbook = xlsxwriter.Workbook('metrics.xlsx')
worksheet = workbook.add_worksheet()

# Define format for headers
header_format = workbook.add_format({'bold': True, 'align': 'center', 'valign': 'vcenter'})

# Define data
mnemonic_array = "${mnemonic_array[@]}"
uptime_array = "${uptime_array[@]}"

# Write headers to the worksheet
worksheet.write(0, 0, 'Mnemonic', header_format)
worksheet.write(0, 1, 'Uptime', header_format)

# Write data to the worksheet
for row, (mnemonic, uptime) in enumerate(zip(mnemonic_array, uptime_array), start=1):
    worksheet.write(row, 0, mnemonic)
    worksheet.write(row, 1, uptime)

# Close the workbook
workbook.close()
EOF

# Run the Python script to generate the Excel file
python generate_excel.py

# Remove the temporary Python script
# rm generate_excel.py
