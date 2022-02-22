#!/bin/bash

# Autor: Arey Ferrero Ramos.
# Data: 21 de febrer del 2022. Versió: 1.
# Descripció: Indica quins paquets estan instal·lats en el sistema i en quina versió.
#	Paràmetres:
#		- 
#	Retorn:
#		-

if [ $# -eq 0 ]
then
	dpkg -l | grep ii | tr -s ' ' | cut -f2,3 -d' '
	exit 0
elif [ $1 = '-h' ]
then
	echo -e "paquets.sh: Indica quins paquets estan instal·lats en el sistema i en quina versió.\n\tParàmetres:\n\t\t-\n\tRetorn\n\t\t-" >&2
	exit 1
else
	echo -e "Els paràmetres introduïts son incorrectes." >&2
	exit 2
fi
