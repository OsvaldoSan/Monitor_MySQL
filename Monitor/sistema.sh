#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin
export PATH
# Datos generales del sistema presentados en tabla estatica de html

monitor="~/Administración/MySQL_AdminPremier/Monitor/"

free -m > $monitor/temp/archi #Era mo antes
#vmstat -S m | tr '-' ' ' > ~/Administración/temp/archi
filas=$(cat $monitor/temp/archi | wc -l)
echo "<strong id="sub1">Estádisticas generales del sistema:</strong>" >> /var/www/html/index.html

echo "<table ig="log">" >> /var/www/html/index.html
for i in $(seq 1 $filas)
do
	echo "<tr id="trlog">" >> /var/www/html/index.html
		awk "NR==$i" $monitor/temp/archi >> /var/www/html/index.html
	echo "</tr>" >> /var/www/html/index.html
done
echo "</table>" >> /var/www/html/index.html

