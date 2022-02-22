#!/bin/bash

# Autor: Arey Ferrero Ramos.
# Data: 21 de febrer del 2022. Versió: 1.
# Descripció: Donat un fitxer, es buida i es registra en el fitxer de syslog la data i l'hora i el nom del fitxer que s'ha buïdat.
#	Paràmetros:
#		- fitxer
#	Retorn:
#		-

if [ $# -eq 1 ]
then
	if [ -f $1 ]
	then
		> $1
		echo " $1" >> /var/log/syslog
		exit 0
	elif [ $1 = '-h' ]
	then
		echo -e "bfit.sh : Donat un fitxer, es buida i es registra en el fitxer de syslog la data i l'hora i el nom del fitxer que s'ha buïdat.\n\tParàmetres:\n\t\t- fitxer\n\tRetorn:\n\t\t-" >&2
		exit 1
	else
		echo -e "El paràmetre introduït no és un fitxer." >&2
		exit 2
	fi
else
	echo -e "El número de paràmetres és incorrecte." >&2
	exit 3
fi
