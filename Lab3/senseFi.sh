#!/bin/bash

# Autor: Arey Ferrero Ramos.
# Data: 8 de març del 2022. Versió: 1.
# Descripció: Aquest programa executa durant un nombre infinit d'iteracions una operació. L'objectiu d'aquest script es poder generar processos que no acaben mai i que consumeixen molta CPU.
# 	Paràmetres:
#		-
#	Retorn:
#		-

if [ $# -eq 0 ]
then
	acum=0
	calc=1
	while true
	do
		let acum=acum+calc*2
		echo -e "El resultat de l'operació és: $acum"	
	done
	exit 0
elif [ $1 = "-h" ]
then
	echo -e "Descripció: Aquest programa executa durant un nombre infinit d'iteracions una operació. L'objectiu d'aquest script es poder generar processos que no acaben mai i que consumeixen molta CPU.\n\tParàmetres:\n\t\t-\n\tRetorn:\n\t\t-" >&2
	exit 1
else
	echo -e "Error: Els paràmetres d'entrada son incorrectes." >&2
	exit 2
fi
