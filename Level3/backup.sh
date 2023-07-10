#!/bin/bash

# Create the directory structure
mkdir -p important
mkdir -p backup

echo "Important directory created"
sleep 1
# Create 10 .txt files in the 'important' folder
for i in {1..10}
do
    touch important/file$i.txt
done

echo "10 .txt files created"
sleep 1
# Copy the contents of 'important' to 'backup'
mv important/* backup
sleep 1
# Delete the 'important' folder
rm -r important
