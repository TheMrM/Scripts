#!/bin/bash

echo "Input the FOLDER name"
read Folder_name
echo "Creating Folder"
mkdir "$Folder_name"
echo "Done"
echo "The $Folder_name has been created"
touch "$Folder_name/Name" "$Folder_name/Surname"
echo "Our current directory"
ls -l
echo "Here are the files inside our folder $Folder_name"
ls -l "$Folder_name"

if [ -d "$Folder_name" ]; then
	echo "Folder '$Folder_name' found."

	read -p "Are you sure you want to delete the folder '$Folder_name'? (y/n): " confirm
	if [[ "$confirm" == [yY] ]]; then
		rm -r "$Folder_name"
		echo "Folder '$Folder_name' has been removed"
	else
		echo "Deletion was not possible."
	fi
else
	echo "Folder '$Folder_name' does not exist. Nothing to clean up."
fi
	
