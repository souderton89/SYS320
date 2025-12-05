#! /bin/bash
#! /bin/bash

# This is the link we will scrape
link="10.0.17.6/IOC.html"

# get it with curl and tell curl not to give errors
fullPage=$(curl -sL "$link")

# Utilizing xmlstarlet tool to extract table from the page
toolOutput=$(echo "$fullPage" | \
xmlstarlet format --html --recover 2>/dev/null | \
xmlstarlet select --template --value-of \
"//html//body//table//tr")

echo "$toolOutput" | sed 's/<\/tr>/\n/g' | \
                     sed -e 's/&amp;//g' | \
                     sed -e 's/<tr>//g' | \
                     sed -e 's/<td[^>]*>//g' | \
                     sed -e 's/<\/td>/;/g' | \
                     sed -e 's/<[/\]\{0,1\}a[^>]*>//g' | \
                     sed -e 's/<[/\]\{0,1\}nobr>//g' \
		     > IOC.txt


function test(){
file="/home/champuser/sys320/week15/IOC.txt"
results=$(cat "$file" | sed 's/^[[:space:]]\+//; s/[[:space:]]\+$//' | cut -d'&' -f1 | grep "etc/passwd" > IOC3.txt)
results1=$(cat "$file" | sed 's/^[[:space:]]\+//; s/[[:space:]]\+$//' | cut -d'&' -f1 | grep "bin/sh" >> IOC3.txt)
results2=$(cat "$file" | sed 's/^[[:space:]]\+//; s/[[:space:]]\+$//' | cut -d'&' -f1 | grep "1=1#" >> IOC3.txt)
results2=$(cat "$file" | sed 's/^[[:space:]]\+//; s/[[:space:]]\+$//' | cut -d'&' -f1 | grep "/bin/bash" >> IOC3.txt)
results2=$(cat "$file" | sed 's/^[[:space:]]\+//; s/[[:space:]]\+$//' | cut -d'&' -f1 | grep "1=1--" >> IOC3.txt )
results2=$(cat "$file" | sed 's/^[[:space:]]\+//; s/[[:space:]]\+$//' | cut -d'&' -f1 | grep "cmd=" >> IOC3.txt )
#echo "$results" > IOC3.txt
}
test # > IOC.txt
