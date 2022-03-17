#mmm.sh : Donat un fitxer de temperatures temporal, calcula la temperatura mínima, mitja i màxima de tot l'any.

if [ $# -eq 1 ]
then
	IFS=$'\n'
	for linia in $(cat $1)
	do
		# Es desconeix el format d'un fitxer de temperatures '.tem'.		
	done
else
	echo -e "Us: ./mmm.sh poblacio.tem"
	exit 1
fi
