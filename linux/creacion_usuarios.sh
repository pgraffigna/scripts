#!/usr/bin/env bash
#
# Autor: Pablo Graffigna
# URL: www.linkedin.com/in/pablo-graffigna
#
set -e

# Colores
ROJO="\e[0;31m\033[1m"
VERDE='\033[0;32m'
FIN='\033[0m'

#CTRL-C
trap ctrl_c INT
function ctrl_c(){
    echo -e "\n${ROJO}Programa Terminado ${FIN}"
    exit 0
}

# variables
USUARIOS=(backups,infra,admins)
GRUPO=recepcion

echo -e "${VERDE}=== Agregando grupos $GRUPO ===${FIN}"
if sudo groupadd "$GRUPO"; then
    for i in "${USUARIOS[@]}"; do
        if /usr/bin/id "$i" >/dev/null 2>&1; then
            echo -e "${ROJO}=== El usuario ya existe!! ===${FIN}"
        else
            echo -e "${VERDE}=== Creando usuario $i y agregándolo al grupo $GRUPO ===${FIN}"
            sudo adduser --force-badname --no-create-home --disabled-login --shell /usr/sbin/nologin --gecos "" "$i"
            sudo usermod -aG "$GRUPO" "$i"
            SAMBA_PASS=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 15 ; echo ' ')
            echo -e "${SAMBA_PASS}\n${SAMBA_PASS}" | sudo smbpasswd -s -a "$i"
            echo "Grupo: $GRUPO || Usuario: $i || Credencial: $SAMBA_PASS" >> samba_pass.txt
        fi
    done
    echo -e "${VERDE}=== Todos los usuarios han sido creados ===${FIN}"
else
    echo -e "${ROJO}=== Error al crear el grupo ===$GRUPO ${FIN}"
fi
