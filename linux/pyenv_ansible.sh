#!/bin/bash
# Colores
VERDE="\e[0;32m\033[1m"
ROJO="\e[0;31m\033[1m"
AMARILLO="\e[0;33m\033[1m"
FIN="\033[0m\e[0m"

# ctrl_c
function ctrl_c(){
        echo -e "\n${ROJO}[PYENV] Programa Terminado ${FIN}"
        exit 0
}

# handler
trap ctrl_c INT

# validacion de dependecias
dpkg -L python3-venv &>/dev/null

if [ "$?" -eq 1 ]; then
	echo -e "\n${AMARILLO}[PYENV] Instalando dependencias!!${FIN}\n"
	sudo apt update && sudo apt install -y python3-venv
fi

read -p "$(echo -e ${AMARILLO}[PYENV] Ingresa la version de ansible a instalar por ej 2.9 \>\> ${FIN})" ANSIBLE_VERSION

echo -e "${AMARILLO}[PYENV] Creando el entorno virtual ${FIN}"
/usr/bin/python3 -m venv ansible_"$ANSIBLE_VERSION"

echo -e "${AMARILLO}[PYENV] Activando el nuevo entorno ${FIN}"
source ./ansible_"$ANSIBLE_VERSION"/bin/activate

echo -e "${AMARILLO}[PYENV] Actualizando el gestor pip dentro del entorno ${FIN}"
python3 -m pip install --upgrade pip

echo -e "${AMARILLO}[PYENV] Instalando ansible ${ANSIBLE_VERSION} dentro del entorno ${FIN}"
python3 -m pip install ansible=="$ANSIBLE_VERSION"

# mensaje post-script
echo -e "${VERDE}[PYENV] El entorno fue creado exitosamente!!!${FIN}"

## para usar collection_windows es necesario ansible_7.0.0