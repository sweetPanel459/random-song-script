#! /bin/bash

selectPath (){
   echo "Seleccione la ruta de su directorio:"
   read directoryPath

   if [[ -d $directoryPath ]]; then
      echo "$directoryPath" > ./config/directory-path.txt
   fi
}

selectPlayList () {
   declare -r path=$(cat ./config/directory-path.txt)
   declare -a playListSong=()
   declare numerberOfSong

   if [[ -z "$1"  ]]; then
      echo "Numero de canciones"
      read numberOfSong
   else
      numberOfSong=$1 
   fi

   readarray -t playList < <(find "$path" -type f -printf "%f\n" | shuf -n $numberOfSong) 

   for songs in "${playList[@]}"; do 
      playListSong+=("$path/$songs")
   done

   cvlc --intf dummy "${playListSong[@]}" 2> /dev/null
}


if [[ -s ./config/directory-path.txt ]]; then
   selectPlayList $1
else
   selectPath
fi



# declare -r pathThemes="file:///media/otpfullstack/Windows/cancionesuwu"
# declare -a songList=()
# declare numberOfSongs
#
# prefix="file:///media/otpfullstack/Windows/cancionesuwu/"
# songIndex=0
#
# if [ -z "$1" ]; then 
#    echo "Número de canciones:"
#    read numberOfSongs
# else
#    numberOfSongs=$1
# fi
#
# # la entrada de readarray sera la salida de la expansion de proceso <(...)>, en todo caso sera lo que se almacenara dentro del array instanciado
# readarray -t songs_obtained < <(find "/media/otpfullstack/Windows/cancionesuwu" -type f -printf "%f\n" | shuf -n $numberOfSongs)
#
# for songs in "${songs_obtained[@]}"; do
#    songList+=("$pathThemes/$songs")
# done
#
# echo "―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――"
# for items in "${songList[@]}"; do 
#    ((songIndex++))
#    trimmed="${items#$prefix}"
#
#    echo " $songIndex - $trimmed" 
#    echo "―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――"
# done 
#
# cvlc --intf dummy "${songList[@]}" 2> /dev/null
