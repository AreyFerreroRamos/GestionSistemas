#!/bin/bash

# Autor: Arey Ferrero Ramos.
# Data: 8 de març del 2022. Versió: 1
# Descripció: S'aturen una vegada els processos anomenats senseFi (Processos que s'han creat cada cert temps i en hores diferents i que consumeixen CPU i no acaben mai).
#	Paràmetres:
#		-
# 	Retorn:
#		-Fitxer amb els PIDs dels processos que es vagin aturant.

if [ $# -eq 0 ]
then
	IFS=$'\n'
	for proces in $(ps aux | grep senseFi | head -n -1)
	do
		if [ $(echo $proces | tr -s ' ' | cut -f8 -d' ') = "R+" ]
		then
			pid=$(echo $proces | tr -s ' ' | cut -f2 -d' ')
			kill -SIGSTOP $pid
			echo $pid >> pidsProcessos.txt
		fi
	done
elif [ $1 = "-h" ]
then
	echo -e "aturarSenseFi.sh: S'aturen una vegada els processos anomenats senseFi (Processos que s'han creat cada cert temps i en hores diferents i que consumeixen CPU i no acaben mai).\n\tParàmetres:\n\t\t-\n\tRetorn:\n\t\t-Fitxer amb els PIDs dels processos que es vagin aturant." >&2
	exit 1
else
	echo -e "Error: Els paràmetres son incorrectes." >&2
	exit 2
fi
