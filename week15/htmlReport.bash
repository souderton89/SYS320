#! /bin/bash
bash finalC2.bash exec >/dev/null 2>&1
#sed 's/.*/<tr><td>&<\/tr><\/td>/' report.txt >> /var/www/html/reports.html


cat > /var/www/html/reports.html << EOF
<html>
<body>
<table>
EOF

sed 's/.*/<tr><td>&<\/tr><\/td>/' report.txt >> /var/www/html/reports.html

#sed 's/.*/<tr><td>&<\/tr><\/td>/' report.txt


#cat /home/champuser/sys320/week15/report.txt >> /var/www/html/reports.html # exec >/dev/null 2>&1


cat >> /var/www/html/reports.html << EOF
</table>
</body> 
</html>
EOF
