#!/bin/bash

PATH=/usr/lib64/qt-3.3/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
export PATH

mysqladmin processlist > ~/Administración/temp/archi
filas=$(wc -l ~/Administración/temp/archi | cut -d '/' -f 1)
echo >> /var/www/html/index.html
echo "<font size=5><strong>Lista de procesos:</strong></font>" >> /var/www/html/index.html
echo "<table id="status">" >> /var/www/html/index.html
for i in $(seq 2 2 $filas) 
do
	echo "<tr>" >> /var/www/html/index.html
	
	for j in {2..9}
	do
		if [ $i -eq 2 ]
		then
			echo "<th>" >> /var/www/html/index.html
			awk "NR==$i" ~/Administración/temp/archi| cut -d '|' -f $j >> /var/www/html/index.html
			echo "</th>" >> /var/www/html/index.html
		else
			echo "<td>" >> /var/www/html/index.html
			awk "NR==$i" ~/Administración/temp/archi| cut -d '|' -f $j >> /var/www/html/index.html
			echo "</td>" >> /var/www/html/index.html
		fi
	done

	echo "</tr>" >> /var/www/html/index.html
done

echo "</table>" >> /var/www/html/index.html