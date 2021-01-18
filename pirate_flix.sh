#!/bin/bash
# Script para instalar peerflix (streaming de torrents/magnets) + pirate-get (buscador de torrents/magnets)

#Colores
greenColour="\e[0;32m\033[1m"
redColour="\e[0;31m\033[1m"
yellowColour="\e[0;33m\033[1m"
blueColour="\e[0;34m\033[1m"
endColour="\033[0m\e[0m"

trap ctrl_c INT
function ctrl_c(){
        echo -e "\n${redColour}Programa Terminado {endColour}"
        exit 0
}

echo -e "${yellowColour}Instalando dependencias de peerflix ${endColour}"
sudo apt update && sudo apt install -y npm

echo -e "\n${yellowColour}Instalando peerflix ${endColour}"
sudo npm install -g peerflix

echo -e "\n${yellowColour}Instalando dependencias de pirate-get ${endColour}"
sudo apt install -y python3-pip

echo -e "\n${yellowColour}Instalando pirate-get ${endColour}"
pip3 install pirate-get

echo -e "\n${yellowColour}Ioviendo el binario al PATH ${endColour}"
sudo mv /home/quentin/.local/bin/pirate-get /usr/local/bin

#mensaje
echo -e "\n${greenColour}Todos los programas se instalaron correctamente!! ${endColour}"
echo -e "\n${blueColour}Modo de uso: ${endColour}"
echo -e "${yellowColour}pirate-get -C 'peerflix %s --vlc --subtitles FILE.srt' nombre_pelicula ${endColour}"
