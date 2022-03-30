#!/bin/bash
# Script modificado x Pablo Graffigna nov-2020
# version 1

#Colours
greenColour="\e[0;32m\033[1m"
redColour="\e[0;31m\033[1m"
yellowColour="\e[0;33m\033[1m"
blueColour="\e[0;34m\033[1m"
purpleColour="\e[0;35m\033[1m"
endColour="\033[0m\e[0m"

#Ctrl-C
trap ctrl_c INT
function ctrl_c(){
        echo -e "\n${redColour}Programa Terminado por el usuario ${endColour}"
        exit 0
}

# validando si el usuario tiene permisos para correr el script
if [ $(id -u) -eq 0 ]; then

# cargando los datos del usuario y el equipo
read -p "$(echo -e ${blueColour}Ingresa el nombre del usuario y el password separados por espacio ej:USUARIO PASSWORD ${endColour})
 >>  " -ra DATOS

# validando que el array contenga solo 2 elementos
	if [ "${#DATOS[@]}" -ne 2 ]; then
	   	echo -e "\n${redColour}Los datos cargados no son suficientes, cargar correctamente ${endColour}"
        exit 0
	else
		egrep "^${DATOS[0]}" /etc/passwd >/dev/null

		if [ $? -eq 0 ]; then
					echo -e "\n${redColour}El usuario ${DATOS[0]} ya existe, saliendo del programa!!!${endColour}"
					exit 0
		else
       	        	pass=$(perl -e 'print crypt($ARGV[0], "PASSWORD")' "${DATOS[1]}")
                	useradd -s /bin/bash -m -p "$pass" "${DATOS[0]}"

			[ $? -eq 0 ]
      	        	cp -Rfa /home/sistemas/\. /home/"${DATOS[0]}"
			chown -R "${DATOS[0]}"":""${DATOS[0]}" /home/"${DATOS[0]}"/
   			echo -e "\n${greenColour}El usuario ${DATOS[0]} fue añadido con exito! ${endColour}"
		fi
	fi
else
	echo -e "${redColour}Correr con SUDO!!! ${endColour}"
	exit 0
fi
