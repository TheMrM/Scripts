#!/bin/bash

INFILE="inputdata.txt"

echo "Here are the reports. They are a matrix, first element reprezents the number of the report"

#We read all the lines from the report matrix and print them out

#while IFS= read -r line; do
#    echo "$line"
#done < "$INFILE"



#Another method is to use readarray

readarray -t reports < "$INFILE"

safe_count=0


for line in "${reports[@]}"; do
    read -r -a numbers <<< "$line"
    
    ignore_line=false
    first_valid_diff=0
    is_ascending=0
    
    # Loop through all numbers in the reports
    for ((i = 0; i < ${#numbers[@]} - 1; i++)); do
        diff=$((numbers[i + 1] - numbers[i]))

        # Check for zero difference (equal numbers)
        if (( diff == 0 )); then
            ignore_line=true
            break
        fi

        # Check if difference is outside allowed range (1-3 or -3 to -1)
        if (( diff < -3 || diff > 3 )); then  # Removed diff == 0 as it's checked above
            ignore_line=true
            break
        fi

        # Set direction based on first difference
        if (( first_valid_diff == 0 )); then
            is_ascending=$((diff > 0 ? 1 : 0))
            first_valid_diff=1
        fi

        # Check if direction changes
        if (( is_ascending == 1 && diff < 0)) || (( is_ascending == 0 && diff > 0)); then
            ignore_line=true
            break
        fi
    done  # Added missing done for the inner for loop

    if ! $ignore_line && (( first_valid_diff == 1)); then
        echo "$line is valid"
        ((safe_count++))
    else
        echo "$line is not valid"
    fi
done  # Added missing done for the outer for loop

echo "Total number of safe reports: $safe_count"

#This simply prints the file
#cat "$INFILE" 
