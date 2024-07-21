#!/bin/bash
# Colores
VERDE="\e[0;32m\033[1m"
ROJO="\e[0;31m\033[1m"
AMARILLO="\e[0;33m\033[1m"
FIN="\033[0m\e[0m"

# ctrl_c
function ctrl_c(){
    echo -e "\n${ROJO}[HOSTS_DISCOVER] Programa Terminado por el usuario ${FIN}"
    exit 0
}

# handler
trap ctrl_c INT

# variables
subnet=192.168.121.

for ip in $(seq 1 254); do
  ( timeout 1 ping -c1 $subnet$ip > /dev/null && echo "La IP $subnet$ip esta ACTIVA" ) &
done