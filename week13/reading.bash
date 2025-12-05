#! /bin/bash
clear

   # filling courses.txt
   bash re.bash

   courseFile="reading.txt"
    echo ""
    cat "$courseFile" | grep -v "Temprature " | grep "Date-Time" | grep "Pressure" | cut -d';' -f1 | tr -d "&#13;" | \
    sed 's/;/ | /g'
    echo ""

