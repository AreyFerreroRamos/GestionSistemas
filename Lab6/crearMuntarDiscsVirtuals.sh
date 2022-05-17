#!/bin/bash

# Autor: Arey Ferrero Ramos.
# Data: 17 de maig del 2022. Versió: 1.
# Descripció: Es creen dos discs virtuals a memòria. El primer disc tindrà format tmpfs es muntarà a /mnt/mem cada vegada que s'engegui la màquina i hi podran llegir i  escriure tots els usuaris del sistema. 
#		El segon disc tindrà una mida de 100 MB, es muntarà al directori /usuari/home/Baixades cada vegada que l'usuari al que pertanyi entri en el sistema i s'esborrarà quan l'usuari surti del sistema. 
#		Això implica que n'hi haurà un per cada usuari connectat.
#	Paràmetres:
#		-
#	Retorn:
#		-

if [ $(id -u) -eq 0 ]
then
	if [ $# -eq 0 ]
	then
		mkdir -p /mnt/mem
		echo -e "tmpfs\t/mnt/mem\ttmpfs\tdefaults\t0\t0" >> /etc/fstab
		for usuari in $(ls /home)
		do
			mkdir -p /home/$usuari/Baixades
			echo -e "tmpfs\t/home/$usuari/Baixades\ttmpfs\tdefaults,user,noauto,size=100M\t0\t0" >> /etc/fstab
			echo -e "mount /home/$usuari/Baixades" >> /etc/profile
			echo -e "trap 'umount /home/$usuari/Baixades' EXIT" >> /etc/profile
		done	
		mount -a	# S'utiltza la comanda 'df -l' per comprovar que s'ha muntat el disc.
		exit 0
	elif [ $1 = "-h" ]
	then
		echo -e "Es creen dos discs virtuals a memòria. El primer disc tindrà una mida de 100 MB, es muntarà al directori /usuari/home/Baixades cada vegada que l'usuari al que pertanyi entri en el sistema i s'esborrarà quan l'usuari surti del sistema. Això implica que n'hi haurà un per cada usuari connectat. El segon disc tindrà format tmpfs es muntarà a /mnt/mem cada vegada que s'engegui la màquina i hi podran llegir i  escriure tots els usuaris del sistema.\n\tParàmetres:\n\t\t-\n\tRetorn:\n\t\t-" >&2
		exit 3
	else
		echo -e "Error: Els paràmetres son incorrectes." >&2
		exit 2
	fi
else
	echo -e "Error: No estàs executant com a root." >&2
	exit 1
fi
