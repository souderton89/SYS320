#! /bin/bash


#file=/var/log/syslog
function access1(){
# Todo - 1
# a) Make a little research and experimentation to complete the function
	file=/var/log/syslog
	logline=$(cat "$file" | grep "File was accessed")
   dateAndUser=$(echo "$logline" | cut -d' ' -f11,12,13,1,2,3 | tr -d '\.' | tr -d '(' | tr -d ')' | tail -n 5)

#   dateAndUser=$(echo "$logline" | cut -d' ' -f8,9,10,1,2,3 | tr -d '\.' | tr -d '(')
   echo "$dateAndUser"
# b) Generate failed logins and test

}
access1 > fileaccesslog2.txt

echo "To: hamed.mendscole@mymail.champlain.edu" > emailform2.txt
  echo "Subject: File was accessed" >> emailform2.txt
  echo "" >> emailform2.txt
  cat  fileaccesslog2.txt >> emailform2.txt
  cat emailform2.txt | ssmtp hamed.mendscole@mymail.champlain.edu
