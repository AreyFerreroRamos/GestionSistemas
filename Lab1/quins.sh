#!/bin/bash

# Autor: Arey Ferrero Ramos.
# Data: 21 de febrer del 2022. Versió: 1.
# Descripció: Donada una data i una hora, s'indica quins paquets han sigut instal·lats posteriorment.
# 	Paràmetres:
#		- Data
#		- Hora
#	Retorn:
#		-

if [ $# -eq 2 ]
then
	dataHora=$(echo $1 | tr -d '-')$(echo $2 | tr -d ':')
	trobat=0
	IFS=$'\n'
	for linia in $(zcat /var/log/dpkg.log* | grep "status installed" | sort)
	do
		if [ $trobat -eq 0 ]
		then
			if [ $(echo $linia | cut -f1,2 -d' ' | tr -d '-' | tr -d ':' | tr -d ' ') -gt $dataHora ]
			then
				echo $linia | cut -f1,2,5 -d' ' | cut -f1,2,3 -d':'
				trobat=1
			fi
		else
			echo $linia | cut -f1,2,5 -d' ' | cut -f1,2,3 -d':'
		fi
	done
	exit 0
elif [ $# -eq 1 ]
then
	if [ $1 = '-h' ]
	then
		echo -e "Descripció: Donada una data i una hora, s'indica quins paquets han sigut instal·lats posteriorment.\n\tParàmetres:\n\t\t- Data\n\t\t- Hora\n\tRetorn:\n\t\t-" >&2
		exit 1
	else
		echo -e "Error: El número de paràmetres és incorrecte." >&2
		exit 2
	fi
else
	echo -e "Error: El número de paràmetres és incorrecte." >&2
	exit 2
fi
