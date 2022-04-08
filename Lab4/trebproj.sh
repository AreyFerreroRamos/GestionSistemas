#!/bin/bash

# Autor: Arey Ferrero Ramos.
# Data: 20 d'abril del 2022. Versió: 1.
# Descripció: Donat el nom d'un projecte, es mou el treballador que ha executat l'script sota del directori del projecte, es canvia el seu grup actiu al projecte, i mostra el temps que el treballador ha passat 
#		en el projecte quan aquest en surt (exit). Els fitxers generats per aquest script només els podran modificar els usuaris associats a aquest projecte. 
#	Paràmetres:
#		-Nom del projecte.
#	Sortida:
#		-

if [ $# -eq 1 ]
then
	if [ $1 = "-h" ]
	then
		echo -e "Descripció: Donat el nom d'un projecte, es mou el treballador que ha executat l'script sota del directori del projecte, es canvia el seu grup actiu al projecte, i mostra el temps que el treballador ha passat en el projecte quan aquest en surt (exit). Els fitxers generats per aquest script només els podran modificar els usuaris associats a aquest projecte.\n\tParàmetres:\n\t\t-Nom del projecte.\n\tSortida:\n\t\t-" >&2
		exit 2
	else

		exit 0
	fi
else
	echo -e "Error: El nombre de paràmetres és incorrecte." >&2
	exit 1
fi
