#!/bin/bash

#Colores
greenColour="\e[0;32m\033[1m"
redColour="\e[0;31m\033[1m"
yellowColour="\e[0;33m\033[1m"
blueColour="\e[0;34m\033[1m"
endColour="\033[0m\e[0m"

#Ctrl-C
trap ctrl_c INT
function ctrl_c(){
        echo -e "\n${redColour}Programa Terminado ${endColour}"
        exit 0
}

echo -e "${yellowColour}Actualiza los repos e instala el programa ${endColour}"
sudo apt update && sudo apt install -y chntpw

echo -e "\n${yellowColour}Lista particiones (para saber donde esta el Windows) ${endColour}"
lsblk -f

echo -e "\n${yellowColour}Elegi la partición con windows${endColour}"
read -r -p "$(echo -e "${blueColour}"Ingresa el nombre de la particion sin el /dev: "${endColour}")" PART

sudo mkdir /tmp/windows && sudo mount.ntfs /dev/"$PART" /tmp/windows

echo -e "\n${yellowColour}Se creo un backup del archivo SAM en /Windows/System32/config ${endColour}"
cp /tmp/windows/Windows/System32/config/SAM /tmp/windows/Windows/System32/config/SAM.bak

echo -e "\n${yellowColour}Estos son los usuarios ${endColour}"
chntpw /tmp/windows/Windows/System32/config/SAM -l

read -r -p "$(echo -e "${blueColour}"Ingresa 1 si queres activar el usuario Administrador o 2 si queres blanquear la clave de algun usuario: "${endColour}")" RESPUESTA 

case "$RESPUESTA" in
  1)
    echo -e "\n${greenColour}La respuesta es 1 ${endColour}"
    chntpw /tmp/windows/Windows/System32/config/SAM -u Administrator
    ;;
  2)
    echo -e "\n${greenColour}La respuesta es 2 ${endColour}"
    read -r -p "$(echo -e "${greenColour}"Ingresa el nombre del usuario: "${endColour}")" USUARIO
    chntpw /tmp/windows/Windows/System32/config/SAM -u "$USUARIO"
    ;;
  *)
    echo -e "${redColour}Respuesta incorrecta ${endColour}"
    ;;
esac


