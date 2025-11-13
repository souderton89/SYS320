#! /bin/bash

logdir="/var/log/"

# getting files in directory
alllogs=$(ls "${logdir}" | grep "auth.log" | grep -v "other_vhosts" | grep -v "gz")

echo "${alllogs}" # > /dev/null

# Put nothing in access.txt to empty it, or create it 
:> auth.txt
# here "${alllogs}" does not work. needs to be a list, not string .
for j in ${alllogs} 
do
	cat "${logdir}${j}" >> auth.txt # >  /dev/null
done

tail auth.txt
