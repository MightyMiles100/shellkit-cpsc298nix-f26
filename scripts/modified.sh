#!/bin/bash
# modified.sh - list files in the data directory modified in the last day

find data -maxdepth 1 -type f -mtime +0 | sort
