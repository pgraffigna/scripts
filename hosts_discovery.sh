#!/bin/bash

#ctrl_c
trap ctrl_c INT
function ctrl_c(){
    echo -e "\n[HOSTS_DISCOVER] Programa Terminado por el usuario"
    exit 0
}

read -p "Ingresa la red a escaner (ej: 192.168.121.) --> " subnet

for ip in $(seq 1 254); do
  ( timeout 1 ping -c1 ${subnet}${ip} > /dev/null && echo "La IP $subnet$ip esta ACTIVA" ) &
done