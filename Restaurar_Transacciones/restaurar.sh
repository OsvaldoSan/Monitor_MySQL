#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin
restauracion="/root/Administración/MySQL_AdminPremier/Restaurar_Transacciones"
ruta="/var/lib/mysql"
export PATH
lugar="mariadb_bin.000001"
# El script recibirá las opciones -d "delete" -D "Drop" -t"Truncate"

# Recibirá sol ucion solucion2 y fechas de inicio y fin
buscar(){
# Las soluciones son un create o un insert y es lo que se va a buscar en las fechas propuestas por el usuario
	# Se vacian y se crean los archivos necesarios
	touch $restauracion/temp/busca.temp
	echo > $restauracion/temp/busca.temp
	# Se buscará en todos los logbin
	for i in `cat $ruta/mariadb_bin.index  | cut -d '/' -f 2`
	do
		#grep -B 4 indica que mostrará las cuatro filas superiores a donde se encontro con la solución
		mysqlbinlog  --start-datetime="$3" --stop-datetime="$4" $ruta/$i | grep -B 6 -A 4 "$1" > $restauracion/temp/busca.temp
		#Verifica que la solucion 2 exista antes de buscar
		if [ "$2" != " " ]
		then
			mysqlbinlog  --start-datetime="$3" --stop-datetime="$4" $ruta/$i | grep -B 4 "$2" >> $restauracion/temp/busca.temp
		fi
		filas=$(wc -l $restauracion/temp/busca.temp | cut -d " " -f 1)
		#No se imprimirá nada cuando el archivo este vacio
		if [ $filas -ne 1 ]
		then
			echo
			echo $i
			echo
			cat $restauracion/temp/busca.temp
		fi
	done
}

# Recibe como parametro si sera por fecha o por posición y  el incio y fin
restaurar(){
	touch solo.temp
	echo > solo.temp
	case $1 in
		fecha) inicio="--start-datetime="
			fin="--stop-datetime=";;
		at)  inicio="-j "
			fin="--stop-position="
			;;
		*)	inicio=" "
			fin=" "
			;;
	esac
		mysqlbinlog  $inicio"$2" $fin"$3" $ruta/$i > $restauracion/temp/solo.temp
		mysql < $restauracion/temp/solo.temp
}


# Recibe el primer parametro del script
detectar(){
	touch $restauracion/temp/archi.temp
	echo -n "Se ha borrado algo con un "
	case $1 in
		-d) tipo_problema="delete"
		    solucion="insert into"
		    solucion2=" "
		;;
		-D) tipo_problema="drop"
		    solucion="create table"
		    solucion2="create database"
		;;
		*) tipo_problema=" "
		   solucion=" "
		   solucion2=" "
		;;
	esac
	echo $tipo_problema
	cat /var/run/mariadb/mariadb_query.log | grep -v root@localhost | grep -v GLOBAL | grep -v 'show processlist' | grep -v Quit | grep $tipo_problema > $restauracion/temp/archi.temp
	filas=$(wc -l $restauracion/temp/archi.temp | cut -d " " -f 1)
	if [ $filas -eq 0 ]
	then
		echo "No se ha encontrado nada en la actual sesión"
	fi

	echo "¿Desea hacer una busqueda exhaustiva del problema en los binlogs?[si/no] "
	read respuesta
	if [ $respuesta == "si" ]
	then
		echo "Aquí esta la información completa de las situaciones encontradas" #Mostrar el archivo para que el usuario elija la fecha donde buscar
		cat $restauracion/temp/archi.temp
		echo
		echo "¿En que fechas de inicio y cierre desea buscar solucines?"
		echo -n "Escriba la fecha en formato [yyyy-mm-dd hh:mm:ss] : "
		read fechai
		echo -n "Escriba la fecha en formato [yyyy-mm-dd hh:mm:ss] : "
		read fechaf
		echo
		echo "Aquí estan las partes de los binlogs que contienen lo que busca:"
		echo
		buscar "$solucion" "$solucion2" "$fechai" "$fechaf"
		echo "¿Desea hacer una busqueda solo por fecha?[si/no]"
		read respuesta
		if [ $respuesta == "si" ]
		then
			echo -n "Escriba la fecha en formato [yyyy-mm-dd hh:mm:ss] : "
			read fechai
			echo -n "Escriba la fecha en formato [yyyy-mm-dd hh:mm:ss] : "
			read fechaf
			echo -n "Alguna palabra clave para buscar dentro : "
			read t
			buscar "$t" " " "$fechai" "$fechaf"
			echo
		fi
		echo "¿Desea restaurar algo por fecha o por puntos de inicio y fin?[fecha/at/no]"
		read respuesta

		case $respuesta in
			fecha)
				echo -n "Ingrese la fecha inicial [yyyy-mm-dd hh:mm:ss] : "
				read fechai
				echo -n "Ingrese la fecha fechaf [yyyy-mm-dd hh:mm:ss] : "
				read fechaf
				echo -n "¿Que archivo binlog usar?"
				read i
				restaurar "$respuesta" "$fechai" "$fechaf" "$i"
				;;
			at)
				echo -n "Ingrese la posición inicial(la que muestra el archivo at:---) : "
				read posi
				echo -n "Ingrese la posición final(la que muestra el archivo 'end_log_pos') : "
				read posf
				echo -n "¿Que archivo binlog usar?"
				read i
				restaurar "$respuesta" "$posi" "$posf" "$i"
			;;
			no)echo "No hay nada más que hacer por el momento"
				exit 1;;
		esac

	fi

}

# Se pasa a la función la primer variable del script
detectar $1
#buscar delete " " "2021-01-03 20:00:00" "2021-01-03 21:55:00"
