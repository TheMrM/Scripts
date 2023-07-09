#!/bin/bash

# Generate a list a randome number of words
# store it in a .txt file

# Check if the file exists and removes it so we can continue generating new words
# every time we use the script
function remove_file {
	if [ -f wordlist.txt ]; then
		rm wordlist.txt
	fi
}


echo "Enter the number of words to generate: "
read -r wordcount
echo "Generating $wordcount words..."

# Check if wordlist.txt exists and remove it if it does
remove_file "wordlist.txt"

for ((i=0; i<$wordcount; i++))
do
	word=$(shuf -n 1 /usr/share/dict/words)
	echo "$word" >> wordlist.txt
done

echo "Random words generated and stored in wordlist.txt"
cat wordlist.txt
