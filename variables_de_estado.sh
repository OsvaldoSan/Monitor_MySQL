#!/bin/bash
PATH=/usr/lib64/qt-3.3/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
export PATH

echo "<font size=5><strong>Variables de estado:</strong></font>" >> /var/www/html/index.html
        echo "<table id ="status">" >> /var/www/html/index.html
                echo "<tr>" >> /var/www/html/index.html
                        echo "<th>Variable</th>" >> /var/www/html/index.html
                        echo "<th>Estado</th>" >> /var/www/html/index.html
                echo "</tr>" >> /var/www/html/index.html
                for i in {1..12}
                do
                variable=$(awk "NR==$i" ~/Administración/estado.txt)
                echo "<tr>" >> /var/www/html/index.html
                        echo "<td>" >> /var/www/html/index.html
                                echo $variable >> /var/www/html/index.html
                        echo "</td>">> /var/www/html/index.html
                        echo "<td>" >> /var/www/html/index.html
                                mysqladmin extended-status | grep -w $variable | cut -d "|" -f 3 --output-delimiter=$' ' >> /var/www/html/index.html
                        echo "</td>">> /var/www/html/index.html
                echo "</tr>" >> /var/www/html/index.html
                done
        echo "</table>" >> /var/www/html/index.html

