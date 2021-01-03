#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin
respaldo="/root/Administración/MySQL_AdminPremier/Respaldo"
almacen="/root/Respaldos" # Dirección donde se guardarán los dump files
export PATH

# Creación de archivo profundo
#La primera variable será el comando en fecha y la segunda el numero de cortes en cut, la tercer variable es la base de datos
# con la que se trabaja
# El archivo profundo son respaldos de mucho mayor tiempo a los que usualmente se tienen, si es que no se mantienen todos los respaldos por falta
# de espacio
# Irá borrando los del periodo anterior, a excepción de 1 que se quedará
deep(){
	mkdir  $almacen/$3/Archivo_profundo &> $respaldo/temp/arch.temp
	touch $respaldo/temp/respaldo.temp
	tipo_act=$(date +%$1) # Mes
	cortes=$2
	# Todos los respaldo de esa base de datos que hay, listados por fecha de modificación inversa
	# Con grep evitamos el directorio Archivo profundo
	ls -tr $almacen/$3 | grep -v Archivo_profundo >  $respaldo/temp/respaldo.temp
	filas=$(wc -l $respaldo/temp/respaldo.temp | cut -d '/' -f 1)
	declare -i bandera=0
	for i in $(seq $filas ) # Secuencia hasta $filas, por que evitamos el directorio Archivo_profundo
	do
		respaldo_tipo=$(awk "NR==$i" $respaldo/temp/respaldo.temp | cut -d '-' -f $cortes) # Se queda con la parte del nombre
		# que indica el mes en el que estan, el año o el dia, todo depende del valor de $cortes
		# ls te da los archivos en un cierto orden, por eso se toma el primero
		if [ $respaldo_tipo  -ne $tipo_act  ] # Si no es el mismo mes, año o dia. Depende $cortes
		then
			nombre=$(awk "NR==$i" $respaldo/temp/respaldo.temp)
			if [ $bandera -eq 0 ] # Solo guardara el más antiguo
			then
				mv $almacen/$3/$nombre $almacen/$3/Archivo_profundo/$nombre
				bandera=$(($bandera+1))
				echo  $almacen/$3/$nombre
				continue
			fi
			echo  $almacen/$3/$nombre
			rm -f $almacen/$3/$nombre
		fi
	done
}


respaldo(){
	# Si el no se trata del respaldo completo $1 y $comando coincidirá
	comando=$1
	if [ "$1" = "Respaldo_Total" ]
	then
		comando=$"--all-databases"
	fi

	mkdir  $almacen/$1 &> $respaldo/temp/arch.temp
	# Ejecutará la instrucción hasta que se complete con exito
	mysqldump -B $comando > $almacen/$1/backup_$1_`date +%d-%m-%Y-%H:%M`.sql

	while [ $? -ne 0  ]
	do
		echo "Algo salio mal"
	         mysqldump -B $comando > $almacen/$1/backup_$1_`date +%d-%m-%Y-%H:%M`.sql 
	done

}

# Creación de los respaldo a partir del archivo de configuración
crear_respaldo(){
	mkdir $almacen &> $respaldo/temp/arch.temp
	touch $respaldo/temp/resp.temp
	filas=$(wc -l $respaldo/conf_bases.txt | cut -d '/' -f 1)
	for i in $(seq $filas)
	do
		awk "NR==$i" $respaldo/conf_bases.txt | grep '#' > $respaldo/temp/resp.temp
		if [ $? -eq 0 ] # Si encuentra un # significa que se debe ignrar esa linea
		then
			continue
		fi
		base=$(awk "NR==$i" $respaldo/conf_bases.txt)
		#echo $base
		respaldo $base
		deep Y 3 $base # Respaldo profundo por años
		#deep m 2 $base # Respaldo profundo por meses
	done
}


# Ejecución
crear_respaldo

