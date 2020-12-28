#!/bin/bash
PATH=/usr/lib64/qt-3.3/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
export PATH
free -mo > ~/Administración/temp/archi
#vmstat -S m | tr '-' ' ' > ~/Administración/temp/archi
filas=$(cat ~/Administración/temp/archi | wc -l)
echo "<strong id="sub1">Estádisticas generales del sistema:</strong>" >> /var/www/html/index.html

echo "<table ig="log">" >> /var/www/html/index.html
for i in $(seq 1 $filas)
do
	echo "<tr id="trlog">" >> /var/www/html/index.html
	awk "NR==$i" ~/Administración/temp/archi >> /var/www/html/index.html
	echo "</tr>" >> /var/www/html/index.html
done

echo "</table>" >> /var/www/html/index.html

