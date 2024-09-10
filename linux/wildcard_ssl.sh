#!/usr/bin/env bash
#
# Autor: Pablo Graffigna
# URL: www.linkedin.com/in/pablo-graffigna
#
set -e

# Colores
VERDE="\e[0;32m\033[1m"
ROJO="\e[0;31m\033[1m"
FIN="\033[0m\e[0m"

# Ctrl-C
function ctrl_c(){
  echo -e "\n${ROJO}[SSL] Programa Terminado por el usuario ${FIN}"
  exit 0
}

# variables
DOMINIO=$1
WILDCARD="*.$DOMINIO"
CORREO=admins@testing.lab

if [ -z "$1" ]; then
  echo -e "${ROJO}=== Modo de uso: $0 DOMINIO ===${FIN}"
  exit 0
fi

# creando archivos de configuracion
cat << EOF | tee ~/req.cnf > /dev/null
[req]
distinguished_name = req_distinguished_name
x509_extensions = v3_req
prompt = no

[req_distinguished_name]
C = AR
ST = Buenos_Aires
O = sistemas
localityName = recoleta
commonName = $WILDCARD
organizationalUnitName = administradores
emailAddress = $CORREO

[v3_req]
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
#keyUsage = keyEncipherment, dataEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names

[alt_names]
DNS.1=$DOMINIO
DNS.2=*.$DOMINIO
EOF

# generando las llaves
openssl req -x509 -nodes -days 3650 -newkey rsa:2048 \
  -keyout "$DOMINIO.key" -config ~/req.cnf \
  -out "$DOMINIO.crt" -sha256

echo -e "${VERDE}=== Certificados creados ===${FIN}"
