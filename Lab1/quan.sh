#!/bin/bash

# Autor: Arey Ferrero Ramos.
# Data: 21 de febrer del 2022. Versió: 1.
# Descripció: Donat un conjunt de paquets (separats per blanc), s'indica quins no están instal·lats i per aquells que estan instal·lats s'indica la data en que es van instal·lar.
#	Paràmetres:
#		- Llista de paquets (Separats per blanc).
#	Retorn:
#		-

if [ $# -eq 0 ]
then
	echo -e "Error: Es requereix al menys un paquet com a paràmetre." >&2
	exit 1
elif [ $1 = '-h' ]
then
	echo -e "quan.sh : Donat un conjunt de paquets, s'indica quins no estan instal·lats i per aquells que estan instal·lats s'indica la data en que es van instal·lar.\n\tParàmetres:\n\t\t- Llista de paquets (Separats per blanc).\n\tRetorn:\n\t\t-" >&2
	exit 2
else
	IFS=$' '
	for paquet in $*
	do
		linia=$(cat /var/log/dpkg.log* | grep "status installed $paquet:")
		if [[ -z $linia ]]
	       	then
			echo -e "El paquet '$paquet' no està instal·lat."
		else
			data=$(echo $linia | cut -f1,2 -d' ')
			echo -e "$paquet \t$data"
		fi	
	done
	exit 0	
fi
