#!/bin/bash

# Autor: Arey Ferrero Ramos.
# Data: 7 de març del 2022. Versió: 1.
# Descripció: Donat un fitxer, es buida i es registra en el fitxer de syslog la data i l'hora i el nom del fitxer que s'ha buidat.
#	Paràmetres:
#		-fitxer
#	Retorn:
#		-

if [ $(id -u) -eq 0 ]
then
	if [ $# -lt 5 ]
	then
		lastMe="lastcomm --forwards --strict-match"
		while getopts u:c:d:f:h option
		do
			case $option in
				u)
					lastMe="$lastMe --user ${OPTAR}'"
					;;
				c)
					lastMe="$lastMe --command ${OPTARG}"
					;;
				d)
					lastMe="$lastMe "
					;;
				f)
					lastMe="$lastMe"
					;;
				h)
					if [ $# -eq 1 ]
					then
						echo -e "lastMeu.sh: Donat un fitxer, es buida i es registra en el fitxer de syslog la data i l'hora i el nom del fitxer que s'ha buidat.\n\tParàmetres:\n\t\t-fitxer\n\tRetorn:\n\t\t-" >&2
						exit 4
					else
						echo -e "Error: El paràmetre és incorrecte." >&2
						exit 3
					fi
					;;
				*)
					echo -e "Error: El paràmetre és incorrecte." >&2
					exit 3
					;;
			esac
		done
		$lastMe | awk '{print $1, $(NF-2), $(NF-1), $NF}'
	else
		echo -e "Error: El número de paràmetres és incorrecte." >&2
		exit 2
	fi
else
	echo -e "Error: Aquest script s'ha d'executar com a root." >&2
	exit 1
fi
