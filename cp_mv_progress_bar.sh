#!/bin/bash
# https://ostechnix.com/advanced-copy-add-progress-bar-to-cp-and-mv-commands-in-linux/

#Colours
greenColour="\e[0;32m\033[1m"
redColour="\e[0;31m\033[1m"
yellowColour="\e[0;33m\033[1m"
blueColour="\e[0;34m\033[1m"
purpleColour="\e[0;35m\033[1m"
endColour="\033[0m\e[0m"

#CTRL-C
trap ctrl_c INT
function ctrl_c(){
        echo -e "\n${redColour}[++] Programa Terminado [++]${endColour}"
        exit 0
}

#BANNER
function banner(){

echo -e "${greenColour}

	.__        ___.
	|  | _____ \_ |__   ______
	|  | \__  \ | __ \ /  ___/
	|  |__/ __ \| \_\ \\___ \
    |____(____  /___  /____  >
	          \/    \/     \/

${endColour}"
}

banner

echo -e "${greenColour}[!!] Parcheando el sistema para agregar barra de progreso al comando CP/MV ${endColour}"
echo -e "${yellowColour}[!!] Instalando requisitos ${endColour}"
sudo apt update && sudo apt install -y build-essential

echo -e "${yellowColour}[!!] Descargando paquetes necesarios y descomprimiendo ${endColour}"
wget http://ftp.gnu.org/gnu/coreutils/coreutils-8.32.tar.xz
tar xvJf coreutils-8.32.tar.xz
cd coreutils-8.32/

echo -e "${yellowColour}[!!] Descargando el parche e instalando ${endColour}"
wget https://raw.githubusercontent.com/jarun/advcpmv/master/advcpmv-0.8-8.32.patch
patch -p1 -i advcpmv-0.8-8.32.patch
./configure
make

echo -e "${yellowColour}[!!] Copiando los binarios modificados ${endColour}"
sudo cp src/cp /usr/local/bin/cp
sudo cp src/mv /usr/local/bin/mv

echo -e "${yellowColour}[!!] Borrando archivos innecesarios ${endColour}"
rm -rf coreutils-8.32.tar.xz coreutils-8.32/ 

echo -e "${greenColour}[!!] Todos los procesos terminaron correctamente!!! ${endColour}"
echo -e "${greenColour}[!!] Usar la opción g para mostrar la barra de progreso ej: cp -g ARCHIVO_ORIGEN DESTINO ${endColour}"

