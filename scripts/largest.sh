#!/bin/bash
# largest.sh - list entries in this directory by size

du -d 1 . | sort -n
