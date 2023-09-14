#!/usr/bin/env bash
# Colores
VERDE="\e[0;32m\033[1m"
ROJO="\e[0;31m\033[1m"
AMARILLO="\e[0;33m\033[1m"
FIN="\033[0m\e[0m"

# ctrl_c
trap ctrl_c INT
function ctrl_c(){
        echo -e "\n${ROJO}[PIP]Programa Terminado ${FIN}"
        exit 0
}

# actualizando + instalando dependencias
sudo apt update && sudo apt install -y python3-pip

# instalando + actualizando pip
pip3 install pip && pip3 install --upgrade pip --no-warn-script-location && pip install ansible --no-warn-script-location

# agregando PATH para ansible
export PATH=$PATH:~/.local/bin
