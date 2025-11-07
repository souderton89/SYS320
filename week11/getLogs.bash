#! /bin/bash

logdir="/var/log/apache2/"

# getting files in directory
alllogs=$(ls "${logdir}" | grep "access.log" | grep -v "other_vhosts" | grep -v "gz")

echo "${alllogs}" # > /dev/null

# Put nothing in access.txt to empty it, or create it 
:> access.txt
# here "${alllogs}" does not work. needs to be a list, not string .
for j in ${alllogs} 
do
	cat "${logdir}${j}" >> access.txt # >  /dev/null
done

tail access.txt
