#!/bin/bash

#Colores
greenColour="\e[0;32m\033[1m"
redColour="\e[0;31m\033[1m"
yellowColour="\e[0;33m\033[1m"
blueColour="\e[0;34m\033[1m"
purpleColour="\e[0;35m\033[1m"
endColour="\033[0m\e[0m"

# CTRL_C
trap ctrl_c INT
function ctrl_c(){
        echo -e "\n${redColour}Programa Terminado ${endColour}"
        exit 0
}

# envía un ping a una secuencia de direcciones ip
# para reconocimiento de equipos activos

for ip in $(seq 1 10); do
         timeout 1 ping -c 1 192.168.0.$ip | grep 64 | awk '{print $4}' | tr ':' ' '  
done; wait
