#!/bin/sh -x

# Autor: Arey Ferrero Ramos.
# Data: 28 de febrer del 2022. Versió: 1.
# Descripció: Es fa una copia de seguretat comprimida del directori /var/log que es deixa sota un directori anomenat /back/logs i s'escriu un missatge de prioritat info en el syslog amb la data, hora actual i
# 		mida del fitxer. El directori /back/logs es propietat de root, te permissos d'escriptura només per a root i permissos de lectura per a tots els usuaris.
# 	Paràmetres:
#		-
#	Retorn:
#		-

### BEGIN INIT INFO
# Required-Start: $remote_fs $syslog
# Required-Stop: $remote_fs $syslog
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: A service por practice system V style services.
# Description: A compressed backup is made of the /var/log directory which is left under a directory called /back/logs and an info priority message is written to the syslog with the date, current time and 
# 		file size. The /back/logs directory is root-owned, has root-only write permissions, and read-only permissions for all users..
# placed in /home/milax/GSX/GestionSistemas/Lab2
### END INIT INFO

do_start()
{
	if [ $(id -u) -eq 0 ]
	then
		mkdir -p /back/logs
		tar czvf /back/logs/$(date +%y%m%d%H%M).tgz /var/log
		logger "$(ls -l /back/logs/* | cut -f5 -d' ')"

	else
		echo -e "Error: No estàs executant com a root" >&2
		exit 2
	fi	
}

case "$1" in
	start)
		do_start
		;;
	stop)
		echo -e "Aquest servei no s'executa quan s'apaga el sistema." >&2
		exit 3
		;;
	status)
		echo -e "Aquest servei no s'executa quan es demana l'estat del sistema." >&2
		exit 4
		;;
	restart|force-reload)
		echo -e "Aquest servei no s'executa quan s'apaga el sistema." >&2
		do_start
		;;
	-h)
		echo -e "Descripció: Es fa una copia de seguretat comprimida del directori /var/log que es deixa sota un directori anomenat /back/logs i s'escriu un missatge de prioritat info en el syslog amb la data, hora actual i mida del fitxer. El directori /back/logs es propietat de root, te permissos d'escriptura només per a root i permissos de lectura per a tots els usuaris.\n\tParàmetres:\n\t\t-\n\tRetorn:\n\t\t-"
		exit 5
		;;
	*)
		echo -e "Ús: $0 {start|restart|force-reload}" >&2
		exit 6
		;;
esac
