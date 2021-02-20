#!/bin/bash
#Banners
function banner(){

echo -e "${greenColor}

.__        ___.
|  | _____ \_ |__   ______
|  | \__  \ | __ \ /  ___/
|  |__/ __ \| \_\ \\___ \
|____(____  /___  /____  >
          \/    \/     \/

${endColor}"
}

#Colores
greenColor="\e[0;32m\033[1m"
redColor="\e[0;31m\033[1m"
yellowColor="\e[0;33m\033[1m"
blueColor="\e[0;34m\033[1m"
purpleColor="\e[0;35m\033[1m"
endColor="\033[0m\e[0m"

trap ctrl_c INT
function ctrl_c(){
        echo -e "\n${redColor}Programa Terminado ${endColor}"
        exit 0
}

#Separador
function separador(){
	sep="\n-------------------------------------------------------------------"
	echo -e $sep
}

# valida si se pasa un argumento al ejecutar el script 
if [ $1 ]; then

----> "Código aquí"

else
 	echo -e "\n${yellowColor}[Uso]: SCRIPT.SH ARG/FILE$ {endColor}"
 	exit 0
fi

