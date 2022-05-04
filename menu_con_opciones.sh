#!/bin/bash
# Colores
verde="\e[0;32m\033[1m"
rojo="\e[0;31m\033[1m"
amarillo="\e[0;33m\033[1m"
azul="\e[0;34m\033[1m"
end="\033[0m\e[0m"

# variables globales

function ctrl_c(){
    echo -e "${rojo}\n[++] Terminando el programa..\n${end}"
    exit 1
}

# ctrl+c
trap ctrl_c INT

function modo_consultas(){
    echo "la consulta es $1"
}

function modo_interactivo(){
    while [ "$comando" != "exit" ]; do # controla el flujo del programa
        echo -ne "${verde}[~] >>> ${end}" && read -r comando
    done    
}

function panel_de_ayuda(){
    echo -e "${amarillo}\n[++] panel de ayuda${end}"
    echo -e "\t ${rojo}q) modo consultas ${end}${azul} ej: sqli.sh -q \"'union select\"${end}"
    echo -e "\t ${rojo}i) modo interactivo ${end}"
    echo -e "\t ${rojo}h) ayuda ${end}\n"
    exit 1
}

declare -i contador=0

while getopts "q:ih" arg; do # los dos puntos es porque la opcion requiere argumentos
    case $arg in
        q) consulta=$OPTARG; let contador+=1;; # en la variable "consulta" se guarda el argumento
        i) let contador+=2;;
        h) panel_de_ayuda;;
    esac    
done    

if [ $contador -eq 1 ]; then
    modo_consultas "$consulta"
elif [ $contador -eq 2 ]; then
    modo_interactivo
else
    panel_de_ayuda    
fi