#!/bin/bash

#COLORES
greenColour="\e[0;32m\033[1m"
redColour="\e[0;31m\033[1m"
yellowColour="\e[0;33m\033[1m"
blueColour="\e[0;34m\033[1m"
purpleColour="\e[0;35m\033[1m"
endColour="\033[0m\e[0m"

echo -e "${yellowColour} [!!] Actualizando los paquetes ${endColour}"
sudo apt update && sudo apt upgrade -y 

echo -e "${yellowColour} [!!] Instalando los requisitos para usar ZFS ${endColour}"
sudo apt install -y zfsutils-linux

echo -e "${yellowColour} [!!] Listando los discos disponibles para crear el RAID ${endColour}"
lsblk

echo -e "${yellowColour} [!!] Creación del RAIDZ ${endColour}"
read -p "$(echo -e ${yellowColour} "Ingresa el nombre del POOL: "${endColour})" pool

IFS=" " read -p "$(echo -e ${yellowColour} "Ingresa el nombre de los discos separados por espacio: "${endColour}) " -ra discos
sudo zpool create $pool raidz "/dev/${discos[0]}" "/dev/${discos[1]}"

echo -e "${yellowColour} [!!] Chequeando el estado del POOL ${endColour}"
sudo zpool status

echo -e "${yellowColour} [!!] Todos los procesos terminaron correctamente!!! ${endColour}"




