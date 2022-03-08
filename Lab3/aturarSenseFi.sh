#!/bin/bash

# Autor: Arey Ferrero Ramos.
# Data: 7 de març del 2022. Versió: 1
# Descripció: S'aturen una vegada els processos anomenats senseFi (Processos que s'han creat cada cert temps i en hores diferents i que consumeixen CPU i no acaben mai).
#	Paràmetres:
#		-
# 	Retorn:
#		-Fitxer amb els PIDs dels processos que es vagin aturant.

IFS=$'\n'
for proces in $(ps aux | grep senseFi)
do
	if [ $(echo $proces | tr -s ' ' | cut -f8 -d' ') = "R+" ]
	then
		pid=$(echo $proces | tr -s ' ' | cut -f2 -d' ')
		kill -SIGSTOP $pid
		echo $pid >> pidsProcessos.txt
	fi
done
