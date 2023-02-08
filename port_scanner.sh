#!/bin/bash

puertos=$(seq 1 10000)
read -p "Ingresa la ip del equipo a escanear --> " clientes

for puerto in ${puertos[@]}; do
	if 2>/dev/null > /dev/tcp/$clientes/$puerto; then
	     echo -e "el puerto $puerto esta ABIERTO"
	fi
done
