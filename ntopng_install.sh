#!/bin/bash
#script para instalar el servicio ntopng para monitoreo de redes

URL=https://packages.ntop.org/apt/20.04/all/apt-ntop.deb
DEB=apt-ntop.deb

#Colores
greenColor="\e[0;32m\033[1m"
redColor="\e[0;31m\033[1m"
yellowColor="\e[0;33m\033[1m"
endColor="\033[0m\e[0m"

trap ctrl_c INT
function ctrl_c(){
        echo -e "\n${redColour}Programa Terminado ${endColour}"
        exit 0
}

trap "rm $DEB" EXIT

echo -e "${yellowColor}Actualizando los paquetes ${endColor}"
sudo apt update -y 

echo -e "${yellowColor}Descargando el ntopng ${endColor}"
wget -q --show-progress --progress=bar:force 2>&1 $URL

echo -e "${yellowColor}Instalando ntop ${endColor}"
sudo dpkg -i $DEB &>/dev/null; sudo apt update; sudo apt install ntopng -y

echo -e "${yellowColor}Editando archivo de configuracion ${endColor}"
sudo sed -e 's/# -e/-e/' -e 's/# -G=\/var\/run\/ntopng.pid/-G=\/var\/run\/ntopng.pid/' -e 's/# -i=eth1/-i=enp0s3/' -e 's/# -i=eth2/-i=enp0s4/'  -e 's/# -w=3000/-w=3000/' -i /etc/ntopng/ntopng.conf
echo "--community" | sudo tee -a /etc/ntopng/ntopng.conf

echo -e "${greenColor}Iniciando el servicio ${endColor}"
sudo systemctl enable ntopng --now
