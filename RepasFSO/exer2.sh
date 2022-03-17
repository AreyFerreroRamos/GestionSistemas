#exer2: Donats dos números d'entrada mostra per pantalla el quocient de la seva divisió. El codi de retorn es el residu de la seva divisió.

let quocient=$1/$2
let residu=$1%$2
echo "$1 / $2 = $quocient"
exit $residu
