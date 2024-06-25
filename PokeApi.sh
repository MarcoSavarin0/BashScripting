#!/bin/bash
#Marco Savarino

denuevo="si"

while [ "$denuevo" = "si" ]
do
encontrado="no"
while [ "$encontrado" = "no" ]
  do
echo "Ingresa el nombre del pokemon"
read pokemon

response=$(curl -s https://pokeapi.co/api/v2/pokemon/$pokemon)


if echo "$response" | jq . >/dev/null 2>&1; then
 echo $response | jq ".id,.name,.types[0].type.name"
 encontrado="si"
else
     echo "Ups.. Hubo un problema con tu pokemon... Intenta de nuevo"
fi
      done
echo "Quieres buscar otro pokemon"
read denuevo 

done

echo "Chau!"