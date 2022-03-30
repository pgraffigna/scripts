#!/bin/bash
# script para conectar a cualquier red wifi via CLI
# pablo graffigna nov-2020

#Colores
greenColour="\e[0;32m\033[1m"
redColour="\e[0;31m\033[1m"
yellowColour="\e[0;33m\033[1m"
blueColour="\e[0;34m\033[1m"
purpleColour="\e[0;35m\033[1m"
endColour="\033[0m\e[0m"

#Ctrl-C
trap ctrl_c INT
function ctrl_c(){
        echo -e "\n${redColour}[++] Programa Terminado [++]${endColour}"
        exit 0
}

clear

dpkg -l wpasupplicant >/dev/null

if [ $? -eq 0 ]; then

        echo -e "${yellowColour}Generando los archivos de configuracion ${endColour}"
        read -p "Ingrese el nombre de la RED y el PASSWORD separados por espacio
        >> " -ra DATOS

        wpa_passphrase "${DATOS[0]}" "${DATOS[1]}" | sudo tee /etc/wpa_supplicant.conf > /dev/null

        echo -e "${yellowColour}Listando interfaces ${endColour}"
        iwconfig 

        echo -e "${yellowColour}Conectando a la red ${endColour}"
        read -p "Ingrese el nombre de la INTERFAZ de red
        >> " INTERFACE

        sudo wpa_supplicant -B -i "$INTERFACE" -c /etc/wpa_supplicant.conf 
        dhclient "$INTERFACE"

        echo -e "${greenColour}Estas conectado a ${DATOS[0]}!!!! ${endColour}"
else
        echo -e "${redColour}No tenes instalado wpasupplicant, el programa no puede continuar..saliendo ${endColour}"
        exit 0
fi
