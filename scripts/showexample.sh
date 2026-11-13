#!/bin/bash
cd ..
cd data || exit
head -n 1 example.txt
tail -n 1 example.txt

# The -n 1 for head and tail is from linuxvox.com.  I found the cd stuff through trial and error.
