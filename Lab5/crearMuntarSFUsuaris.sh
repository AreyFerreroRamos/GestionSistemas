#!/bin/bash

# Autor: Arey Ferrero Ramos.
# Data: 26 d'abril del 2022. Versió: 1.
# Descripció: Es crea i es munta un SF en un segon disc, es configura per a que els canvis siguin permanents i s'hi mouen tots els directoris dels usuaris que es troben sota el directori /usuaris. 
# 		A continuació, s'assignen limitacions de blocs de dades i de i-nodes a cada departament (grup) emparant un sistema de quotes.
#	Paràmetres:
#		-
#	Sortida:
#		-

if [ $(id -u) -eq 0 ]
then
	if [ $# -eq 0 ]
	then
		# Es comprova que s'ha creat el disc amb la comanda 'fdisk -l'.
		mkdir /home/milax/GSX/GestionSistemas/Lab5/usuaris
		mv /usuaris/* /home/milax/GSX/GestionSistemas/Lab5/usuaris
		mkfs -t ext2 /dev/sdb
		mount -t ext2 -o rw /dev/sdb /usuaris	# Es fa la comprovació amb la comanda 'df -l' o miran't que s'hagi creat el directori lost+found.
		echo -e "/dev/sdb\t/usuaris\text2\tdefaults\t0\t0" >> /etc/fstab
		mv /home/milax/GSX/GestionSistemas/Lab5/usuaris/* /usuaris

		apt-get install quota
		echo -e "/dev/sdb\t/usuaris\text2\tdefaults,grpquota\t0\t0" >> /etc/fstab
		mount -o remote /usuaris
		quotacheck -g /usuaris
		edquota -g Administrador
		edquota -g Disseny
		edquota -g Marqueting
		quotaoff -g /usuaris
		quotaon -g /usuaris

		exit 0
	elif [ $1 = "-h" ]
	then
		echo -e "Descripció: Es crea i es munta un SF en un segon disc, es configura per a que els canvis siguin permanents i s'hi mouen tots els directoris dels usuaris que es troben sota el directori /usuaris. A continuació, s'assignen limitacions de blocs de dades i de i-nodes a cada departament (grup) emparant un sistema de quotes.\n\tParàmetres:\n\t\t-\n\tSortida:\n\t\t-" >&2
		exit 3
	else
		echo -e "Error: Els paràmetres son incorrectes." >&2
		exit 2
	fi
else
	echo -e "Error: No estàs executant com a root." >&2
	exit 1
fi
