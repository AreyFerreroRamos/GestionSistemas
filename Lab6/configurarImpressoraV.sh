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
		dpkg -l cups >> /dev/null
		if [ $? -eq 4 ]
		then
			apt-get install cups
			apt-get install cups-pdf	
		fi
		systemctl disable apparmor
			# Per llistar els dispositius existents s'utilitza la comanda 'lpinfo -v'. 
			# Per llistar els drivers dels dispositius existents s'utilitza la comanda 'lpinfo -m'.
		lpadmin -p impressoraV -E -v cups-pdf:/ -m lsb/usr/cups-pdf/CUPS-PDF_opt.ppdi
			# Per comprovar que la impressoraV accepta peticions s'utilitza la comanda 'lpstat -a'.
		sed -i 's/Out ${HOME}\/PDF/Out \/mnt\/mem\/DocsPDF${USER}/g' /etc/cups/cups-pdf.conf
			# Per configurar que la impressora per defecte sigui impressoraV, s'obre el firefox i es busca 'localhost:631/printers/impressoraV'. Es selecciona la pestanya desplegable 'Administration'
			# i es tria l'opció 'set as server default'.	
		lpoptions -p impressoraV -o orientation-requested=4 -o ColorMode=Black -o number-up=2 	
			# Per enviar un document a imprimir s'utilitza la comanda 'lp -d impressoraV <nom_document>'.
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
