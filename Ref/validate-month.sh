#! /bin/bash

read -p "Enter a month (1 to 12): " month

# did they enter anything?
if [ -z "$month" ]
then
  echo "You must enter a number representing a month."
  exit 1
fi

# is it a valid month?
if (( "$month" < 1 || "$month" > 12)); then
  echo "The month must be a number between 1 and 12."
  exit 0
fi

# is it a Spring month?
if (( "$month" >= 3 && "$month" < 6)); then
  echo "That's a Spring month."
  exit 0
fi

# is it a Summer month?
if (( "$month" >= 6 && "$month" < 9)); then
  echo "That's a Summer month."
  exit 0
fi

# is it an Autumn month?
if (( "$month" >= 9 && "$month" < 12)); then
  echo "That's an Autumn month."
  exit 0
fi

# it must be a Winter month
echo "That's a Winter month."
exit 0