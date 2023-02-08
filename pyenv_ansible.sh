#!/bin/bash
#Colores
verde="\e[0;32m\033[1m"
rojo="\e[0;31m\033[1m"
azul="\e[0;34m\033[1m"
end="\033[0m\e[0m"

#CTRL_c
trap ctrl_c INT
function ctrl_c(){
        echo -e "\n${rojo}[++] Programa Terminado [++]${end}"
        exit 0
}

## validacion de dependecias
dpkg -L python3-venv &>/dev/null

if [ "$?" -eq 1 ]; then
	echo -e "\n${azul}[++] Instalando dependencias !![++] ${end}\n"
	sudo apt update && sudo apt install -y python3-venv
fi

# ansible_version
read -p "$(echo -e ${azul}Ingresa la version de ansible a instalar por ej 2.9 \>\> ${end})" ANSIBLE_VERSION

# crea el nuevo entorno
/usr/bin/python3 -m venv ansible_"$ANSIBLE_VERSION"

# activa el nuevo entorno
source ./ansible_"$ANSIBLE_VERSION"/bin/activate

# actualiza el gestor pip
python3 -m pip install --upgrade pip

# instala la version 2.9 de ansible
python3 -m pip install ansible=="$ANSIBLE_VERSION"

# mensaje exitoso
echo -e "${verde}[++] El entorno fue creado exitosamente!!! [++]${end}"

