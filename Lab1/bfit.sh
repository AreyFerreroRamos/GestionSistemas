#!/bin/bash

# Autor: Arey Ferrero Ramos.
# Data: 21 de febrer del 2022. Versió: 1.
# Descripció: Donat un fitxer, es buida i es registra en el fitxer de syslog la data i l'hora i el nom del fitxer que s'ha buïdat.
#	Paràmetros:
#		- fitxer
#	Retorn:
#		-

if [ $(id -u) -eq 0 ]
then
	if [ $# -eq 1 ]
	then
		if [ -f $1 ]
		then
			> $1
			logger "$1"	# Per comprovar que la tasca s'ha realitzat correctament es pot utilitzar la comanda 'tail -1 /var/log/syslog' com a superusuari.
			exit 0
		elif [ $1 = '-h' ]
		then
			echo -e "bfit.sh : Donat un fitxer, es buida i es registra en el fitxer de syslog la data i l'hora i el nom del fitxer que s'ha buïdat.\n\tParàmetres:\n\t\t- fitxer\n\tRetorn:\n\t\t-" >&2
			exit 4
		else
			echo -e "El paràmetre introduït no és un fitxer." >&2
			exit 3
		fi
	else
		echo -e "El número de paràmetres és incorrecte." >&2
		exit 2
	fi
else
	echo -e "L'usuari no és root." >&2
	exit 1
fi
