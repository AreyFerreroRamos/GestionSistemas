# Exer3: Donada una llista de números introduida com argument, es retorna el valor mínim, màxim i mig de tots aquests números.

if [ $# -ge 2 ]
then
	min=$1
	max=$1
	mig=0
	for num in $*
	do
		if [ $num -lt $min ]
		then
			min=$num
		elif [ $num -gt $max ]
		then
			max=$num
		fi
		let mig=mig+num
	done
	let mig=mig/$#
	echo -e "min = \t $min"
	echo -e "mig = \t $mig"
	echo -e "max = \t $max"
else
	echo -e "Error ./exer3: Cal adjuntar almenys dos números."	
fi
