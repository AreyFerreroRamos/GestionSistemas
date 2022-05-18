#!/bin/bash

# Autor: Arey Ferrero Ramos.
# Data: 17 de maig del 2022. Versió: 1.
# Descripció: Supleix la comanda lp en l'enviament d'un document a imprimir. S'incorpora la funcionalitat addicional de demanar la paraula clau (emmagatzemada al fitxer /etc/passwd) i comprovar la validesa. Si
#		la clau es correcta, s'imprimeix i, si la clau és incorrecta, es mostra un missatge d'error. S'utilitza la comanda stty per introduir la paraula clau.
#	Paràmetre:
#		-
#	Retorn:
#		-

if [ $# -eq 1 ]
then
	if [ $1 = "-h" ]
	then
		echo -e "Supleix la comanda lp en l'enviament d'un document a imprimir. S'incorpora la funcionalitat addicional de demanar la paraula clau (emmagatzemada al fitxer /etc/passwd) i comprovar la validesa. Si la clau es correcta, s'imprimeix i, si la clau és incorrecta, es mostra un missatge d'error. S'utilitza la comanda stty per introduir la paraula clau.\n\tParàmetres:\n\t\t-\n\tRetorn:\n\t\t-" >&2
		exit 2
	else
		echo "Password: "
		stty -echo
		read password
		stty echo
		if [ $(sudo cat /etc/shadow | grep $USER | cut -f2 -d':') = $(openssl passwd -6 -salt $(sudo cat /etc/shadow | grep $USER | cut -f3 -d'$') $password) ]
		then
			lp $1
			exit 0
		else
			echo -e "Error: La paraula clau introduïda és incorrecta." >&2
			exit 3
		fi
	fi
else
	echo -e "Error: El nombre de paràmetres és incorrecte." >&2
	exit 1
fi
