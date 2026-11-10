#!/bin/bash
# commonwords.sh - list words from the sample text by how often they appear

tr -cs '[:alnum:]' '\n' < data/sample.txt | tr '[:upper:]' '[:lower:]' | sed '/^$/d' | sort | uniq -c | sort -n
