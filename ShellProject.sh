#!/bin/bash

input_file="input.txt"
output_file="output.txt"

countFrequency() {
    declare -A word_frequency
    while IFS= read -r word; do
        ((word_frequency[$word]++))
    done < "$input_file"

    echo "word,freq" > "$output_file"
    for word in "${!word_frequency[@]}"; do
        echo "$word,${word_frequency[$word]}" >> "$output_file"
    done
}

sortByFrequency() {
    sort -t ',' -k2nr "$output_file" -o "$output_file"
}

countFrequency
sortByFrequency

echo "Word frequency saved to $output_file"

