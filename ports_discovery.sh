#!/bin/bash
hosts=("192.168.0.1" "192.168.1.1")

for host in "${hosts[@]}"; do
	echo -e "\nEnumerando los puertos de estos hosts: $host\n"
	for port in $(seq 1 10000); do
		timeout 1 bash -c "echo '' >/dev/tcp/$host/$port" 2>/dev/null && echo "el puerto $port esta abierto" &
	done; wait
done
