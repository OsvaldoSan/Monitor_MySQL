#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin
monitor="~/Administración/MySQL_AdminPremier/Monitor/"
export PATH

# Este va a ultimo, pues ultimo.html es el último registro tomado antes de morir

echo "<font size=5><strong>Variables de estado:</strong></font>" >> /var/www/html/ultimo.html
echo "<table id ="status">" >> /var/www/html/ultimo.html
echo "<tr>" >> /var/www/html/ultimo.html
	echo "<th>Variable</th>" >> /var/www/html/ultimo.html
        echo "<th>Estado</th>" >> /var/www/html/ultimo.html
echo "</tr>" >> /var/www/html/ultimo.html
        for i in {1..12}
        do
        	variable=$(awk "NR==$i" ~/Administración/estado.txt)
                echo "<tr>" >> /var/www/html/ultimo.html
                        echo "<td>" >> /var/www/html/ultimo.html
                                echo $variable >> /var/www/html/ultimo.html
                        echo "</td>">> /var/www/html/ultimo.html
                        echo "<td>" >> /var/www/html/ultimo.html
                                mysqladmin extended-status | grep -w $variable | cut -d "|" -f 3 --output-delimiter=$' ' >> /var/www/html/ultimo.html
                        echo "</td>">> /var/www/html/ultimo.html
                echo "</tr>" >> /var/www/html/ultimo.html
                done
echo "</table>" >> /var/www/html/ultimo.html
