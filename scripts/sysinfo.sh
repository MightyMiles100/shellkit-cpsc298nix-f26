#!/bin/bash
# sysinfo.sh - print a short system report

hostname=$(hostname)

if [ -r /etc/os-release ]; then
	os=$(grep "^NAME=" /etc/os-release | cut -d= -f2 | tr -d '"')
  else
	  os=$(uname -s)
  fi

echo "Hostname: $hostname"
	echo "Operating System: $os"
