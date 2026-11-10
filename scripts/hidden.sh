#!/bin/bash
# hidden.sh - list the files in the data directory

find data -maxdepth 1 -type f ! -name '.*' | sort
