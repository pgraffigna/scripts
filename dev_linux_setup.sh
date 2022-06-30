#!/bin/bash
# Instalación del entorno XFCE4 + el servicio XRDP
# actualizando e instalando dependencias
sudo apt update; sudo apt install -y xfce4 xfce4-goodies xorg dbus-x11 x11-xserver-utils xrdp

# agregando usuarios a grupos
sudo adduser xrdp ssl-cert
sudo adduser "$USER" ssl-cert

# Instalación de Powershell
sudo apt install -y powershell

# Instalación de IDE VSCODE
sudo apt install -y software-properties-common apt-transport-https wget

wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"

sudo apt update
sudo apt install -y code

