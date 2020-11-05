#!/bin/bash

#Colours
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

echo -e "${yellowColour} [!!] Iniciando la instalación del Hipervisor -- KVM ${endColour}"
sudo apt update && sudo apt install -y qemu qemu-kvm libvirt-daemon virtinst bridge-utils libvirt-bin libvirt-doc

echo -e "${yellowColour} [!!] Activando el servicio LIBVIRTD ${endColour}"
sudo systemctl enable libvirtd --now

read -p "[!!] Agregando tu usuario al grupo kvm -- ingresa el nombre de tu usuario: " usuario
sudo usermod -aG kvm $usuario

echo -e "${greenColour} [!!] Todos los procesos terminaron correctamente!!! ${endColour}"
