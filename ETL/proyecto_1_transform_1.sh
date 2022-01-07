#!/bin/bash

#saca los datos en formato id,(p|r|d)(precio)
gawk 'BEGIN{RS="</place>"}
{match($0,/place_id="([0-9]*)/,id)
if(match($0,/regular">([0-9]*\.?[0-9]*)/,reg)){
  print id[1],",r",reg[1]
}
if(match($0,/premium">([0-9]*\.?[0-9]*)/,pre)){
  print id[1],",p",pre[1]
}
if(match($0,/diesel">([0-9]*\.?[0-9]*)/,die)){
  print id[1],",d",die[1]
}
}' $1 > preciosA.csv
#elilminar espacios
sed -i 's/ //g' preciosA.csv
#dar formato id,precio regular, precio premium, precio diesel
#no los saca en el mismo orden en el que ingresaron (por la forma en la que se
#crea el arreglo ids?)
awk -F, '{
  if(match($0,/^([0-9]*),r([0-9]*\.?[0-9]*)/,gas)){
    regular[gas[1]]=gas[2]
  }
  if(match($0,/^([0-9]*),p([0-9]*\.?[0-9]*)/,gas)){
    premium[gas[1]]=gas[2]
  }
  if(match($0,/^([0-9]*),d([0-9]*\.?[0-9]*)/,gas)){
    diesel[gas[1]]=gas[2]
  }}{ids[$1]=1}END{for (id in ids){
  print id, ",",regular[id],"," ,premium[id], ",",diesel[id]}
}' preciosA.csv > precios.csv

sed -i 's/ //g' precios.csv
rm preciosA.csv

sed -i '1 i \estacion_servicio,regular,premium,diesel' precios.csv

regular=$(grep -cE '^[0-9]*,[0-9]+\.?[0-9]*,.*' precios.csv)
echo "gasolineras que sirven gasolina regular: $regular"
premium=$(grep -cE '^[0-9]*,.*,[0-9]+\.?[0-9]*,.*' precios.csv)
echo "gasolineras que sirven gasolina premium: $premium"
diesel=$(grep -cE '^[0-9]*,.*,.*,[0-9]+\.?[0-9]*' precios.csv)
echo "gasolineras que sirven gasolina diesel: $diesel"
awk '{if (NR>1) gasolineras[$1]}END{print "gasolineras diferentes: ",length(gasolineras)}' precios.csv
observaciones=$(grep -cE '[0-9]+,.*' precios.csv)
echo "observaciones de precios: $observaciones"
