#!/bin/bash

# Autor: Arey Ferrero Ramos.
# Data: 7 de març del 2022. Versió: 1
# Descripció: A les 21:30 es reanuda l'execució d'un conjunt de processos recollits en un fitxer, amb una diferencia de temps de 30 segons entre cada un.
#	Paràmetres:
#		-Fitxer amb els PIDs dels processos que s'han anat aturant.
# 	Retorn:
#		-

IFS=$'\n'
for pid in $(cat $1)
do
	kill -SIGCONT $pid
	sleep 10
done

