#!/bin/bash

# Colores
VERDE="\e[0;32m\033[1m"
ROJO="\e[0;31m\033[1m"
AZUL="\e[0;34m\033[1m"
FIN="\033[0m\e[0m"

#Ctrl-C
trap ctrl_c INT
function ctrl_c(){
	echo -e "\n${ROJO}Programa Terminado por el usuario ${FIN}"
	exit 0
}

# validando si el usuario tiene permisos para correr el script
if [ "$(id -u)" -eq 0 ]; then

	# cargando los datos del usuario y el equipo
	read -p "$(echo -e "${AZUL}"Ingresa el nombre del usuario y el password separados por espacio ej:USUARIO PASSWORD "${FIN}")
	>>  " -ra DATOS

		# validando que el array contenga solo 2 elementos
		if [ "${#DATOS[@]}" -ne 2 ]; then
			echo -e "\n${ROJO}Los datos cargados no son suficientes, cargar correctamente ${FIN}"
			exit 0
		else
			grep -E "^${DATOS[0]}" /etc/passwd >/dev/null
			if [ $? -eq 0 ]; then
				echo -e "\n${ROJO}El usuario ${DATOS[0]} ya existe, saliendo del programa!!!${FIN}"
				exit 0
			else
				pass=$(perl -e 'print crypt($ARGV[0], "PASSWORD")' "${DATOS[1]}")
				useradd -s /bin/bash -m -p "$pass" "${DATOS[0]}"

				[ $? -eq 0 ]
				cp -Rfa /home/sistemas/\. /home/"${DATOS[0]}"
				chown -R "${DATOS[0]}"":""${DATOS[0]}" /home/"${DATOS[0]}"/
				echo -e "\n${VERDE}El usuario ${DATOS[0]} fue añadido con exito! ${FIN}"
			fi
		fi
	else
		echo -e "${ROJO}Correr con SUDO!!! ${FIN}"
		exit 0
fi
