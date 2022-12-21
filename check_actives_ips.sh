#!/bin/bash

#Colores
ROJO="\e[0;31m\033[1m"
AMARILLO="\e[0;33m\033[1m"
FIN="\033[0m\e[0m"

#ctrl_c
trap ctrl_c INT
function ctrl_c(){
    echo -e "\n${ROJO}[CHECK_IPS] Programa Terminado ${FIN}"
    exit 0
}

# variables
LISTADO=$1
SCRIPT=$(basename $0) # referencia al nombre del script

if [ $# -eq 1 ]; then # chequea que haya 1 argumento
    while read LINE; do
        ping -c 1 $LINE | grep '64';
    done < $LISTADO
else
    echo -e "${AMARILLO}[CHECK_IPS] [Uso]: $SCRIPT lista.txt ${FIN}"
    exit 0
fi
