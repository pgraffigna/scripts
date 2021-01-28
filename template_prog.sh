#!/bin/bash
#Colores
greenColour="\e[0;32m\033[1m"
redColour="\e[0;31m\033[1m"
endColour="\033[0m\e[0m"

#CRTL-C
trap ctrl_c INT
function ctrl_c {
        echo -e "\n${redColour}Programa Terminado ${endColour}"
        exit 0
}

SCRIPT=$( basename "$0" )
VERSION="1.0"

function modo_uso {

local texto_uso=(

"Uso: $SCRIPT [opciones]"  
""
"Opciones:"
"  --fecha, -f 	       Muestra la fecha actual"
"  --lista, -l	       Lista de archivos."
"  --help, -h           Muestra la ayuda."
"  --version, -v        Muestra la version del programa."
""
)

    printf "%s\n" "${texto_uso[@]}"
}

while (( $# ))
do
  case "$1" in
    --fecha | -f)
    date
    exit 0
	;;
    --lista | -l)
	ls -l 
    exit 0
	;;
    --help | -h)
	echo -e "${greenColour}Ayuda ${endColour}"
    exit 0
    ;;
    --version | -v)
	echo -e "${greenColour}La version del programa es $VERSION ${endColour}"
    exit 0
    ;;
    *)
    echo "Respuesta incorrecta"
    exit 1 
    ;;
  esac
done

modo_uso
exit 1
