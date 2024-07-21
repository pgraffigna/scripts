#!/usr/bin/env bash
# colores
VERDE="\e[0;32m\033[1m"
ROJO="\e[0;31m\033[1m"
AMARILLO="\e[0;33m\033[1m"
FIN="\033[0m\e[0m"

# Ctrl-C
function ctrl_c(){
    echo -e "\n${ROJO}[SSL] Programa Terminado por el usuario ${FIN}"
    exit 0
}

# handler
trap ctrl_c INT

# variables
SITIO=testing.cultura.lab
C=AR #country
ST=Buenos_Aires #state
L=Almagro #locality
O=x-corps #organizationName

# SSL Certs
echo -e "${AMARILLO}[SSL]Creacion de keys + csr ${FIN}"
sudo openssl req -new -newkey rsa:4096 -nodes \
    -keyout /etc/ssl/private/"$SITIO.key" -out /etc/ssl/private/"$SITIO.csr" \
    -subj "/C=$C/ST=$ST/L=$L/O=$O/CN=$SITIO"

echo -e "${AMARILLO}[SSL]Creacion de certificado ${FIN}"
sudo openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 \
    -keyout /etc/ssl/private/"$SITIO.key" -out /etc/ssl/certs/"$SITIO.crt" \
    -subj "/C=$C/ST=$ST/L=$L/O=$O/CN=$SITIO"

echo -e "${AMARILLO}[SSL]Configurando sitio ${FIN}"
sudo cp /etc/apache2/sites-available/default-ssl.conf /etc/apache2/sites-available/"$SITIO.conf"

sudo sed -i "s|/etc/ssl/certs/ssl-cert-snakeoil.pem|/etc/ssl/certs/$SITIO.crt|" /etc/apache2/sites-available/"$SITIO.conf"
sudo sed -i "s|/etc/ssl/private/ssl-cert-snakeoil.key|/etc/ssl/private/$SITIO.key|" /etc/apache2/sites-available/"$SITIO.conf"

echo -e "${VERDE}[SSL]Todos los procesos terminaron correctamente!!! ${FIN}"
