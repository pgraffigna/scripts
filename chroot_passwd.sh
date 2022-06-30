#!/bin/bash
#script para cambiar la clave de cualquier usuario en equipos linux via chroot

#Colores
greenColour="\e[0;32m\033[1m"
redColour="\e[0;31m\033[1m"
yellowColour="\e[0;33m\033[1m"
endColour="\033[0m\e[0m"

trap ctrl_c INT
function ctrl_c(){
        echo -e "\n${redColour}Programa Terminado ${endColour}"
        exit 0
}

echo -e "${yellowColour}Listando particiones ${endColour}"
lsblk -f | grep 'sd'

echo -e "\n${yellowColour}Creando el directorio donde montar el SO ${endColour}"
sudo mkdir /mnt/recovery

read -r -p "$(echo -e "${yellowColour}"Ingresa el nombre de la particion a montar sin el /dev: "${endColour}")" PART
sudo mount /dev/"$PART" /mnt/recovery

echo -e "\n${yellowColour}Accediendo via CHROOT ${endColour}"
sudo chroot /mnt/recovery

echo -e "${greenColour}Desmontando ${endColour}"
sudo umount /mnt/recovery




