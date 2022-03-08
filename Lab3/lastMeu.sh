#!/bin/bash

# Autor: Arey Ferrero Ramos.
# Data: 7 de març del 2022. Versió: 1.
# Descripció: Donada una combinació qualsevol de fins a quatre opcions, es mostra diferent informació d'accounting emparant les comandes lastcomm i getopt (implementada en la bash). 
#	Paràmetres:
#		-u: Usuari.
#		-c: Comanda.
#		-d: Data.
#		-f: Flag (S, F, D, X).
#	Sortida:
#		-u: Comandes executades per un usuari.
#		-c: Usuari i data en que s'ha executat una comanda.
#		-d: Comandes executades a partir d'una determinada data.
#		-f: Comandes que tenen actiu aquest flag.

if [ $(id -u) -eq 0 ]
then
	if [ $# -lt 9 ]
	then
		if [ $1 = "-h" ]
		then
			echo -e "lastMeu.sh: Donada una combinació qualsevol de fins a quatre opcions, es mostra diferent informació d'accounting emparant les comandes lastcomm i getopt (implementada en la bash).\n\tParàmetres:\n\t\t-u: Usuari\n\t\t-c: Comanda.\n\t\t-d: Data.\n\t\t-f: Flag (S, F, D, X).\n\tSortida:\n\t\t-u: Comandes executades per un usuari.\n\t\t-c: Usuari i data en que s'ha executat una comanda.\n\t\t-d: Comandes executades a partir d'una determinada data.\n\t\t-f: Comandes que tenen actiu aquest flag." >&2
			exit 4
		else
			lastMe="lastcomm --forwards --strict-match"
			activeDate=0
			activeFlag=0
			while getopts u:c:d:f: option
			do
				case $option in
					u)
						lastMe="$lastMe --user ${OPTARG}"
						;;
					c)
						lastMe="$lastMe --command ${OPTARG}"
						;;
					d)
						if [ $(echo ${OPTARG} | cut -c1-4) -eq $(date +%Y) ]
						then
							activeDate=1
							date=$(echo ${OPTARG} | cut -c5-8)
						else
							echo -e "No hi ha informació d'accounting d'anys diferents de l'actual." >&2
							exit 4
						fi
						;;
					f)
						activeFlag=1
						flag=${OPTARG}
						;;
					*)
						echo -e "Error: El paràmetre és incorrecte." >&2
						exit 3
						;;
				esac
			done
			if [ $activeDate -eq 1 ]
			then
				echo -e "La data no s'ha acopnseguit implementar."
				#while read line;
				#do
					#echo $line | column -t
					#d=$(echo $linia | awk '{print $(NF-1), $(NF-2)}')
					#if [ date -d"$d" +%m%d -le $date ]
					#then
						#echo $line
					#fi
				#done < <(echo "$lastMe")
			elif [ $activeFlag -eq 1 ]
			then
				$lastMe | grep -E -e "(S|F|C|D|X| )$flag(S|F|C|D|X| )" | awk '{print $1, $(NF-7), $(NF-2), $(NF-1), $NF}' | column -t
			else
				$lastMe | awk '{print $1, $(NF-7), $(NF-2), $(NF-1), $NF}' | column -t
			fi
			exit 0
		fi
	else
		echo -e "Error: El número de paràmetres és incorrecte." >&2
		exit 2
	fi
else
	echo -e "Error: Aquest script s'ha d'executar com a root." >&2
	exit 1
fi
