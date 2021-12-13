#!/bin/bash
#script para preparar el equipo para realizar backups via MC

#Colores
greenColor="\e[0;32m\033[1m"
redColor="\e[0;31m\033[1m"
yellowColor="\e[0;33m\033[1m"
blueColor="\e[0;34m\033[1m"
purpleColor="\e[0;35m\033[1m"
endColor="\033[0m\e[0m"

trap ctrl_c INT
function ctrl_c(){
        echo -e "\n${redColor}Programa Terminado ${endColor}"
        exit 0
}

C_ORIGEN=$(mktemp -d /tmp/origen.XXXX) || { echo -e "${redColor}Fallo en crear la carpeta origen...saliendo!!! ${endColor}"; exit 1; }
C_DESTINO=$(mktemp -d /tmp/destino.XXXX) || { echo -e "${redColor}Fallo en crear la carpeta destino...saliendo!!${endColor}"; exit 1; }

echo -e "${yellowColor}Chequando que la app Midnight commander esta presente en el equipo ${endColor}"
ls /usr/bin/mc &>/dev/null

if [[ $? == 0 ]]; then
    echo -e "\n${greenColor}mc esta instalado ${endColor}"
else
    echo -e "\n${yellowColor}mc no esta instalado agregando 'UNIVERSE' repo + Instalando Midnight commander ${endColor}"
    sudo add-apt-repository universe &&
        sudo apt update &&
            sudo apt install -y mc
fi

echo -e "\n${yellowColor}Listando discos ${endColor}"
lsblk -f

read -p "$(echo -e ${purpleColor}Elige la partición a montar como origen por ejemplo sdb1: ${endColour})" ORIGEN
sudo mount /dev/$ORIGEN "$C_ORIGEN"

read -p "$(echo -e ${purpleColor}Elige la partición a montar como destino por ejemplo sdc1: ${endColour})" DESTINO
sudo mount /dev/$DESTINO "$C_DESTINO"

echo -e "\n${yellowColor}Mostrando monturas ${endColor}"
mount | tail -n2

echo -e "\n${yellowColor}Espera 10 segundos y ejecuta Midnight commander ${endColor}"
sleep 10; sudo mc

