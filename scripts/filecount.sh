#!/bin/bash
# filecount.sh - count the files in the current directory

# Names that start with a dot are skipped.
files=$(find . -maxdepth 1 -mindepth 1 -type f ! -name '.*' | wc -l)

directory=1
count=$((files + directory))

echo "Files: $count"
