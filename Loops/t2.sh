#! /usr/bin/env bash
convert_to_hours() {
    # input="1 day 18:44"
    input="$1"   
    IFS=' ' read -ra parts <<< "$input"
    day_part="${parts[0]}"  # Extract the day part
    time_part="${parts[2]}"  # Extract the time part
    IFS=':' read -ra time_parts <<< "$time_part"
    hours="${time_parts[0]}"  # Extract the hours
    minutes="${time_parts[1]}"  # Extract the minutes

    # Convert day_part and hours to hours and then add them together
    total_hours=$((day_part * 24 + hours))

    # Format the result as "total_hours:minutes"
    result="${total_hours}:${minutes}"

    echo "$result"
}

convert_to_hours "1 day 19:08"