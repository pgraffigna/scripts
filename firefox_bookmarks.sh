#!/bin/bash

#Colores
redColor="\e[0;31m\033[1m"
yellowColor="\e[0;33m\033[1m"
blueColor="\e[0;34m\033[1m"
purpleColor="\e[0;35m\033[1m"
endColor="\033[0m\e[0m"

#Ctrl-C
trap ctrl_c INT
function ctrl_c(){
        echo -e "\n${redColor}Programa Terminado ${endColor}"
        exit 0
}

# variables
WSL_DB=('/mnt/c/Users/quentin/AppData/Roaming/Mozilla/Firefox/Profiles/'*.default-release'/places.sqlite')
#WIN_DB=('$HOME\AppData\Roaming\Mozilla\Firefox\Profiles\'*.default-release'\places.sqlite')
#LINUX_DB=('$HOME/.mozilla/firefox/'*.default'/places.sqlite')
OUT_DB='/tmp/firefox.bookmarks'

WSL_PROFILE=('/mnt/c/Users/quentin/AppData/Roaming/Mozilla/Firefox/Profiles/'*.default-release)
#WIN_PROFILE=('$HOME\AppData\Roaming\Mozilla\Firefox\Profiles\'*.default-release)
#LINUX_PROFILE=('$HOME/.mozilla/firefox/'*.default)
OUT_PROFILE=/tmp/firefox.profile

echo -e "${yellowColor}Instalando dependencias ${endColor}"
sudo apt update; sudo apt install -y sqlite3

read -p "Elegi la plataforma en la que estas? WSL/WIN/LINUX: " RESPUESTA
case $RESPUESTA in
  WSL | wsl | Wsl)
	echo -e "${yellowColor}Exportando la lista de marcadores en WSL ${endColor}"
	echo 'select url from moz_bookmarks, moz_places where moz_places.id=moz_bookmarks.fk;' | sqlite3 "$WSL_DB" | grep 'http' > "$OUT_DB"
	echo -e "${yellowColor}Haciendo backup del perfil en WSL ${endColor}"
	cp -r "$WSL_PROFILE" "$OUT_PROFILE"
	;;

  WIN | win | Win)
	echo -e "${blueColor}Exportando la lista de marcadores en WINDOWS ${endColor}"
	echo 'select url from moz_bookmarks, moz_places where moz_places.id=moz_bookmarks.fk;' | sqlite3 "$WIN_DB" | grep 'http' > "$OUT_DB"
	echo -e "${blueColor}Haciendo backup del perfil en WINDOWS ${endColor}"
	cp -r "$WIN_PROFILE" "$OUT_PROFILE"
    ;;

  LINUX | linux | Linux)
	echo -e "${purpleColor}Exportando la lista de marcadores en LINUX ${endColor}"
	echo 'select url from moz_bookmarks, moz_places where moz_places.id=moz_bookmarks.fk;' | sqlite3 "$LINUX_DB" | grep 'http' > "$OUT_DB"
	echo -e "${purpleColor}Haciendo backup del perfil en LINUX ${endColor}"
	cp -r "$LINUX_PROFILE" "$OUT_PROFILE"
	;;

	*)
    echo "Respuesta incorrecta!!"
    ;;
esac




