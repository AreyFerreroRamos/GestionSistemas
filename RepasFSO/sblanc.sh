# sblanc.sh : Donat un directori es substitueixen els espais en blanc del nom dels fitxers per caràcters '_'.

if [ $# -eq 1 ]
then
	IFS=$'\n'
	for nomFitxer in $(ls -l $1 | tr -s ' ' | cut -f10- -d' ')
	do
		if [ $nomFitxer != $(echo $nomFitxer | tr ' ' '_') ]
		then
			mv $nomFitxer $(echo $nomFitxer | tr ' ' '_')
		fi
	done
else
	echo -e "Us: ./sblanc.sh dir"
	exit 1
fi
