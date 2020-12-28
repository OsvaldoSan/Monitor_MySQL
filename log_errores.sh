#!/bin/bash
PATH=/usr/lib64/qt-3.3/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
export PATH

tail -15 /var/log/mysqld.log > ~/Administración/temp/archi
filas=$(cat ~/Administración/temp/archi | wc -l)
echo "<font size=5><strong>Historial reciente de cambios y errores en la base de datos:</strong></font>" >> /var/www/html/index.html

echo "<table ig="log">" >> /var/www/html/index.html
for i in $(seq 1 $filas)
do
	echo "<tr id="trlog">" >> /var/www/html/index.html
	awk "NR==$i" ~/Administración/temp/archi >> /var/www/html/index.html
	echo "</tr>" >> /var/www/html/index.html
done

echo "</table>" >> /var/www/html/index.html
