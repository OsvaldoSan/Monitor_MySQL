#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin
restauracion="/root/Administración/MySQL_AdminPremier/Restaurar_Transacciones"
ruta="/var/lib/mysql"
export PATH

detectar(){
	touch $restauracion/temp/archi.temp
	echo -n "What's your problem?: "
	read tipo_problema # drop or delete

	cat /var/run/mariadb/mariadb_query.log | grep -v root@localhost | grep -v GLOBAL | grep -v 'show processlist' | grep -v Quit | grep $tipo_problema > $restauracion/temp/archi.temp
	filas=$(wc -l $restauracion/temp/archi.temp | cut -d " " -f 1)
	if [ $filas -eq 0 ]
	then
		echo "No se ha encontrado nada, puede estar tranquilo"
		exit 0 # Todo está bien
	fi
	echo "¿Desea hacer una busqueda exhaustiva del problema en los binlogs?[si/no] "
	read respuesta
	if [ $respuesta == "si" ]
	then
		echo "Estas son las fechas" #Mostrar el archivo para que el usuario elija la fecha donde buscar
		#El usuario tendrá que elegir el at a restarurar
	fi

	echo "Dijó no"
}

detectar
