#!/usr/bin/env bash
#colores
VERDE="\e[0;32m\033[1m"
ROJO="\e[0;31m\033[1m"
FIN="\033[0m\e[0m"

#Ctrl-C
function ctrl_c(){
  echo -e "\n${ROJO}[SSL] Programa Terminado por el usuario ${FIN}"
  exit 0
}

# handler
trap ctrl_c INT

# uso de script
DOMINIO=$1
if [ -z "$1" ]; then
  echo "uso: $0 DOMINIO"
  exit
fi

# variables
WILDCARD="*.$DOMINIO"
CORREO=admins@testing.lab

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

echo -e "${VERDE}Certificados creados ${FIN}"
