#!/bin/bash

# Autor: Arey Ferrero Ramos.
# Data: 21 de febrer del 2022. Versió: 1.
# Descripció: Donat un fitxer, es buida i es registra en el fitxer de syslog la data i l'hora i el nom del fitxer que s'ha buidat.
#	Paràmetres:
#		- fitxer
#	Retorn:
#		-

if [ $# -eq 1 ]
then
	if [ -f $1 ]
	then
		> $1
		if [ -z $1 ]
		then
			logger "$1"	# Per comprovar que la tasca s'ha realitzat correctament es pot utilitzar la comanda 'cat /var/log/syslog | grep $1' sent usuari root.
			exit 0
		else
			echo -e "Error: El fitxer no s'ha buidat correctament." >&2
			exit 4
		fi
	elif [ $1 = '-h' ]
	then
		echo -e "bfit.sh : Donat un fitxer, es buida i es registra en el fitxer de syslog la data i l'hora i el nom del fitxer que s'ha buidat.\n\tParàmetres:\n\t\t- fitxer\n\tRetorn:\n\t\t-" >&2
		exit 3
	else
		echo -e "Error: El paràmetre introduït ha de ser un fitxer." >&2
		exit 2
	fi
else
	echo -e "Error: El número de paràmetres és incorrecte." >&2
	exit 1
fi
