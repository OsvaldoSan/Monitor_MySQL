#!/bin/bash
PATH=/usr/lib64/qt-3.3/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin

export PATH

seccion(){
echo "<strong id="sub1">Estatus de la base de datos:</strong>" >> /var/www/html/$1
echo "<section>" >> /var/www/html/$1

	echo "<article>" >> /var/www/html/$1
	source ~/Administración/$2
	echo "</article>" >> /var/www/html/$1
	echo "<article>" >> /var/www/html/$1
	source ~/Administración/$3
	echo "</article>" >> /var/www/html/$1

echo "</section>" >> /var/www/html/$1
}
iniciohtml(){
echo "<!DOCTYPE html> 
<html lang="es">
<head>
  <meta charset="utf-8">
  <title>Monitor MySQL Premier</title>
  <link rel="stylesheet" href="estilo.css">
</head>" > /var/www/html/$1
}

source ~/Administración/paginas.sh

iniciohtml index.html

echo "<body>" >> /var/www/html/index.html

echo "<header><h1><center> Monitor de MySQL Premier</center></h1></header>" >> /var/www/html/index.html
echo "<center>" >> /var/www/html/index.html

echo "<h2>" >> /var/www/html/index.html
	date +%c >> /var/www/html/index.html
echo "</h2>" >> /var/www/html/index.html

service mysqld status | grep stopped > /dev/null 

if [ $? -eq 0 ]
then
	echo "<h1 id="alerta" class="parpadea"> Alerta</h1> <h1 id="alerta">La base de datos esta caida </h1>" >> /var/www/html/index.html
	echo "<a href="ultimo.html" target=_blank>Último resumen del estado de la base de datos</a>" >> /var/www/html/index.html
else
	echo "<h1 id="bien" > Todo en orden, la base de datos funciona correctamente</h1>" >> /var/www/html/index.html
	iniciohtml ultimo.html
	seccion ultimo.html procesosu.sh variablesEstadou.sh
fi

echo "</center>" >> /var/www/html/index.html
echo >> /var/www/html/index.html
echo >> /var/www/html/index.html
	echo "<br>" >> /var/www/html/index.html
echo >> /var/www/html/index.html

echo "<pre>" >> /var/www/html/index.html
	source ~/Administración/sistema.sh
echo "<pre>" >> /var/www/html/index.html

echo >> /var/www/html/index.html

seccion index.html procesos.sh variablesEstado.sh

source ~/Administración/log_errores.sh

echo "<font size=5><strong>Más información sobre la base de datos : </strong></font>" >> /var/www/html/index.html 
echo "<ul>" >> /var/www/html/index.html 
	echo "<li> <a href="error20.html" target=_blank style="color:black">Últimos 20 sucesos en el historial de errores y cambios en el estado de la base de datos</a></li>" >> /var/www/html/index.html
	echo "<li> <a href="error50.html" target=_blank style="color:black">Últimos 50 sucesos en el historial de errores y cambios en el estado de la base de datos</a> </li>" >> /var/www/html/index.html 
	echo "<li> <a href="error100.html" target=_blank style="color:black">Últimos 100 sucesos en el historial de errores y cambios en el estado de la base de datos</a> </li>" >> /var/www/html/index.html 
	echo "<li> <a href="query20.html" target=_blank style="color:black">Últimas 20 consultas realizadas</a></li>" >> /var/www/html/index.html 
	echo "<li> <a href="query50.html" target=_blank style="color:black">Últimas 50 consultas realizadas</a></li>" >> /var/www/html/index.html 
	echo "<li> <a href="query100.html" target=_blank style="color:black">Últimas 100 consultas realizadas</a></li>" >> /var/www/html/index.html 
	echo "<li> <a href="query300.html" target=_blank style="color:black">Últimas 100 consultas realizadas sin contemplar procesos automáticos</a></li>" >> /var/www/html/index.html 
echo "</ul>" >> /var/www/html/index.html 


echo "</body>" >> /var/www/html/index.html
echo "</html>" >> /var/www/html/index.html
cat: cat: No existe el fichero o el directorio
#!/bin/bash
PATH=/usr/lib64/qt-3.3/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin

export PATH

seccion(){
echo "<strong id="sub1">Estatus de la base de datos:</strong>" >> /var/www/html/$1
echo "<section>" >> /var/www/html/$1

	echo "<article>" >> /var/www/html/$1
	source ~/Administración/$2
	echo "</article>" >> /var/www/html/$1
	echo "<article>" >> /var/www/html/$1
	source ~/Administración/$3
	echo "</article>" >> /var/www/html/$1

echo "</section>" >> /var/www/html/$1
}
iniciohtml(){
echo "<!DOCTYPE html> 
<html lang="es">
<head>
  <meta charset="utf-8">
  <title>Monitor MySQL Premier</title>
  <link rel="stylesheet" href="estilo.css">
</head>" > /var/www/html/$1
}

source ~/Administración/paginas.sh

iniciohtml index.html

echo "<body>" >> /var/www/html/index.html

echo "<header><h1><center> Monitor de MySQL Premier</center></h1></header>" >> /var/www/html/index.html
echo "<center>" >> /var/www/html/index.html

echo "<h2>" >> /var/www/html/index.html
	date +%c >> /var/www/html/index.html
echo "</h2>" >> /var/www/html/index.html

service mysqld status | grep stopped > /dev/null 

if [ $? -eq 0 ]
then
	echo "<h1 id="alerta" class="parpadea"> Alerta</h1> <h1 id="alerta">La base de datos esta caida </h1>" >> /var/www/html/index.html
	echo "<a href="ultimo.html" target=_blank>Último resumen del estado de la base de datos</a>" >> /var/www/html/index.html
else
	echo "<h1 id="bien" > Todo en orden, la base de datos funciona correctamente</h1>" >> /var/www/html/index.html
	iniciohtml ultimo.html
	seccion ultimo.html procesosu.sh variablesEstadou.sh
fi

echo "</center>" >> /var/www/html/index.html
echo >> /var/www/html/index.html
echo >> /var/www/html/index.html
	echo "<br>" >> /var/www/html/index.html
echo >> /var/www/html/index.html

echo "<pre>" >> /var/www/html/index.html
	source ~/Administración/sistema.sh
echo "<pre>" >> /var/www/html/index.html

echo >> /var/www/html/index.html

seccion index.html procesos.sh variablesEstado.sh

source ~/Administración/log_errores.sh

echo "<font size=5><strong>Más información sobre la base de datos : </strong></font>" >> /var/www/html/index.html 
echo "<ul>" >> /var/www/html/index.html 
	echo "<li> <a href="error20.html" target=_blank style="color:black">Últimos 20 sucesos en el historial de errores y cambios en el estado de la base de datos</a></li>" >> /var/www/html/index.html
	echo "<li> <a href="error50.html" target=_blank style="color:black">Últimos 50 sucesos en el historial de errores y cambios en el estado de la base de datos</a> </li>" >> /var/www/html/index.html 
	echo "<li> <a href="error100.html" target=_blank style="color:black">Últimos 100 sucesos en el historial de errores y cambios en el estado de la base de datos</a> </li>" >> /var/www/html/index.html 
	echo "<li> <a href="query20.html" target=_blank style="color:black">Últimas 20 consultas realizadas</a></li>" >> /var/www/html/index.html 
	echo "<li> <a href="query50.html" target=_blank style="color:black">Últimas 50 consultas realizadas</a></li>" >> /var/www/html/index.html 
	echo "<li> <a href="query100.html" target=_blank style="color:black">Últimas 100 consultas realizadas</a></li>" >> /var/www/html/index.html 
	echo "<li> <a href="query300.html" target=_blank style="color:black">Últimas 100 consultas realizadas sin contemplar procesos automáticos</a></li>" >> /var/www/html/index.html 
echo "</ul>" >> /var/www/html/index.html 


echo "</body>" >> /var/www/html/index.html
echo "</html>" >> /var/www/html/index.html
