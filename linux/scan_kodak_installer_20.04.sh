#!/bin/bash
#script para instalar scanner ir2420/ir2620 en Ubuntu 20.04 64 bits

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

#variables globales
URL="https://resources.kodakalaris.com/docimaging/drivers/LinuxSoftware_i2000_v4.14.x86_64.deb.tar.gz"
GZ="LinuxSoftware_i2000_v4.14.x86_64.deb.tar.gz"
TAR="LinuxSoftware_i2000_v4.14.x86_64.deb.tar"

trap "rm -rf tar LinuxSoftware_i2000_v4.14.x86_64.deb.tar" EXIT

echo -e "${yellowColor}Actualizando la cache de los repos ${endColor}"
sudo apt-get update -qq

echo -e "\n${yellowColor}Descargando instaladores ${endColor}"
wget -q  --show-progress --progress=bar:force 2>&1 "$URL"

echo -e "\n${yellowColor}Descomprimiendo el gz ${endColor}"
gunzip "$GZ"

echo -e "\n${yellowColor}Descomprimiendo el tar ${endColor}"
mkdir -p tar 2>/dev/null && tar -xf "$TAR" -C tar && cd tar

echo -e "\n${yellowColor}Corriendo el script ${endColor}"
sudo ./setup

echo -e "\n${yellowColor}Reparando la instalacion ${endColor}"
sudo apt-get -f install -y -qq

echo -e "\n${yellowColor}Reparando las dependencias ${endColor}"
sudo dpkg --ignore-depends=multiarch-support -i libudev0_175-0ubuntu19_amd64.deb

echo -e "\n${yellowColor}Corriendo el script una vez mas ${endColor}"
sudo ./setup

echo -e "\n${yellowColor}Creando link simbolico ${endColor}"
sudo ln -sfr /usr/lib/sane/libsane-kds* /usr/lib/x86_64-linux-gnu/sane

echo -e "\n${yellowColor}Evitando que el paquete 'libudev0' se actualice porque sino deja de funcionar el scanner ${endColor}"
sudo apt-mark hold libudev0

echo -e "\n${greenColor}Drivers instalados conectar por USB y probar!!! ${endColor}"



