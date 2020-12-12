#!/bin/bash
# basado en la version 6.2 de proxmox
# script para actualizar proxmox sin subscripcion

# agregar linea 
echo "deb http://download.proxmox.com/debian buster pve-no-subscription" >> /etc/apt/sources.list

# comentar linea
sed -e '/^deb/s/^/#/' -i /etc/apt/sources.list.d/pve-enterprise.list

# actualizar los paquetes
apt update && apt dist-upgrade -y

