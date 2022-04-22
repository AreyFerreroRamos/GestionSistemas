#!/bin/bash

# Autor: Arey Ferrero Ramos.
# Data: 19 d'abril del 2022. Versió: 1.
# Descripció: Donat un fitxer que conté les dades personals d'un conjunt de treballadors, el departament al que pertanyen i els projectes en els que hi treballen; es dona d'alta aquests treballadors com a 
# usuaris del sistema i els projectes en que treballen com a grups del sistema.
#	Paràmetres:
#		-Fitxer que conté les dades personals d'un conjunt de treballadors (DNI, nom i cognoms i telèfon), el departament en que treballen i els projectes en que treballen.
#	Sortida:
#		-

if [ $(id -u) -eq 0 ]
then
	if [ $# -eq 1 ]
	then
		if [ -f $1 ]
		then
			while read linia
			do
				IFS=$':'
				read dni nom telefon departament projectes <<< $linia
				IFS=$','
				for projecte in $projectes
				do
					mkdir -p /projectes/$projecte
					groupadd -f $projecte
					chgrp $projecte /projectes/$projecte
					chmod g+w /projectes/$projecte
				done
				mkdir -p /usuaris/$departament
				groupadd -f $departament
				chgrp $departament /usuaris/$departament
				chmod g+w /usuaris/$departament
				grups=$departament" "$projectes
				IFS=$' '
				useradd -m -d /usuaris/$departament/$dni -G $grups -p $(openssl passwd -1 "SALT$dni") $dni
			done <<< "$(cat $1 | tail -n +2)"
			exit 0
		elif [ $1 = "-h" ]
		then
			echo -e "Descripció: Donat un fitxer que conté les dades personals d'un conjunt de treballadors, el departament al que pertanyen i els projectes en els que hi treballen; es dona d'alta aquests treballadors com a usuaris del sistema i els projectes en que treballen com a grups del sistema.\n\tParàmetres:\n\t\t-Fitxer que conté les dades personals d'un conjunt de treballadors (DNI, nom i cognoms i telèfon), el departament en que treballen i els projectes en que treballen.\n\tSortida:\n\t\t-" >&2
			exit 4
		else
			echo -e "Error: El paràmetre '$1' no és un fitxer." >&2
			exit 3
		fi
	else
		echo -e "Error: El nombre de paràmetres és incorrecte." >&2
		exit 2
	fi
else
	echo -e "Error: No estàs executant com a root." >&2
	exit 1
fi
