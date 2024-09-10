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

if ! [ "$(command -v spice-vdagent)" ]; then
    sudo apt-get update && sudo apt-get install -y spice-vdagent
    systemctl restart spice-vdagentd.service && spice-vdagent
else
    echo -e "${VERDE}=== Iniciando spice ===${FIN}"
    spice-vdagent
    exit 0
fi
