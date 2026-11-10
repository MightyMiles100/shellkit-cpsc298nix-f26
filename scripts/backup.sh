#!/bin/bash
# backup.sh - save a copy of the sample text file

source_file="data/sample.txt"
backup_dir="backups"
backup_path="$backup_dir/sample.txt"

if [ ! -f "$source_file" ]; then
  echo "Error"
  exit 1
fi

mkdir -p "$backup_dir"

cp "$source_file" "$backup_path"

if [ ! -f "$backup_path" ]; then
  echo "Error"
  exit 1
fi

echo "Backup complete"
