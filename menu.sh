#!/bin/bash
#Colores
verde="\e[0;32m\033[1m"
rojo="\e[0;31m\033[1m"
end="\033[0m\e[0m"

# variables
nombre_script=$( basename "$0" )

#CRTL-C
trap ctrl_c INT
function ctrl_c {
        echo -e "\n${rojo}Programa Terminado ${end}"
        exit 0
}

function modo_uso {
    printf "Uso $nombre_script\n"
    printf " -l <carpeta>                 Muestra el contenido de la carpeta especificada.\n"
    exit 0
}

while getopts l: opt; do
    case ${opt} in
      l)
        carpeta=${OPTARG}
        ls -l $carpeta
        exit 0
        ;;
      *)
        exit 1
        ;;
    esac
done

# inicio de programa
modo_uso