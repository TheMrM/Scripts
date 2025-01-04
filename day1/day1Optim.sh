#!/bin/bash

INFILE="input.txt"
A=()
B=()

# Read and sort both columns at once using awk and process substitution
while read -r num1 num2; do
    A+=("$num1")
    B+=("$num2")
done < "$INFILE"

mapfile -t A < <(printf '%s\n' "${A[@]}" | sort -n)
mapfile -t B < <(printf '%s\n' "${B[@]}" | sort -n)

# Calculate differences and sum in one pass
sum=0
for ((i=0; i<${#A[@]}; i++)); do
    diff=$(( ${B[i]} > ${A[i]} ? ${B[i]}-${A[i]} : ${A[i]}-${B[i]} ))
    C+=("$diff")
    ((sum += diff))
done

# Optional: print results
echo "Array A: ${A[*]}"
echo "Array B: ${B[*]}"
echo "Array C: ${C[*]}"
echo "Sum of differences: $sum"

