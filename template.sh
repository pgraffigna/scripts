#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
redColour="\e[0;31m\033[1m"
yellowColour="\e[0;33m\033[1m"
blueColour="\e[0;34m\033[1m"
purpleColour="\e[0;35m\033[1m"
endColour="\033[0m\e[0m"

trap ctrl_c INT
function ctrl_c(){
        echo -e "\n${redColour}[++] Programa Terminado [++]${endColour}"
        exit 0
}

# valida si se pasa un argumento al ejecutar el script 
if [ $1 ]; then 
----> "Código aquí"
else
 echo -e "\n${yellowColour}[Uso]: SCRIPT.SH ARG/FILE${endColour}"
 exit 0
fi