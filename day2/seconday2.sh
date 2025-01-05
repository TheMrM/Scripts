#!/bin/bash

# Define the input file
INFILE="inputdata.txt"

# Print an introductory message with a brief description of the data
echo "Here are the reports. They are a matrix, where the first element represents the number of the report"

# Read all lines from the input file into an array called 'reports'
readarray -t reports < "$INFILE"

# Initialize a counter for the number of safe reports
safe_count=0

# Define a function to check if a sequence is safe
function is_safe {
    local -a data=("${@}")  # Local array to hold the sequence of numbers
    local prev=${data[0]}   # Store the first number as the initial previous value
    local direction=0       # Direction of sequence, 0=unset, 1=increasing, -1=decreasing
    local diffs=()          # Array to hold differences between consecutive numbers

    # Calculate differences between consecutive numbers
    for ((i = 1; i < ${#data[@]}; i++)); do
        local diff=$((data[i] - prev))
        diffs+=($diff)      # Add difference to diffs array
        prev=${data[i]}     # Update previous number
    done

    # Check each calculated difference
    for diff in "${diffs[@]}"; do
        # Invalid if difference is zero or out of the allowed range
        if ((diff == 0 || diff < -3 || diff > 3)); then
            return 1
        fi

        # Set direction if not already set
        if ((direction == 0)); then
            direction=$((diff > 0 ? 1 : -1))
        elif ((direction == 1 && diff < 0)) || ((direction == -1 && diff > 0)); then
            return 1  # Change in direction detected, return invalid
        fi
    done

    return 0  # If all checks pass, return valid
}

# Iterate over each line from the reports
for line in "${reports[@]}"; do
    # Convert the line into an array of numbers
    read -r -a numbers <<< "$line"
    
    # First, try checking the sequence without modification
    if is_safe "${numbers[@]}"; then
        echo "$line is SAFE"
        ((safe_count++))
    else
        # If the sequence was not safe, try removing one element at a time
        local found_safe=0
        for ((j = 0; j < ${#numbers[@]}; j++)); do
            local temp=("${numbers[@]}")
            unset temp[j]  # Remove the element at index j
            temp=("${temp[@]}")  # Reindex array after removal

            # Check if the modified sequence is safe
            if is_safe "${temp[@]}"; then
                echo "$line is SAFE with Problem Dampener by removing element at index $j"
                found_safe=1
                ((safe_count++))
                break  # Exit the loop once a safe modification is found
            fi
        done
        # If no safe modification was found, mark the line as unsafe
        if ((found_safe == 0)); then
            echo "$line is UNSAFE"
        fi
    fi
done

# Print the total number of safe reports
echo "Total number of safe reports with Problem Dampener: $safe_count"

