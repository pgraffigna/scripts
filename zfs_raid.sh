#!/bin/bash

function banner(){
echo "

.__        ___.
|  | _____ \_ |__   ______
|  | \__  \ | __ \ /  ___/
|  |__/ __ \| \_\ \\___ \
|____(____  /___  /____  >
          \/    \/     \/
"
}

banner

echo "Iniciando la instalación del HomeLAB en Ubuntu Server 20.04"
echo "Actualizando los paquetes"
sudo apt update && sudo apt upgrade -y 

echo "Instalando los requisitos para usar ZFS"
sudo apt install -y zfsutils-linux

echo "Listando los discos disponibles para crear el RAID"
lsblk

echo "Creación del RAIDZ"
read -p "Ingresa el nombre del POOL: " pool

IFS=" " read -p "Ingresa el nombre de los discos separados por espacio ej: sda sdb sdc" -ra discos
zpool create $pool raidz /dev/"${discos[0]}" /dev/"${discos[1]}" /dev/"${discos[2]}"

echo "Chequeando el estado del POOL"
zpool status
 
echo "Todos los procesos terminaron correctamente!!!"



