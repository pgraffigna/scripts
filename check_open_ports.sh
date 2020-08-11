#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
redColour="\e[0;31m\033[1m"
yellowColour="\e[0;33m\033[1m"
blueColour="\e[0;34m\033[1m"
purpleColour="\e[0;35m\033[1m"
endColour="\033[0m\e[0m"

# CTRL_c
trap ctrl_c INT
function ctrl_c(){
        echo -e "\n${redColour}[++] Programa Terminado [++]${endColour}"
        exit 0
}

if [ $1 ]; then
    echo "El listado de puertos ABIERTOS se copio al portapapeles!!! "
    cat $1 | grep -oP '\d{1,5}/closed' | cut -d/ -f1 | xargs | tr ' ' ',' | xclip -sel clip
else
    echo -e "${yellowColour}[requerimientos]: Instalar el programa xclip ${endColour}"
    echo -e "${yellowColour}[Uso]: \t\t  check_open_ports.sh NMAP-GREP-FILE${endColour}"
    exit 0
fi