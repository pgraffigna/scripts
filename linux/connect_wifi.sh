#!/usr/bin/env bash
#
# Autor: Pablo Graffigna
# URL: www.linkedin.com/in/pablo-graffigna
#
set -e

# Colores
VERDE="\e[0;32m\033[1m"
ROJO="\e[0;31m\033[1m"
AMARILLO="\e[0;33m\033[1m"
FIN="\033[0m\e[0m"

# Ctrl-C
trap ctrl_c INT
function ctrl_c(){
    echo -e "\n${ROJO}=== Programa terminado por el usuario ===${FIN}"
    exit 0
}

if ! [ 	"$(command -v wpasupplicant)" ]; then
    echo -e "${AMARILLO}=== Generando los archivos de configuracion ===${FIN}"
    read -r -p "Ingrese el nombre de la RED y el PASSWORD separados por espacio
    >> " -ra DATOS

    wpa_passphrase "${DATOS[0]}" "${DATOS[1]}" | sudo tee /etc/wpa_supplicant.conf > /dev/null

    echo -e "${AMARILLO}=== Listando interfaces ===${FIN}"
    iwconfig

    echo -e "${AMARILLO}=== Conectando a la red ===${FIN}"
    read -r -p "Ingrese el nombre de la INTERFAZ de red
    >> " INTERFACE

    sudo wpa_supplicant -B -i "$INTERFACE" -c /etc/wpa_supplicant.conf
    dhclient "$INTERFACE"

    echo -e "${VERDE}=== Estas conectado a ${DATOS[0]}!!!! ===${FIN}"
else
    echo -e "${ROJO}=== No tenes instalado wpasupplicant, el programa no puede continuar..saliendo ===${FIN}"
    exit 0
fi
