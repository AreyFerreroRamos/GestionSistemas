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
		for usuari in $(ls -l /home | tail -n +2 | tr -s ' ' | cut -f10 -d' ')
		do
			var=$(last -s -3days | grep $usuari)
			if [[ ! -z $var ]]
			then
				total=$(du /home/$usuari | tail -1 | cut -f1)
				echo "El directori d'entrada de l'usuari '$usuari' ocupa $total Bytes."
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
