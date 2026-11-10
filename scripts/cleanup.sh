#!/bin/bash
# cleanup.sh - remove old temporary files

echo "Starting cleanup"

for file in "data/temp.txt" "data/old.log" "data/cache.tmp"; do
  rm "$file"
done

echo "Cleanup complete"
