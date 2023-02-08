#!/bin/bash
# script para crear VMs via CLI con Qemu-Spice

# Colores
redColor="\e[0;31m\033[1m"
yellowColor="\e[0;33m\033[1m"
endColor="\033[0m\e[0m"

# Ctrl-C
trap ctrl_c INT
function ctrl_c(){
        echo -e "\n${redColor}Programa Terminado por el usuario ${endColor}"
        exit 0
}

# cargando los datos de la VM 
read -pr "$(echo -e "${yellowColor}"Ingresa el nombre de la VM \>\>  "${endColor}")" NOMBRE_VM
read -pr "$(echo -e "${yellowColor}"Ingresa el nombre del ISO \>\>  "${endColor}")" NOMBRE_ISO
read -pr "$(echo -e "${yellowColor}"Ingresa el nombre del DISCO \>\>  "${endColor}")" NOMBRE_DISCO
read -pr "$(echo -e "${yellowColor}"Ingresa la cantidad de RAM \>\>  "${endColor}")" RAM
read -pr "$(echo -e "${yellowColor}"Ingresa el tipo de SO por ej: linux \>\>  "${endColor}")" OS

virt-install \
  --name "$NOMBRE_VM" \
  --ram "$RAM" \
  --disk "path=/var/lib/libvirt/images/$NOMBRE_DISCO.raw,size=25,sparse=true,cache=none,bus=virtio,format=raw" \
  --vcpus 2 \
  --video qxl --channel spicevmc \
  --console pty,target_type=serial \
  --cdrom "/home/pgraffigna/datos/isos/$NOMBRE_ISO" \
  --os-type "$OS"

