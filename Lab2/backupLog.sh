#!/bin/sh -x

# Autor: Arey Ferrero Ramos.
# Data: 1 de març del 2022. Versió: 1.
# Descripció: Es fa una copia de seguretat comprimida del directori /var/log que es deixa sota un directori anomenat /back/logs i s'escriu un missatge de prioritat info en el syslog amb la data, hora actual i
# 		mida del fitxer. El directori /back/logs es propietat de root, te permisos d'escriptura només per a root i permisos de lectura per a tots els usuaris.
# 	Paràmetres:
#		-{start|stop|status|restart|force-reload}
#	Retorn:
#		-

### BEGIN INIT INFO
# Required-Start: $remote_fs $syslog
# Required-Stop: $remote_fs $syslog
# Default-Start: 1 2 3 4 5
# Default-Stop: 0 6
# Short-Description: A service por practice system V style services.
# Description: A compressed backup is made of the /var/log directory which is left under a directory called /back/logs and an info priority message is written to the syslog with the date, current time, and 
# 		file size. The /back/logs directory is root-owned, has root-only write permissions, and read-only permissions for all users..
# placed in /home/milax/GSX/GestionSistemas/Lab2
### END INIT INFO

do_start()
{
	mkdir -p /back/logs
	tar czvf /back/logs/$(date +%y%m%d%H%M).tgz /var/log
	logger "$(ls -l /back/logs/* | cut -f5 -d' ')"
	exit 0
}

if [ $(id -u) -eq 0 ]
then
	if [ $# -eq 1 ]
	then
		case "$1" in
			start)
				do_start
				;;
			stop)
				echo "Aquest servei no s'executa quan s'apaga el sistema." >&2
				exit 0
				;;
			status)
				echo "Aquest servei no s'executa quan es demana l'estat del sistema." >&2
				exit 0
				;;
			restart|force-reload)
				echo "Aquest servei no s'executa quan s'apaga el sistema." >&2
				do_start
				;;
			-h)
				echo "Descripció: Es fa una copia de seguretat comprimida del directori /var/log que es deixa sota un directori anomenat /back/logs i s'escriu un missatge de prioritat info en el syslog amb la data, hora actual i mida del fitxer. El directori /back/logs es propietat de root, te permisos d'escriptura només per a root i permisos de lectura per a tots els usuaris.\n\tParàmetres:\n\t\t-{start|stop|status|restart|force-reload}\n\tRetorn:\n\t\t-"
				exit 4
				;;
			*)
				echo "Error: El paràmetre és incorrecte. Ús: $0 {start|stop|status|restart|force-reload}" >&2
				exit 3
				;;
		esac
	else
		echo "Error: El número de paràmetres és incorrecte. Ús: $0 {start|stop|status|restart|force-reload}" >&2
		exit 2 
	fi
else
	echo "Error: No estàs executant com a root." >&2
	exit 1
fi
