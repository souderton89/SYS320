#! /bin/bash

function suspiciousVisitors(){
        ioc="/home/champuser/sys320/week15/IOC3.txt"
	logfile="/var/log/apache2/access.log"

	results=$(cat "$logfile" | grep -F -f "$ioc" | tr -d "[" | cut -d' ' -f1,4,7 | sort -n | uniq -c)

	echo "$results"

	sed 's/^[[:space:]]\+//; s/[[:space:]]\+$//' report.txt
}
suspiciousVisitors > report.txt
