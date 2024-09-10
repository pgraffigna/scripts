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
function ctrl_c(){
    echo -e "\n${ROJO}[SSL]=== Programa Terminado por el usuario ===${FIN}"
    exit 0
}

# variables
SITIO=testing.cultura.lab
C=AR #country
ST=Buenos_Aires #state
L=Almagro #locality
O=x-corps #organizationName

echo -e "${AMARILLO}[SSL]=== Creando las llaves ===${FIN}"
sudo openssl req -new -newkey rsa:4096 -nodes \
    -keyout /etc/ssl/private/"$SITIO.key" -out /etc/ssl/private/"$SITIO.csr" \
    -subj "/C=$C/ST=$ST/L=$L/O=$O/CN=$SITIO"

echo -e "${AMARILLO}[SSL]=== Creando los certificados ===${FIN}"
sudo openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 \
    -keyout /etc/ssl/private/"$SITIO.key" -out /etc/ssl/certs/"$SITIO.crt" \
    -subj "/C=$C/ST=$ST/L=$L/O=$O/CN=$SITIO"

echo -e "${VERDE}[SSL]=== Todos los procesos terminaron correctamente!!! ===${FIN}"
