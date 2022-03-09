#!/bin/bash

# Autor: Arey Ferrero Ramos.
# Data: 8 de març del 2022. Versió: 1
# Descripció: A les 21:30 es reanuda l'execució d'un conjunt de processos recollits en un fitxer, amb una diferencia de temps de 30 segons entre cada un.
#	Paràmetres:
#		-Fitxer amb els PIDs dels processos que s'han anat aturant.
# 	Retorn:
#		-

if [ $# -eq 1 ]
then
	if [ -f $1 ]
	then
		IFS=$'\n'
		for pid in $(cat $1)
		do
			kill -SIGCONT $pid
			sleep 30
		done
	elif [ $1 = "-h" ]
	then
		echo -e "continuarSenseFi.sh: A les 21:30 es reanuda l'execució d'un conjunt de processos recollits en un fitxer, amb una diferencia de temps de 30 segons entre cada un.\n\tParàmetres:\n\t\t-Fitxer amb els PIDs dels processos que s'han anat aturant.\n\tRetorn:\n\t\t-" >&2
		exit 1
	else
		echo -e "Error: El paràmetre '$1' és incorrecte." >&2
		exit 2
	fi
else
	echo -e "Error: El nombre de paràmetres és incorrecte." >&2
	exit 3
fi
