#!/bin/bash
# wordcount.sh - count the words in the sample text file

file="data/sample.txt"

if [ ! -f "$file" ]; then
  echo "Words: 0"
  exit 0
fi

words=$(wc -w < "$file")
words=$((words))

if [ "$words" -eq 0 ]; then
  echo "Nothing to count"
  exit 1
fi

echo "Words: $words"
