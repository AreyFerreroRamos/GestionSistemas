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
	liniaFinal=$(cat /var/log/dpkg.log* | wc -l)
	liniaInicial=$(cat /var/log/dpkg.log* | grep -n "$data $hora" | head -1 | cut -f1 -d':')
	let numLinies=liniaFinal-liniaInicial
	cat /var/log/dpkg.log* | tail -$numLinies
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
