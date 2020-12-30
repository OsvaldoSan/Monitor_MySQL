#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin
export PATH

#Paginas simples extra para el historial de errores y el historial de consultas
#Proceso para activar el historial de consultas
#SET GLOBAL general_log="ON"
#SET GLOBAL general_log_file="/var/run/mariadb/mariadb_query.log"

touch /var/www/html/error20.html
touch /var/www/html/error50.html
touch /var/www/html/error100.html
touch /var/www/html/query20.html
touch /var/www/html/query50.html
touch /var/www/html/query100.html
touch /var/www/html/query300.html

#Página para visualizar últimos 20 errores
echo "<!DOCTYPE html><html lang="es"><head><meta charset="utf-8"> <title>Monitor MySQL Premier Errores</title></head>" > /var/www/html/error20.html
echo "<header><h2> Últimos 20 sucesos</h2></header>" >> /var/www/html/error20.html
	date >> /var/www/html/error20.html
echo "<pre>" >> /var/www/html/error20.html # La etiqueta <pre> de html es para indicar que se mantendrá el formato que tiene el texto
	tail -20 /var/log/mariadb/mariadb.log >> /var/www/html/error20.html
echo "</pre>" >> /var/www/html/error20.html

#Página para visualizar últimos 50 errores
echo "<!DOCTYPE html><html lang="es"><head><meta charset="utf-8"> <title>Monitor MySQL Premier Errores</title></head>" > /var/www/html/error50.html
echo "<header><h2> Últimos 50 sucesos</h2></header>" >> /var/www/html/error50.html
	date >> /var/www/html/error50.html
echo "<pre>" >> /var/www/html/error50.html
	tail -50 /var/log/mariadb/mariadb.log >> /var/www/html/error50.html
echo "</pre>" >> /var/www/html/error50.html

#Página para visualizar últimos 100 errores
echo "<!DOCTYPE html><html lang="es"><head><meta charset="utf-8"> <title>Monitor MySQL Premier Errores</title></head>" > /var/www/html/error100.html
echo "<header><h2> Últimos 100 sucesos</h2></header>" >> /var/www/html/error100.html
	date >> /var/www/html/error100.html
echo "<pre>" >> /var/www/html/error100.html
	tail -100 /var/log/mariadb/mariadb.log >> /var/www/html/error100.html
echo "</pre>" >> /var/www/html/error100.html

#Página para visualizar últimas 20 consultas
# Para activar el historial de /var/run/mariadb/mariadb.log se debe
echo "<!DOCTYPE html><html lang="es"><head><meta charset="utf-8"> <title>Monitor MySQL Premier Consultas</title></head>" > /var/www/html/query20.html
echo "<header><h2> Últimas 20 consultas</h2></header>" >> /var/www/html/query20.html
	date >> /var/www/html/query20.html
echo "<pre>" >> /var/www/html/query20.html
	tail -20 /var/run/mariadb/mariadb_query.log >> /var/www/html/query20.html
echo "</pre>" >> /var/www/html/query20.html

#Últimas 50 consultas
echo "<!DOCTYPE html><html lang="es"><head><meta charset="utf-8"> <title>Monitor MySQL Premier Consultas</title></head>" > /var/www/html/query50.html
echo "<header><h2> Últimas 50 consultas</h2></header>" >> /var/www/html/query50.html
	date >> /var/www/html/query50.html
echo "<pre>" >> /var/www/html/query50.html
	tail -50 /var/run/mariadb/mariadb_query.log >> /var/www/html/query50.html
echo "</pre>" >> /var/www/html/query50.html

#Últimas 100
echo "<!DOCTYPE html><html lang="es"><head><meta charset="utf-8"> <title>Monitor MySQL Premier Consultas</title></head>" > /var/www/html/query100.html
echo "<header><h2> Últimas 100 consultas</h2></header>" >> /var/www/html/query100.html
	date >> /var/www/html/query100.html
echo "<pre>" >> /var/www/html/query100.html
	tail -100 /var/run/mariadb/mariadb_query.log >> /var/www/html/query100.html
echo "</pre>" >> /var/www/html/query100.html

# Últimas 300 sin contemolar procesos automáticos

echo "<!DOCTYPE html><html lang="es"><head><meta charset="utf-8"> <title>Monitor MySQL Premier Consultas</title></head>" > /var/www/html/query300.html
echo "<header><h2> Últimas 300 consultas sin contemplar los procesos automáticos</h2></header>" >> /var/www/html/query300.html
	date >> /var/www/html/query300.html
echo "<pre>" >> /var/www/html/query300.html
	cat /var/run/mariadb/mariadb_query.log | grep -v root@localhost | grep -v GLOBAL | grep -v 'show processlist' | grep -v Quit | tail -100>> /var/www/html/query300.html
echo "</pre>" >> /var/www/html/query300.html
