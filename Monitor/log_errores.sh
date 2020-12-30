#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin
export PATH
# Este script se usa en el principal monitor.sh
monitor="~/Administración/MySQL_AdminPremier/Monitor/"
#tail -15 /var/log/mysqld.log > ~/Administración/temp/archi
#Versión CentOS 7, en mariadb.log estan los eventos del servidor de base de datos que se puden considerar errores, tales como
#el encendido o apagado
tail -15 /var/log/mariadb/mariadb.log > $monitor/temp/archi # Se manda a archi para usarse en el codigo después
filas=$(cat $monitor/temp/archi | wc -l)

echo "<font size=5><strong>Historial reciente de cambios y errores en la base de datos:</strong></font>" >> /var/www/html/index.html

# Se crea una tabla estatíca con las sentencias de html
echo "<table ig="log">" >> /var/www/html/index.html
for i in $(seq 1 $filas)
do
	echo "<tr id="trlog">" >> /var/www/html/index.html
		awk "NR==$i" $monitor/temp/archi >> /var/www/html/index.html # Va leyendo linea a linea
	echo "</tr>" >> /var/www/html/index.html
done

echo "</table>" >> /var/www/html/index.html
