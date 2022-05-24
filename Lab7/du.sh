#!/bin/bash

# Autor: Arey Ferrero Ramos.
# Data: 24 de maig del 2022. Versió: 1.
# Descripció: S'utilitza la comanda 'du' per comprovar quant espai de disc ocupen els directoris d'entrada dels usuaris que estan sota el directori /home i que han entrat en el sistema en els últims tres dies.
#	Paràmetres:
#		-
#	Retorn:
#		-

if [ $(id -u) -eq 0 ]
then
	if [ $# -eq 0 ]
	then
		for linia in $(cat /etc/passwd)
		do
			dir=$(echo $linia | cut -f6 -d':')
			if [[ $(echo $dir | cut -f1,2 -d'/') = "/home" ]]
			then
				usuari=$(echo $linia | cut -f1 -d':')	
				var=$(last -s -3days | grep $usuari)
				if [[ ! -z $var ]]
				then
					total=$(du $dir | tail -1 | cut -f1)
					echo "El directori d'entrada de l'usuari '$usuari' ocupa $total Bytes."
				fi
			fi
		done
		exit 0
	elif [ $1 = "-h" ]
	then
		echo -e "S'utilitza la comanda 'du' per comprovar quant espai de disc ocupen els directoris d'entrada dels usuaris que estan sota el directori /home i que han entrat en el sistema en els últims tres dies.\n\tParàmetres:\n\t\t-\n\tRetorn:\n\t\t-" >&2
		exit 3
	else
		echo -e "Error: Els paràmetres son incorrectes." >&2
		exit 2
	fi
else
	echo -e "Error: No estàs executant com a root." >&2
	exit 1
fi
