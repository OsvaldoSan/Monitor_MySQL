#!/bin/bash
PATH=/usr/lib64/qt-3.3/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
export PATH
#La primera variable será el comando en fech y la segunda el numero de cortes en cut, la tercer variable es el respaldo con el que se trabaja
# Creación de archivo profundo
deep(){
mkdir  ~/Respaldos/$3/Archivo_profundo &> ~/Administración/temp/arch
tipo_act=$(date +%$1)
cortes=$2
ls ~/Respaldos/$3 >  ~/Administración/temp/respaldo
filas=$(wc -l ~/Administración/temp/respaldo | cut -d '/' -f 1)

for i in $(seq 2 $filas)
do
	respaldo_tipo=$(awk "NR==$i" ~/Administración/temp/respaldo | cut -d '-' -f $cortes)
	if [ $respaldo_tipo  -ne $tipo_act  ]
	then
		#echo $(awk "NR==$i" ~/Administración/temp/respaldo)
		nombre=$(awk "NR==$i" ~/Administración/temp/respaldo)
		cp ~/Respaldos/$3/$nombre ~/Respaldos/$3/Archivo_profundo/$nombre
		echo  ~/Respaldos/$3/$nombre
		break
	fi
done

}

respaldo(){
	# Si el no se trata del respaldo completo $1 y $comando coincidirán
	comando=$1
	if [ "$1" = "Respaldo_Total" ]
	then
		comando=$"--all-databases"
	fi
	mkdir  ~/Respaldos/$1 &> ~/Administración/temp/arch
	# Ejecutará la instrucción hasta que se complete con exito
	mysqldump -B $comando > ~/Respaldos/$1/backup_$1_`date +%d-%m-%Y-%H:%M`.sql 
	while [ $? -ne 0  ]
	do
	         mysqldump -B $comando > ~/Respaldos/$1/backup_$1_`date +%d-%m-%Y-%H:%M`.sql 
	done
}

# Creación de los respaldo a partir del archivo de configuración
filas=$(wc -l ~/Administración/respaldo/conf_resp.txt | cut -d '/' -f 1)
for i in $(seq $filas)
do
	awk "NR==$i" ~/Administración/respaldo/conf_resp.txt | grep '#' > ~/Administración/temp/resp
	if [ $? -eq 0 ]
	then
		#echo Comentario
		continue
	fi
	base=$(awk "NR==$i" ~/Administración/respaldo/conf_resp.txt)
	#echo $base
	respaldo $base
	deep m 2 $base
done 
# Respalda meses anteriores
#deep m 2 $base
# Respalda años anteriores
#deep Y 3 $base
