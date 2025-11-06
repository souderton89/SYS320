#!/bin/bash

file="/var/log/apache2/access.log"

results=$(cat "$file" | cut -d' ' -f1,7 | tr -d "/" | grep page2.html)

echo "$results"

pageCount() {
  cut -d' ' -f7 /var/log/apache2/access.log | sort | uniq -c | sort -n
  }
 
  pageCount
