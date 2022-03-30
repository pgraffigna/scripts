#!/bin/bash
# script para crear VMs via CLI en Proxmox
# https://cloud-images.ubuntu.com/

# Colores
rojo="\e[0;31m\033[1m"
amarillo="\e[0;33m\033[1m"
verde="\e[0;32m\033[1m"
end="\033[0m\e[0m"

# Ctrl-C
trap ctrl_c INT
function ctrl_c(){
        echo -e "\n${rojo}Programa Terminado por el usuario ${end}"
        exit 0
}

read -p "$(echo -e ${amarillo}Ingresa el ID para la VM \>\>  ${end})" ID
read -p "$(echo -e ${amarillo}Ingresa el nombre de la cloud-image \>\>  ${end})" IMAGEN
read -p "$(echo -e ${amarillo}Ingresa el nombre para la VM \>\>  ${end})" NOMBRE_VM
read -p "$(echo -e ${amarillo}Ingresa la cantidad de RAM \>\>  ${end})" RAM

echo -e "${amarillo}Creando VM ${end}"
qm create $ID --memory $RAM --core 2 --name $NOMBRE_VM --net0 virtio,bridge=vmbr0

echo -e "${amarillo}Importando imagen ${end}" 
qm importdisk $ID $IMAGEN local-lvm

echo -e "${amarillo}Agregando disco a VM"
qm set $ID --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-$ID-disk-0

echo -e "${amarillo}Agregando disco como cloud-init a VM ${end}"
qm set $ID --ide2 local-lvm:cloudinit

echo -e "${amarillo}Configurar cloud-init para que sea booteable ${end}"
qm set $ID --boot c --bootdisk scsi0

echo -e "${amarillo}serial console ${end}"
qm set $ID --serial0 socket --vga serial0

echo -e "${amarillo}DHCP ${end}"
qm set $ID --ipconfig0 ip=dhcp

echo -e "${amarillo}Configurando usuario ${end}"
qm set $ID --ciuser="testing" --cipassword="testing" --sshkey ~/testing.pub

echo -e "${verde}Falta configurar el hardware y cloud-init en proxmox GUI!!${end}"
