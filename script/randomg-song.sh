#! /bin/bash

declare -r pathThemes="file:///media/otpfullstack/Windows/cancionesuwu"
declare -a songList=()
declare numberOfSongs

prefix="file:///media/otpfullstack/Windows/cancionesuwu/"
songIndex=0

if [ -z "$1" ]; then 
   echo "Número de canciones:"
   read numberOfSongs
else
   numberOfSongs=$1
fi

# la entrada de readarray sera la salida de la expansion de proceso <(...)>, en todo caso sera lo que se almacenara dentro del array instanciado
readarray -t songs_obtained < <(find "/media/otpfullstack/Windows/cancionesuwu" -type f -printf "%f\n" | shuf -n $numberOfSongs)

for songs in "${songs_obtained[@]}"; do
   songList+=("$pathThemes/$songs")
done

echo "―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――"
for items in "${songList[@]}"; do 
   ((songIndex++))
   trimmed="${items#$prefix}"

   echo " $songIndex - $trimmed" 
   echo "―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――"
done 

cvlc --intf dummy "${songList[@]}" 2> /dev/null
