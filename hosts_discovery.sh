#!/bin/bash
hosts=("192.168.0" "192.168.1")

for host in ${hosts[@]}; do
	echo -e "\nBuscando hosts activos en la red $host.0/24\n"
	for i in $(seq 1 254); do
		timeout 1 bash -c "ping -c1 $host.$i" &>/dev/null && echo "el equipo $host.$i esta activo" &
	done; wait
done
