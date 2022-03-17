# nlin.sh : Escriu la línea x d'un fitxer de text.

if [ $# -eq 2 ]
then
	IFS=$'\n'
	i=1
	for line in $(cat $2)
	do
		if [ $i -eq $1 ]
		then
			echo -e $line	
		fi
		let i=i+1	
	done
else
	echo -e "Us: ./nlin.sh x fitxer"
	exit 1
fi
