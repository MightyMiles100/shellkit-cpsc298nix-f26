#!/bin/bash
# diskspace.sh - show disk usage for the root filesystem

line=$(df -h / | tail -n 1)
filesystem=$(echo "$line" | awk '{print $2}')
used=$(echo "$line" | awk '{print $5}')

echo "Filesystem: $filesystem"
echo "Used: $used"
