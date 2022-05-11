#!/bin/bash

# Autor: Arey Ferrero Ramos.
# Data: 17 de maig del 2022. Versió: 1.
# Descripció: Primer, es configura el sistema d'impressió amb el sistema CUPS 2.3.3. Després, es configura una impressora virtual per defecte anomenada impressoraV que converteix els documents a imprimir en
#		documents PDF i els emmagatzema en el directori /mnt/mem/DocsPDF/$(login_usuari). Els documents tindran paginació horitzontal, blanc i negre i dos pàgines per pàgina.
#	Paràmetres:
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
		echo -e "Primer, es configura el sistema d'impressió amb el sistema CUPS 2.3.3. Després, es configura una impressora virtual per defecte anomenada impressoraV que converteix els documents a imprimir en documents PDF i els emmagatzema en el directori /mnt/mem/DocsPDF/\$(login_usuari). Els documents tindran paginació horitzontal, blanc i negre i dos pàgines per pàgina.\n\tParàmetres:\n\t\t-\n\tRetorn:\n\t\t-" >&2
		exit 3	
	else
		echo -e "Error: Els paràmetres son incorrectes." >&2
		exit 2
	fi
else
	echo -e "Error: No estàs executant com a root." >&2
	exit 1
fi	
