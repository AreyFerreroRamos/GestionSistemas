#!/bin/bash

# Autor: Arey Ferrero Ramos.
# Data: 17 de maig del 2022. Versió: 1.
# Descripció: Supleix la comanda lp en l'enviament d'un document a imprimir. S'incorpora la funcionalitat addicional de demanar la paraula clau (emmagatzemada al fitxer /etc/passwd) i comprovar la validesa. Si
#		la clau es correcta, s'imprimeix i, si la clau és incorrecta, es mostra un missatge d'error. Cal utilitzar la comanda stty per introduir la paraula clau.
#	Paràmetre:
#		-
#	Retorn:
#		-

if [ $(id -u) -eq 0 ]
then
	if [ $# -eq 0 ]
	then
		
		exit 0
	elif [ $1 = "-h" ]
	then
		echo -e "Supleix la comanda lp en l'enviament d'un document a imprimir. S'incorpora la funcionalitat addicional de demanar la paraula clau (emmagatzemada al fitxer /etc/passwd) i comprovar la validesa. Si la clau es correcta, s'imprimeix i, si la clau és incorrecta, es mostra un missatge d'error. Cal utilitzar la comanda stty per introduir la paraula clau.\n\tParàmetres:\n\t\t-\n\tRetorn:\n\t\t-" >&2
		exit 3
	else
		echo -e "Error: Els paràmetres son incorrectes." >&2
		exit 2
	fi
else
	echo -e "Error: No estàs executant com a root." >&2
	exit 1
fi
