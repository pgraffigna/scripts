#!/bin/bash
# script para instalar libreoffice + pack idioma español

#Colores
greenColor="\e[0;32m\033[1m"
redColor="\e[0;31m\033[1m"
yellowColor="\e[0;33m\033[1m"
blueColor="\e[0;34m\033[1m"
endColor="\033[0m\e[0m"

VERSION="7.2.6"
URL="https://download.documentfoundation.org/libreoffice/stable/$VERSION/deb/x86_64/LibreOffice_${VERSION}_Linux_x86-64_deb.tar.gz"
TAR="LibreOffice_${VERSION}_Linux_x86-64_deb.tar"
URL_LANG="https://download.documentfoundation.org/libreoffice/stable/$VERSION/deb/x86_64/LibreOffice_${VERSION}_Linux_x86-64_deb_langpack_es.tar.gz"
TAR_LANG="LibreOffice_${VERSION}_Linux_x86-64_deb_langpack_es.tar"

trap "rm -rf LibreOffice_${VERSION}.?_Linux_x86-64_deb* " EXIT

trap ctrl_c INT
function ctrl_c(){
        echo -e "\n${redColor}Programa Terminado ${endColor}"
        exit 0
}

echo -e "${yellowColor}Descargando libreoffice y descomprimiendo ${endColor}"
wget -q --show-progress --progress=bar:force 2>&1 "$URL" && gunzip *.gz && tar xvf "$TAR" && rm $_ 

echo -e "${yellowColor}Instalando el programa ${endColor}"
sudo dpkg -i LibreOffice_${VERSION}.?_Linux_x86-64_deb/DEBS/*.deb &>/dev/null

echo -e "${yellowColor}Descargando el paquete español y descomprimiendo ${endColor}"
wget -q --show-progress --progress=bar:force 2>&1 "$URL_LANG" && gunzip *.gz && tar xvf "$TAR_LANG" && rm $_

echo -e "${yellowColor}Instalando el paquete español ${endColor}"
sudo dpkg -i LibreOffice_${VERSION}.?_Linux_x86-64_deb_langpack_es/DEBS/*.deb &>/dev/null

echo -e "${greenColor}Todos los procesos terminaron correctamente!! ${endColor}"



