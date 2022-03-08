#!/bin/bash

# Autor: Arey Ferrero Ramos.
# Data: 7 de març del 2022. Versió: 1
# Descripció: S'aturen una vegada els processos anomenats senseFi (Processos que s'han creat cada cert temps i en hores diferents i que consumeixen CPU i no acaben mai).
#	Paràmetres:
#		-
# 	Retorn:
#		-Fitxer amb els PIDs dels processos que es vagin aturant.

for pid in $(ps aux | grep "senseFi" | tr -s ' ' | cut -f2 -d' ' | head -n -1)
do
	kill -SIGSTOP $pid
	echo $pid >> pidsProcessos.txt
done
