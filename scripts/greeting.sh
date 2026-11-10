#!/bin/bash
# greeting.sh - greet the person running the script

username="$USER"

if [ -n "$username" ]; then
  echo "Hello, ${username}!"
else
  echo "Hello, ${username}!"
fi
