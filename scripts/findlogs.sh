#!/bin/bash
# findlogs.sh - print log lines that contain the word error

log_file="data/sample.log"

grep "error" "$log_file"
