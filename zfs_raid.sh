#!/bin/bash

#Colores
greenColour="\e[0;32m\033[1m"
redColour="\e[0;31m\033[1m"
yellowColour="\e[0;33m\033[1m"
blueColour="\e[0;34m\033[1m"
purpleColour="\e[0;35m\033[1m"
endColour="\033[0m\e[0m"

#CTRL-C
trap ctrl_c INT
function ctrl_c(){
        echo -e "\n${redColour}[++] Programa Terminado [++]${endColour}"
        exit 0
}

function banner(){
echo -e "${greenColour}

.__        ___.
|  | _____ \_ |__   ______
|  | \__  \ | __ \ /  ___/
|  |__/ __ \| \_\ \\___ \
|____(____  /___  /____  >
          \/    \/     \/
${endColour}"
}

banner

echo -e "${greenColour}Iniciando la instalación del HomeLAB en Ubuntu Server 20.04 ${endColour}"
echo -e "\n${yellowColour}Actualizando los paquetes ${endColour}"
sudo apt update && sudo apt upgrade -y 

echo -e "\n${yellowColour}Instalando los requisitos para usar ZFS ${endColour}"
sudo apt install -y zfsutils-linux

echo -e "\n${yellowColour}Listando los discos disponibles para crear el RAID ${endColour}"
lsblk

echo -e "\n${yellowColour}Creación del RAIDZ ${endColour}"
read -p "Ingresa el nombre del POOL: " pool

IFS=" " read -p "Ingresa el nombre de los discos separados por espacio ej: sda sdb sdc" -ra discos
zpool create $pool raidz /dev/"${discos[0]}" /dev/"${discos[1]}" /dev/"${discos[2]}"

echo -e "\n${yellowColour}Chequeando el estado del POOL ${endColour}"
zpool status
 
echo -e "\n${greenColour}Todos los procesos terminaron correctamente!!! ${endColour}"



