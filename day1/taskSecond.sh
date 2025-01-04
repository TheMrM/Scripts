#!/bin/bash
# Just like before we read the input file and store the values in two arrays A and B.
INFILE="input.txt"
A=()
B=()

while read -r num1 num2; do
    A+=("$num1")
    B+=("$num2")
done < "$INFILE"

# We sort the arrays A and B in ascending order.
mapfile -t A < <(printf "%s\n" "${A[@]}" | sort -n)
mapfile -t B < <(printf "%s\n" "${B[@]}" | sort -n)


# Now the fun part begins.
# We iterate over the elements of A. Each time we find an element from A
# that is also present in B, we multiply it with the number of times we # find it in B and add it to the sum.
sum=0

# Loop that iterates over the elements of A.
for ((i=0; i<${#A[@]}; i++)); do
    count=0
    
    # Loop that iterates over the elements of B.
    for b in "${B[@]}";do
        # If the element from A is also present in B, we increment the count.
        [[ "$b" -eq "${A[i]}" ]] && ((count++))
    done

    # We multiply the element from A with the count and add it to the sum.
    sum=$((sum +A[i] * count))
done

echo "Sum of values from A that repeat themselves in B: $sum"
