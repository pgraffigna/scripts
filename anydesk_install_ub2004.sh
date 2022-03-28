#!/bin/bash
# script para instalar anydesk en ubuntu 20.04

#Colores
greenColor="\e[0;32m\033[1m"
redColor="\e[0;31m\033[1m"
yellowColor="\e[0;33m\033[1m"
endColor="\033[0m\e[0m"

ANYDESK="https://download.anydesk.com/linux/anydesk_6.1.0-1_amd64.deb"
LIBGTKG="http://mirrors.kernel.org/ubuntu/pool/universe/g/gtkglext/libgtkglext1_1.2.0-9_amd64.deb"
LIBPANGOX="http://mirrors.kernel.org/ubuntu/pool/universe/p/pangox-compat/libpangox-1.0-0_0.0.2-5ubuntu1_amd64.deb"

trap "rm *.deb" EXIT

trap ctrl_c INT
function ctrl_c(){
        echo -e "\n${redColor}Programa Terminado ${endColor}"
        exit 0
}

echo -e "\n${yellowColor}Descargando dependencias y aplicacion ${endColor}"
wget -q "$ANYDESK" && wget -q "$LIBGTKG" && wget -q "$LIBPANGOX"

echo -e "\n${yellowColor}Instalando dependencias ${endColor}"
sudo dpkg -i libpangox-1.0-0_0.0.2-5ubuntu1_amd64.deb >/dev/null && sudo dpkg -i libgtkglext1_1.2.0-9_amd64.deb >/dev/null

echo -e "\n${yellowColor}Instalando anydesk ${endColor}"
sudo dpkg -i anydesk_6.1.0-1_amd64.deb

echo -e "\n${greenColor}Todos los procesos terminaron correctamente!!! ${endColor}"
