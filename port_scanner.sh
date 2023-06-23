#!/bin/bash
# variables
puertos=$(seq 1 10000)
clientes=testing

for puerto in ${puertos[@]}; do
	if 2>/dev/null > /dev/tcp/$clientes/$puerto; then
		echo -e "el puerto $puerto esta ABIERTO"
	fi
done
