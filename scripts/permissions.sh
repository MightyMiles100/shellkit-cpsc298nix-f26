#!/bin/bash
# permissions.sh - report whether each project script is executable

for script in scripts/*.sh; do
  if [ -x "$script" ]; then
    echo "$script: executable"
  else
    echo "$script: not executable"
  fi
done
