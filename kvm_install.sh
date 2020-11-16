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

echo -e "\n ${yellowColour} [!!] Instalando KVM ${endColour}"
sudo apt install -y qemu-kvm qemu libvirt-bin virt-manager virtinst bridge-utils cpu-checker virt-viewer

echo -e "\n ${yellowColour} [!!] Chequeando que el CPU tiene habilitada la virtualización (VT-x) ${endColour}"
kvm-ok &> /dev/null
if [ $? -eq 1 ]; then
        echo -e "El equipo no permite la virtualización"
    exit 0
fi

echo -e "\n ${yellowColour} [!!] Añadiendo el usuario a los grupos de libvirt y a kvm ${endColour}"
cat /etc/group | grep libvirt | awk -F':' {'print $1'} | xargs -n1 sudo adduser $USER
sudo adduser $USER kvm

echo -e "\n ${yellowColour} [!!] Relogueando al usuario y confirmando que es miembro de los grupos ${endColour}"
exec su -l $USER && id | grep libvirt

echo -e "\n ${yellowColour} [!!] Iniciando el servicio libvirtd ${endColour}"
sudo systemctl enable libvirtd --now

echo -e "${greenColour} [!!] Todos los procesos terminaron correctamente!!! ${endColour}"
