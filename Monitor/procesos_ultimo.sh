#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin
export PATH
#Es el mismo codigo pero este se mandara a la pagina ultimo.html
monitor="~/Administración/MySQL_AdminPremier/Monitor/"

	mysqladmin processlist > $monitor/temp/archi
	filas=$(wc -l $monitor/temp/archi | cut -d '/' -f 1)
echo >> /var/www/html/ultimo.html
echo "<font size=5><strong>Lista de procesos:</strong></font>" >> /var/www/html/ultimo.html
echo "<table id="status">" >> /var/www/html/ultimo.html
for i in $(seq 2 2 $filas) 
do
	echo "<tr>" >> /var/www/html/ultimo.html
	for j in {2..9}
	do
		if [ $i -eq 2 ]
		then
			echo "<th>" >> /var/www/html/ultimo.html
				awk "NR==$i" $monitor/temp/archi| cut -d '|' -f $j >> /var/www/html/ultimo.html
			echo "</th>" >> /var/www/html/ultimo.html
		else
			echo "<td>" >> /var/www/html/ultimo.html
				awk "NR==$i" $monitor/temp/archi| cut -d '|' -f $j >> /var/www/html/ultimo.html
			echo "</td>" >> /var/www/html/ultimo.html
		fi
	done
	echo "</tr>" >> /var/www/html/ultimo.html
done

echo "</table>" >> /var/www/html/ultimo.html
