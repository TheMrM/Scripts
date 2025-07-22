#!/bin/bash

NAME="Name_Surname"

echo 'FILE="new_file"' > ~/vars

cat ~/vars

source ~/vars

mkdir "$NAME"
touch "$NAME/$FILE"

echo "This folder has"
ls

echo "The sub folder '$NAME' has:"
ls "$NAME"

if [ -d "$NAME" ]; then
	echo "Folder '$NAME' found"

	read -p "Are you sure you want to delete the folder '$NAME' ? (y/n): " confirm
	if [[ "$confirm" == [yY] ]]; then
		rm -r "$NAME"
		echo "Folder '$NAME' has been removed."
	else
		echo "Deletion cancelled."
	fi
else
	echo "Folder '$NAME' does not exist. Nothing to clean up."
fi
