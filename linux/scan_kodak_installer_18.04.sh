#!/bin/bash
#script para instalar scanner ir2420/ir2620 en Ubuntu 18.04 32 o 64 bits

#Colores
greenColor="\e[0;32m\033[1m"
redColor="\e[0;31m\033[1m"
yellowColor="\e[0;33m\033[1m"
blueColor="\e[0;34m\033[1m"
endColor="\033[0m\e[0m"

trap ctrl_c INT
function ctrl_c(){
        echo -e "\n${redColor}Programa Terminado ${endColor}"
        exit 0
}

#variables globales
URL_32="https://resources.kodakalaris.com/docimaging/drivers/LinuxSoftware_i2000_v4.14.i586.deb.tar.gz"
GZ_32="LinuxSoftware_i2000_v4.14.i586.deb.tar.gz"
TAR_32="LinuxSoftware_i2000_v4.14.i586.deb.tar"

URL_64="https://resources.kodakalaris.com/docimaging/drivers/LinuxSoftware_i2000_v4.14.x86_64.deb.tar.gz"
GZ_64="LinuxSoftware_i2000_v4.14.x86_64.deb.tar.gz"
TAR_64="LinuxSoftware_i2000_v4.14.x86_64.deb.tar"

trap "rm -rf tar LinuxSoftware_i2000_v4.14.i586.deb.tar LinuxSoftware_i2000_v4.14.x86_64.deb.tar" EXIT

read -p "$(echo -e ${blueColor}Ingrese su respuesta 32/64: ${endColor})" RESPUESTA
case "$RESPUESTA" in
  32)
   echo -e "${yellowColor}Actualizando la cache de los repos ${endColor}"
   sudo apt-update -qq

   echo -e "\n${yellowColor}Descargando instaladores ${endColor}"
   wget -q  --show-progress --progress=bar:force 2>&1 "$URL_32"

   echo -e "\n${yellowColor}Descomprimiendo el gz ${endColor}"
   gunzip "$GZ_32"

   echo -e "\n${yellowColor}Descomprimiendo el tar ${endColor}"
   mkdir -p tar 2>/dev/null && tar -xf "$TAR_32" -C tar && cd tar

   echo -e "\n${yellowColor}Corriendo el script ${endColor}"
   sudo ./setup

   echo -e "\n${yellowColor}Corriendo el script de nuevo ${endColor}"
   sudo ./setup

   echo -e "\n${yellowColor}Creando link simbolico ${endColor}"
   sudo ln -sfr /usr/lib/sane/libsane-kds* /usr/lib/i386-linux-gnu/sane

   echo -e "\n${greenColour}Drivers instalados conectar por USB y probar!!! ${endColor}"
   ;;
  64)
  echo -e "${yellowColor}Actualizando la cache de los repos ${endColor}"
  sudo apt-update -qq

  echo -e "\n${yellowColor}Descargando instaladores ${endColor}"
  wget -q  --show-progress --progress=bar:force 2>&1 "$URL_64"

  echo -e "\n${yellowColor}Descomprimiendo el gz ${endColor}"
  gunzip "$GZ_64"

  echo -e "\n${yellowColor}Descomprimiendo el tar ${endColor}"
  mkdir -p tar 2>/dev/null && tar -xf "$TAR_64" -C tar && cd tar

  echo -e "\n${yellowColor}Corriendo el script ${endColor}"
  sudo ./setup

  echo -e "\n${yellowColor}Corriendo el script una vez mas ${endColor}"
  sudo ./setup

  echo -e "\n${yellowColor}Creando link simbolico ${endColor}"
  sudo ln -sfr /usr/lib/sane/libsane-kds* /usr/lib/x86_64-linux-gnu/sane

  echo -e "\n${greenColor}Drivers instalados conectar por USB y probar!!! ${endColor}"
    ;;
  *)
    echo "Respuesta incorrecta :( ..ingresa 32 o 64"
    ;;
esac



