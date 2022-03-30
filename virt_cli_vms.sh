#!/bin/bash
# script para crear VMs via CLI con Qemu-Spice

# Colores
redColor="\e[0;31m\033[1m"
yellowColor="\e[0;33m\033[1m"
endColor="\033[0m\e[0m"

# Ctrl-C
trap ctrl_c INT
function ctrl_c(){
        echo -e "\n${redColor}Programa Terminado por el usuario ${endColour}"
        exit 0
}

# cargando los datos de la VM 
read -p "$(echo -e ${yellowColor}Ingresa el nombre de la VM \>\>  ${endColour})" NOMBRE_VM
read -p "$(echo -e ${yellowColor}Ingresa el nombre del ISO \>\>  ${endColour})" NOMBRE_ISO
read -p "$(echo -e ${yellowColor}Ingresa el nombre del DISCO \>\>  ${endColour})" NOMBRE_DISCO
read -p "$(echo -e ${yellowColor}Ingresa la cantidad de RAM \>\>  ${endColour})" RAM
read -p "$(echo -e ${yellowColor}Ingresa el tipo de SO por ej: linux \>\>  ${endColour})" OS

virt-install \
  --name $NOMBRE_VM \
  --ram $RAM \
  --disk "path=/var/lib/libvirt/images/$NOMBRE_DISCO.raw,size=25,sparse=true,cache=none,bus=virtio,format=raw" \
  --vcpus 2 \
  --video qxl --channel spicevmc \
  --console pty,target_type=serial \
  --cdrom "/home/pgraffigna/datos/isos/$NOMBRE_ISO"
  --os-type $OS  

