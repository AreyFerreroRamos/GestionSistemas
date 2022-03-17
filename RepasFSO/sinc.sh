# sinc.sh : Donats dos directoris, compara el noms dels arxius que hi ha a cada un i si coincideixen copia la versió més nova (data d'actualització més recent) sobre la més antiga.

if [ $# -eq 2 ]
then
	IFS=$'\n'
	for arxiu1 in $(ls -l $1)
	do
		for arxiu2 in $(ls -l $2)
		do
			nomArxiu1=$(echo $arxiu1 | tr -s ' ' | cut -f10- -d' ') 
			nomArxiu2=$(echo $arxiu2 | tr -s ' ' | cut -f10- -d' ')
			if [ ! -z $nomArxiu1 ] && [ ! -z $nomArxiu2 ] && [ $nomArxiu1 = $nomArxiu2 ]
			then
				# Es desconeix com comparar de forma ràpida les dates de dos fitxers.
			fi
		done	
	done	
else
	echo -e "Us: ./sinc.sh dir1 dir2"
	exit 1
fi
