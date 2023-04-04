#! /bin/bash

# IFS internal field separator
# The -n +2 (line number) option tells tail to start reading at line number two.
# The <(...) construct is called process substitution. It causes Bash to accept 
# the output of a process as though it were coming from a file descriptor. 
# This is then redirected into the while loop, providing the text that 
# the read command will parse.

while IFS="," read -r id firstname lastname jobtitle email state
do
  echo "Record ID: $id"
  echo "Firstname: $firstname"
  echo " Lastname: $lastname"
  echo "Job Title: $jobtitle"
  echo "Email add: $email"
  echo "    State: $state"
  echo ""
done < <(tail -n +2 customers.csv)

# while IFS="," read -r id jobtitle state
# do
  # echo "Record ID: $id"
  # echo "Job Title: $jobtitle"
  # echo " State: $state"
  # echo ""
# done < <(cut -d "," -f1,4,6 sample.csv | tail -n +2)