#!/bin/bash

# Autor: Arey Ferrero Ramos.
# Data: 26 d'abril del 2022. Versió: 1.
# Descripció: Es configura un servidor NFS per a allotjar el directori /projectes, de manera que es garanteix la màxima seguretat i només poden accedir als directoris de cada projecte els treballadors que en 
#		formen part.
#	Paràmetres:
#		-
#	Solució:
#		-

if [ $(id -u) -eq 0 ]
then
	if [ $# -eq 0 ]
	then
		

		exit 0
	elif [ $1 = "-h" ]
	then
		echo -e "Descripció: Es configura un servidor NFS per a allotjar el directori /projectes, de manera que es garanteix la màxima seguretat i nomes poden accedir als directoris de cada projecte els usuaris que hi pertanyen.\n\tParàmetres:\n\t\t-\n\tSolució:\n\t\t-" >&2
		exit 3
	else
		echo -e "Error: Els paràmetres son incorrectes." >&2
		exit 2
	fi
else
	echo -e "Error: No estàs executant com a root." >&2
	exit 1
fi
