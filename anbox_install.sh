#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
redColour="\e[0;31m\033[1m"
yellowColour="\e[0;33m\033[1m"
endColour="\033[0m\e[0m"

#Variables
PROGRAM=snapd

#CTRL-C
trap ctrl_c INT
function ctrl_c() {
    echo -e "\n${redColour}[++] Programa Terminado [++]${endColour}"
    exit 0
}

#Inicio del programa
    echo -e "${yellowColour}[!!] Chequeando los pre-requisitos para instalar Anbox [!!]${endColour}"

if  command -v "$PROGRAM" &>/dev/null
then
    echo -e "\n${greenColour} [!!] $PROGRAM está instalado [!!]${endColour}"
else
    echo -e "\n${redColour} [!!] $PROGRAM no esta presente...instalando [!!]${endColour}"
    sudo apt-get update && sudo apt-get install -y "$PROGRAM"
fi

	echo -e "\n${yellowColour}[!!] Instalando Anbox via $PROGRAM [!!]${endColour}"
	sudo snap install --devmode --beta anbox

	echo -e "\n${yellowColour}[!!] Instalando requisitos para poder acceder a Google Play Store [!!]${endColour}"
	sudo apt-get install -y wget curl lzip tar unzip squashfs-tools

	echo -e "\n${yellowColour}[!!] Descargando script y ejecutandolo"
	wget -q https://raw.githubusercontent.com/geeks-r-us/anbox-playstore-installer/master/install-playstore.sh
	chmod +x install-playstore.sh
	bash ./install-playstore.sh

	echo -e "\n${greenColour}[!!] Todos los programas se instalaron correctamente [!!]${endColour}"

# Iniciar ANBOX --> anbox.appmgra
# Activar todos los permisos para Google Play Services + Google Play Store
