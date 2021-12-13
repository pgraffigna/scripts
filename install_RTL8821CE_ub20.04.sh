#!/bin/bash
#script para instalar los Drivers para el chipset RTL8821CE en ubuntu 20.04

#Colores
greenColor="\e[0;32m\033[1m"
redColor="\e[0;31m\033[1m"
yellowColor="\e[0;33m\033[1m"
endColor="\033[0m\e[0m"

DEB="http://mirrors.kernel.org/ubuntu/pool/universe/r/rtl8821ce/rtl8821ce-dkms_5.5.2.1-0ubuntu3_all.deb"
DKMS="rtl8821ce-dkms_5.5.2.1-0ubuntu3_all.deb"
REPO="https://github.com/tomaspinho/rtl8821ce"

trap ctrl_c INT
function ctrl_c(){
        echo -e "\n${redColor}Programa Terminado ${endColor}"
        exit 0
}

trap "sudo rm -rf $DKMS rtl8821ce"

echo -e "${yellowColor}Agregando repos en /etc/apt/sources.lst ${endColor}"
sudo tee /etc/apt/sources.list.d/sysarmy.list >/dev/null <<EOF
deb http://mirrors.eze.sysarmy.com/ubuntu/ focal main 
deb-src http://mirrors.eze.sysarmy.com/ubuntu/ focal main
EOF

echo -e "${yellowColor}Instalando dependencias ${endColor}"
sudo apt update; sudo apt install -y git dkms build-essential linux-headers-$(uname -r)

echo -e "${yellowColor}Descargando .deb ${endColor}"
wget -q "$DEB" && sudo dpkg -i "$DKMS" 

echo -e "${yellowColor}Descargando git-repo e instalando ${endColor}"
git clone "$REPO" && cd rtl8821ce
chmod +x dkms-install.sh && sudo ./dkms-install.sh

echo -e "${greenColor}Todos los procesos terminaron correctamente!! ${endColor}"
