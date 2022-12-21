#!/bin/bash

# colores
VERDE="\e[0;32m\033[1m"
ROJO="\e[0;31m\033[1m"
AMARILLO="\e[0;33m\033[1m"
FIN="\033[0m\e[0m"

# ctrl_C
trap ctrl_c INT
function ctrl_c(){
    echo -e "\n${ROJO}[CHECK_OPEN] Programa Terminado ${FIN}"
    exit 0
}

# variables
SCRIPT=$(basename $0) # referencia al nombre del script
ARCHIVO=$1 # archivo con escaneo nmap con opcion -oG --grepable


if ! [ "$(command -v xclip)" ]; then
    echo -e "${AMARILLO}[CHECK_OPEN] Instalando dependencias ${FIN}"
    sudo apt install -y xclip
fi

if [ $# -eq 1 ]; then
    echo -e "\n${VERDE}[CHECK_OPEN] El listado de puertos ABIERTOS se copio al portapapeles!!! ${FIN}"
    cat $ARCHIVO | grep -oP '\d{1,5}/closed' | cut -d/ -f1 | xargs | tr ' ' ',' | xclip -sel clip
else
    echo -e "${AMARILLO}[CHECK_OPEN] [Uso]: $SCRIPT archivo.txt ${FIN}"
    exit 0
fi
