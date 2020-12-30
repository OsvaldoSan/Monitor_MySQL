#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin
monitor="~/Administración/MySQL_AdminPremier/Monitor/"
export PATH

# Muestra algunas variables de estado de mariadb en una tabla estatica de html
# Las variables a mostrar se definen en el archivo

echo "<font size=5><strong>Variables de estado:</strong></font>" >> /var/www/html/index.html
echo "<table id ="status">" >> /var/www/html/index.html
	echo "<tr>" >> /var/www/html/index.html
        	echo "<th>Variable</th>" >> /var/www/html/index.html
                echo "<th>Estado</th>" >> /var/www/html/index.html
        echo "</tr>" >> /var/www/html/index.html
        for i in {1..12}
        do
        	variable=$(awk "NR==$i" $monitor/estado.txt)
                echo "<tr>" >> /var/www/html/index.html
                        echo "<td>" >> /var/www/html/index.html
                                echo $variable >> /var/www/html/index.html
                        echo "</td>">> /var/www/html/index.html
                        echo "<td>" >> /var/www/html/index.html
                        	#Aqui se saca unicamente el valor que tiene la variable en ese momento
                        	#el -w en grep para que se busque la salida exacta
                                mysqladmin extended-status | grep -w $variable | cut -d "|" -f 3 --output-delimiter=$' ' >> /var/www/html/index.html
                        echo "</td>">> /var/www/html/index.html
                echo "</tr>" >> /var/www/html/index.html
                done
        echo "</table>" >> /var/www/html/index.html
