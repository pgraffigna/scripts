#!/bin/bash

#Colores
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
endColour="\033[0m\e[0m"

echo -e "${purpleColour}Funciona solo en WSL v2 ${endColour}" 
echo -e "${purpleColour}para chequear la version 'wsl --list --all -v' ${endColour}"
echo -e "\n${yellowColour}Actualizando los repos e instalando paquetes ${endColour}"
sudo apt update && sudo apt install -y snapd daemonize

echo -e "\n${yellowColour}Activando systemd en un contenedor ${endColour}"
daemonize /usr/bin/unshare --fork --pid --mount-proc /lib/systemd/systemd --system-unit=basic.target

echo -e "\n${yellowColour}Entrando al contenedor ${endColour}"
exec sudo nsenter -t "$(pidof systemd)" -a su - "$LOGNAME"

