#!/bin/bash
#Este script se usa en el principal monitor.sh
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin
export PATH
monitor="~/Administración/MySQL_AdminPremier/Monitor/"

# Muestra la lista de procesos de mariadb en forma de tabla estatica de html
# El usuario, de donde viene y el comando que utilizo, entre otros datos
	mysqladmin processlist > $monitor/temp/archi
	filas=$(wc -l $monitor/temp/archi | cut -d '/' -f 1)
echo >> /var/www/html/index.html
echo "<font size=5><strong>Lista de procesos:</strong></font>" >> /var/www/html/index.html

echo "<table id="status">" >> /var/www/html/index.html
for i in $(seq 2 2 $filas) # Secuencia que empieza en 2, da saltos de a 2, hasta llegar a $filas. Inclusiva en ambos lados
do
#Solo se quieren las filas pares para evitar las filas que tienen los caracteres de separación "-----"
	echo "<tr>" >> /var/www/html/index.html
	for j in {2..9} # Sequencia del 2 al 9, inclusiva en ambos extremos
	do
		if [ $i -eq 2 ] #La primera fila esta remarcada
		then
			echo "<th>" >> /var/www/html/index.html
				awk "NR==$i" $monitor/temp/archi| cut -d '|' -f $j >> /var/www/html/index.html
			echo "</th>" >> /var/www/html/index.html
		else
			echo "<td>" >> /var/www/html/index.html
				awk "NR==$i" $monitor/temp/archi| cut -d '|' -f $j >> /var/www/html/index.html
			echo "</td>" >> /var/www/html/index.html
		fi
	done
	echo "</tr>" >> /var/www/html/index.html
done
echo "</table>" >> /var/www/html/index.html
