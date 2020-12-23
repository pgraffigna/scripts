#!/bin/bash

#Colores
greenColour="\e[0;32m\033[1m"
redColour="\e[0;31m\033[1m"
yellowColour="\e[0;33m\033[1m"
blueColour="\e[0;34m\033[1m"
purpleColour="\e[0;35m\033[1m"
endColour="\033[0m\e[0m"

#CTRL_c
trap ctrl_c INT
function ctrl_c(){
        echo -e "\n${redColour}[++] Programa Terminado [++]${endColour}"
        exit 0
}

FILE=$1

if [ $1 ]; then 
    while read LINE; do
        ping -c 1 $LINE | grep 64| awk '{print $4}' | tr ':' ' '
    done < $FILE
else
 echo -e "${yellowColour}[Uso]: check_system.sh FILE ${endColour}"
 exit 0
fi
