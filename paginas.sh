#!/bin/bash

PATH=/usr/lib64/qt-3.3/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin

export PATH

touch /var/www/html/error20.html
touch /var/www/html/error50.html
touch /var/www/html/error100.html
touch /var/www/html/query20.html
touch /var/www/html/query50.html
touch /var/www/html/query100.html


echo "<!DOCTYPE html><html lang="es"><head><meta charset="utf-8"> <title>Monitor MySQL Premier Errores</title></head>" > /var/www/html/error20.html
echo "<header><h2> Últimos 20 sucesos</h2></header>" >> /var/www/html/error20.html
date >> /var/www/html/error20.html
echo "<pre>" >> /var/www/html/error20.html
tail -20 /var/log/mysqld.log >> /var/www/html/error20.html
echo "</pre>" >> /var/www/html/error20.html

echo "<!DOCTYPE html><html lang="es"><head><meta charset="utf-8"> <title>Monitor MySQL Premier Errores</title></head>" > /var/www/html/error50.html
echo "<header><h2> Últimos 50 sucesos</h2></header>" >> /var/www/html/error50.html
date >> /var/www/html/error50.html
echo "<pre>" >> /var/www/html/error50.html
tail -50 /var/log/mysqld.log >> /var/www/html/error50.html
echo "</pre>" >> /var/www/html/error50.html

echo "<!DOCTYPE html><html lang="es"><head><meta charset="utf-8"> <title>Monitor MySQL Premier Errores</title></head>" > /var/www/html/error100.html
echo "<header><h2> Últimos 100 sucesos</h2></header>" >> /var/www/html/error100.html
date >> /var/www/html/error100.html
echo "<pre>" >> /var/www/html/error100.html
tail -100 /var/log/mysqld.log >> /var/www/html/error100.html
echo "</pre>" >> /var/www/html/error100.html

echo "<!DOCTYPE html><html lang="es"><head><meta charset="utf-8"> <title>Monitor MySQL Premier Consultas</title></head>" > /var/www/html/query20.html
echo "<header><h2> Últimas 20 consultas</h2></header>" >> /var/www/html/query20.html
date >> /var/www/html/query20.html
echo "<pre>" >> /var/www/html/query20.html
tail -20 /var/run/mysqld/mysqld.log >> /var/www/html/query20.html
echo "</pre>" >> /var/www/html/query20.html

echo "<!DOCTYPE html><html lang="es"><head><meta charset="utf-8"> <title>Monitor MySQL Premier Consultas</title></head>" > /var/www/html/query50.html
echo "<header><h2> Últimas 50 consultas</h2></header>" >> /var/www/html/query50.html
date >> /var/www/html/query50.html
echo "<pre>" >> /var/www/html/query50.html
tail -50 /var/run/mysqld/mysqld.log >> /var/www/html/query50.html
echo "</pre>" >> /var/www/html/query50.html

echo "<!DOCTYPE html><html lang="es"><head><meta charset="utf-8"> <title>Monitor MySQL Premier Consultas</title></head>" > /var/www/html/query100.html
echo "<header><h2> Últimas 100 consultas</h2></header>" >> /var/www/html/query100.html
date >> /var/www/html/query100.html
echo "<pre>" >> /var/www/html/query100.html
tail -100 /var/run/mysqld/mysqld.log >> /var/www/html/query100.html
echo "</pre>" >> /var/www/html/query100.html

echo "<!DOCTYPE html><html lang="es"><head><meta charset="utf-8"> <title>Monitor MySQL Premier Consultas</title></head>" > /var/www/html/query300.html
echo "<header><h2> Últimas 100 consultas sin contemplar los procesos automáticos</h2></header>" >> /var/www/html/query300.html
date >> /var/www/html/query300.html
echo "<pre>" >> /var/www/html/query300.html
cat /var/run/mysqld/mysqld.log | grep -v root@localhost | grep -v GLOBAL | grep -v 'show processlist' | grep -v Quit | tail -100>> /var/www/html/query300.html
echo "</pre>" >> /var/www/html/query300.html
