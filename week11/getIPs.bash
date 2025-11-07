#! /bin/bash
# If access.txt is not ready, get it first
logFile="access.txt"

if [[! -f "${logFile}"]]
then
	bash getLogs.bash
fi

# Do what you willl do 

cut -d' ' -f 1 access.txt | sort -n | uniq -c
