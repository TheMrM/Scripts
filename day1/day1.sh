#!/bin/bash

INFILE="input.txt"
A=()
B=()

# We read the numbers from the input file
while read -r num1 num2; do
    A+=("$num1")
    B+=("$num2")
done < "$INFILE"

# We sort the two arrays in ascending order
A=($(printf "%s\n" "${A[@]}" | sort -n))
B=($(printf "%s\n" "${B[@]}" | sort -n))

# We calculate the differences between the two arrays and store them in a new Array C
# The new array C will contain the sum of the differences between the two arrays
C=()
sum=0
for val in "${!A[@]}"; do
    diff=$(( ${B[$val]} > ${A[$val]} ? ${B[$val]} - ${A[$val]} : ${A[$val]} - ${B[$val]} ))
    C+=("$diff")
    sum=$((sum + diff))
done

# We print the arrays and the sum of the differences
echo "Array A: "
printf "%s\n" "${A[@]}"

echo "Array B: "
printf "%s\n" "${B[@]}"

echo "Array C: " 
printf "%s\n" "${C[@]}"

echo "Sum of differences: $sum"
