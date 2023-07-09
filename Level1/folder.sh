#!/bin/bash

# This script will create a folder in the current directory

# Greeting message for the user
echo -e "Hello, $USER. Welcome to the folder creator script."
echo "This script will create a folder in the current directory."

# Start the loop
while true; do

  # Ask the user for the folder name
  read -p "Type the name of the folder you would like to create (or type 'no' to exit): " folderName

  # Exit the loop if user enters 'no'
  if [ "$folderName" == "no" ]; then
    break
  fi

  # Create the folder
  mkdir "$folderName" && echo "You have created a folder called $folderName"

  # Ask the user if they want to create a folder or a .txt file in the new folder
  read -p "Would you like to create a folder or a .txt file in $folderName? (folder, .txt , exit): " folderOrFile

  # If the user selects 1, create a folder in the new folder
  if [ "$folderOrFile" == "folder" ]; then
    read -p "Type the name of the folder you would like to create in $folderName: " newFolderName
    mkdir "$folderName/$newFolderName" && echo "You have created a folder called $newFolderName in $folderName"
  # If the user selects 2, create a .txt file in the new folder
  elif [ "$folderOrFile" == ".txt"]; then
    read -p "Type the name of the .txt file you would like to create in $folderName: " newFileName
    touch "$folderName/$newFileName.txt" && echo "You have created a .txt file called $newFileName in $folderName"
  # If the user selects 3, exit the loop and terminate the script
  elif [ "$folderOrFile" == "exit" ]; then
    break
  else
    echo "You have not selected a valid option"
  fi
done

# Exit the program
exit 0

