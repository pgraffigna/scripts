#!/bin/bash
# script para instalar zsh

# Colores
verde="\e[0;32m\033[1m"
rojo="\e[0;31m\033[1m"
amarillo="\e[0;33m\033[1m"
fin="\033[0m\e[0m"

# Ctrl-C
trap ctrl_c INT
function ctrl_c(){
        echo -e "\n${rojo}Programa Terminado por el usuario ${fin}"
        exit 0
}

declare -a desp=(zsh git wget)

# validando dependencias 
sudo apt update
for i in ${desp[@]}
do
        command -v $i &>/dev/null
                if [ $? == 0 ]; then 
                echo -e $i "${verde}esta instalado!!!${fin}\n"
                else
                sudo apt install -y $i 
                echo -e "${amarillo}Dependencias instaladas ${fin}\n"
                fi
done

# instalando oh-my-zsh
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O - 2>/dev/null)"


