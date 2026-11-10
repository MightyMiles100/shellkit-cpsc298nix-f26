#!/bin/bash
# emptyfiles.sh - list the empty files in the data directory

find data -maxdepth 1 -type f -size +0c | sort
