#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin
monitor="~/Administración/MySQL_AdminPremier/Monitor"
export PATH

declare -i numero=0
if [ $numero -eq 0 ]
then
	echo "Exito"
fi
echo $numero
numero=$(( $numero+1 ))
echo $numero
