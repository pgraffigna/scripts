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
    echo -e "\n${ROJO}=== Programa Terminado por el usuario ===${FIN}"
    exit 0
}

if [ -z "$1" ]; then
  echo -e "${ROJO}=== Modo de uso: $0 DOMINIO ===${FIN}"
else
  for REGISTRO in PTR SOA NS SPF TXT MX AAAA A; do
    echo -e "${VERDE}\n=== Consultando el REGISTRO $REGISTRO de $1 ===${FIN}"
    dig +noall +answer "$1" "${REGISTRO}"
  done

  echo -e "${VERDE}\n=== Consultando el REGISTRO WHOIS de $1 ===${FIN}"
  whois -H -h whois.nic.ar "$1" | grep -v '%'
fi
