#!/bin/bash
#script para instalar Docker en Ubuntu server 20.04

#Colores
redColor="\e[0;31m\033[1m"
yellowColor="\e[0;33m\033[1m"
endColor="\033[0m\e[0m"

trap ctrl_c INT
function ctrl_c(){
        echo -e "\n${redColor}Programa Terminado ${endColor}"
        exit 0
}

echo -e "${yellowColor}Eliminar otras versiones de Docker ${endColor}"
sudo apt remove docker docker-compose docker.io containerd runc

echo -e "${yellowColor}Actualiza la cache de los repos ${endColor}"
sudo apt update

echo -e "${yellowColor}Instalación de dependencias ${endColor}"
sudo apt -y install apt-transport-https ca-certificates curl gnupg-agent  software-properties-common

echo -e "${yellowColor}Agrega la llave GPG de Docker ${endColor}"
curl -fsSL  https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo -e "${yellowColor}Agrega el repositorio stable ${endColor}"
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

echo -e "${yellowColor}Actualiza la cache de los repos ${endColor}"
sudo apt update

echo -e "${yellowColor}Instalación de docker-ce + docker-compose ${endColor}" 
sudo apt install -y docker-ce docker-compose

echo -e "${yellowColor}Agrega usuario al grupo docker ${endColor}"
sudo usermod -aG docker "$USER"
