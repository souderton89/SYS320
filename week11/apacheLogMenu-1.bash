#! /bin/bash

logFile="/var/log/apache2/access.log.1"



#function suspiciousVisitors()







function displayAllLogs(){
	cat "$logFile"
}

function displayOnlyIPs(){
        cat "$logFile" | cut -d ' ' -f 1 | sort -n | uniq -c
}

# function: displayOnlyPages:
function displayOnlyPages(){
   file="/var/log/apache2/access.log"

   results=$(cat "$file" | cut -d' ' -f7 | sort -n | uniq -c )

  echo "$results"

}
# like displayOnlyIPs - but only pages

function histogram(){

	local visitsPerDay=$(cat "$logFile" | cut -d " " -f 4,1 | tr -d '['  | sort \
                              | uniq)
	# This is for debugging, print here to see what it does to continue:
	# echo "$visitsPerDay"

        :> newtemp.txt  # what :> does is in slides
	echo "$visitsPerDay" | while read -r line;
	do
		local withoutHours=$(echo "$line" | cut -d " " -f 2 \
                                     | cut -d ":" -f 1)
		local IP=$(echo "$line" | cut -d  " " -f 1)
          
		local newLine="$IP $withoutHours"
		echo "$IP $withoutHours" >> newtemp.txt
	done 
	cat "newtemp.txt" | sort -n | uniq -c
}

# function: frequentVisitors: 
function frequentVisitors(){
   file="/var/log/apache2/access.log.1"

        results=$(cat "$file" | cut -d' ' -f1,4 | sort -n | uniq -c | tr -d "[")

      echo "$results"
  }



# Only display the IPs that have more than 10 visits
# You can either call histogram and process the results,
# Or make a whole new function. Do not forget to separate the 
# number and check with a condition whether it is greater than 10
# the output should be almost identical to histogram
# only with daily number of visits that are greater than 10 

# function: suspiciousVisitors
function suspiciousVisitors(){
	bash getLogs.bash | exec >/dev/null 2>&1
	file="/home/champuser/sys320/week11/access.txt"

#	ioc="/home/champuser/sys320/week11/IOC.txt

#	results=$(cat "$file" | cut -d' ' -f1 | tr -d "Chrome" | tr -d "Firefox" | tr -d "Edge" | tr -d "Firefox" | uniq -c)

	results=$(cat "$file" | cut -d' ' -f1 | uniq -c)

	echo "$results"
}

# Manually make a list of indicators of attack (ioc.txt)
# filter the records with this indicators of attack
# only display the unique count of IP addresses.  
# Hint: there are examples in slides

# Keep in mind that I have selected long way of doing things to 
# demonstrate loops, functions, etc. If you can do things simpler,
# it is welcomed.

while :
do
	echo "PLease select an option:"
	echo "[1] Display all Logs"
	echo "[2] Display only IPS"
	# Display only pages visited
	echo "[3] Display Only Pages"

	echo "[4] Histogram"
	# Frequent visitors
	echo "[5] Frequent visitors"
	# Suspicious visitors
	echo "[6] Suspicious visitors "
	echo "[7] Quit"

	read userInput
	echo ""

	if [[ "$userInput" == "7" ]]; then
		echo "Goodbye"		
		break

	elif [[ "$userInput" == "1" ]]; then
		echo "Displaying all logs:"
		displayAllLogs

	elif [[ "$userInput" == "2" ]]; then
		echo "Displaying only IPS:"
		displayOnlyIPs

	# Display only pages visited

	 elif [[ "$userInput" == "3" ]]; then
                  echo "Displayed visited pages:"
                  displayOnlyPages

	elif [[ "$userInput" == "4" ]]; then
		echo "Histogram:"
		histogram

        # Display frequent visitors

	elif [[ "$userInput" == "5" ]]; then
                  echo "Display frequent visitors"
                  frequentVisitors


	# Display suspicious visitors
	 elif [[ "$userInput" == "6" ]]; then
                   echo "Display suspicious visitors"
                   suspiciousVisitors



	# Display a message, if an invalid input is given
	fi
done

