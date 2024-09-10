#!/usr/bin/env bash
#
# Autor: Pablo Graffigna
# URL: www.linkedin.com/in/pablo-graffigna
#
set -e

#Colores
VERDE="\e[0;32m\033[1m"
ROJO="\e[0;31m\033[1m"
AMARILLO="\e[0;33m\033[1m"
FIN="\033[0m\e[0m"

# CTRL-C
trap ctrl_c INT
function ctrl_c(){
    echo -e "\n${ROJO}=== Programa Terminado ===${FIN}"
    exit 0
}

echo -e "\n${AMARILLO}=== Instalando KVM ===${FIN}"
sudo apt-get update && sudo apt-get install -y qemu-kvm qemu libvirt-bin virtinst bridge-utils cpu-checker virt-viewer

echo -e "\n${AMARILLO}=== Chequeando que el CPU tiene habilitada la virtualización (VT-x) ===${FIN}"
kvm-ok &> /dev/null
if [ $? -eq 1 ]; then
    echo -e "${ROJO}=== El equipo no permite la virtualización ===${}"
    exit 0
fi

echo -e "\n${AMARILLO}=== Añadiendo el usuario a los grupos de libvirt y a kvm ===${FIN}"
grep libvirt < /etc/group | awk -F':' "{'print $1'}" | xargs -n1 sudo adduser "$USER"
sudo adduser "$USER" kvm

echo -e "\n${AMARILLO}=== Relogueando al usuario y confirmando que es miembro de los grupos ===${FIN}"
exec su -l "$USER" && id | grep libvirt

echo -e "\n${AMARILLO}=== Iniciando el servicio libvirtd ===${FIN}"
sudo systemctl enable libvirtd --now

echo -e "${VERDE}===Todos los procesos terminaron correctamente!!! ===${FIN}"
