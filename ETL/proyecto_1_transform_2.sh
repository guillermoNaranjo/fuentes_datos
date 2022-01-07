#!/bin/bash
#eliminamos ,;:
sed -i 'y/,;:/   /' $1
#pasar a formato id,(n|x|y)valor
gawk 'BEGIN{RS="</place>"}
{match($0,/place_id="([0-9]*)/,id)
if(match($0,/<name>(.*)<\/name>/,name)){
  print id[1],",n",name[1]
}
if(match($0,/<x>(.*)<\/x>/,x)){
  print id[1],",x",x[1]
}
if(match($0,/<y>(.*)<\/y>/,y)){
  print id[1],",y",y[1]
}
}' $1 > estacionesA.csv
#quitar espacio entre id
sed -i 's/ //' estacionesA.csv
#pasar a csv
awk -F, '{
  if(match($0,/^([0-9]*),n.(.*)/,val)){
    nombre[val[1]]=val[2]
  }
  if(match($0,/^([0-9]*),x.(.*)/,val)){
    x[val[1]]=val[2]
  }
  if(match($0,/^([0-9]*),y.(.*)/,val)){
    y[val[1]]=val[2]
  }}{ids[$1]=1}END{for (id in ids){
  print id, ",",nombre[id],"," ,x[id], ",",y[id]}
}' estacionesA.csv > estaciones.csv

sed -i 's/ , /,/g' estaciones.csv
#hacer lowercase
sed -i 's/[A-Z]/\L&/g' estaciones.csv
#eliminar guiones
sed -i 's/\([a-z]\)-\([a-z]\)/\1\2/g' estaciones.csv
sed -i 's/ - / /g' estaciones.csv
sed -i 's/\([a-z]\)-/\1/' estaciones.csv
sed -i 's/-\([a-z]\)/\1/g' estaciones.csv
sed -i 's/\([0-9]\)-\([0-9]\)/\1 \2/g' estaciones.csv
#eliminar puntos
sed -i 's/\([a-z]\)\.\(.*\)/\1\2/g' estaciones.csv
sed -i 's/\([a-z]\)\./\1/g' estaciones.csv
sed -i 's/v\./v/g' estaciones.csv
sed -i 's/\.\([a-z]\)/\1/g' estaciones.csv
sed -i 's/ \. / /' estaciones.csv
sed -i 's/\. / /' estaciones.csv
sed -i 's/ \.//' estaciones.csv
#agregar header
sed -i '1 i \estacion_servicio,nombre,longitud,latitud' estaciones.csv
#cuentas estaciones tienen geolocalización?
awk -F, '{if ($3!=0 && $4!=0 && NR>1)sum++}
END{print "Estaciones diferentes:",sum}' estaciones.csv

rm estacionesA.csv
