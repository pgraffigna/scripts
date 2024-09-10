#!/usr/bin/env bash
#
# Autor: Pablo Graffigna
# URL: www.linkedin.com/in/pablo-graffigna
#
set -e

# Colores
VERDE="\e[0;32m\033[1m"
ROJO="\e[0;31m\033[1m"
AMARILLO="\e[0;33m\033[1m"
AZUL="\e[0;34m\033[1m"
FIN="\033[0m\e[0m"

# variables
TEMP=$(mktemp -d -t tmp.XXXXXXX)

# Traps
trap ctrl_c INT
function ctrl_c(){
    echo -e "\n${ROJO}=== Programa Terminado ===${FIN}"
    exit 0
}
trap cleanup EXIT
function cleanup() {
    rm -rf "$TEMP"
}

echo -e "${VERDE}Sedes: ${FIN} ${AZUL}\n1: alsina465 \n2: alsina1169 \n3: alvear \n4: sanchez \n5: mexico \n6: cnb \n7: garrigos \n8: mnba\n===${FIN}"
read -p "Ingresa la opcion a escanear : " SEDE

case "$SEDE" in
    1 | alsina465 | ALSINA465)
        IP="10.17.16.0/21"
        ;;
    2 | alsina1169 | ALSINA1169)
        IP="10.12.16.0/21"
        ;;
    3 | alvear | ALVEAR)
        IP="10.21.16.0/21"
        ;;
    4 | sanchez | SANCHEZ)
        IP="10.22.16.0/21"
        ;;
    5 | mexico | MEXICO)
        IP="10.14.16.0/21"
        ;;
    6 | cnb | CNB)
        IP="10.15.16.0/21"
        ;;
    7 | garrigos | GARRIGOS)
        IP="10.24.16.0/21"
        ;;
    8 | mnba | MNBA)
        IP="10.16.16.0/21"
        ;;
    *)
        echo -e "${ROJO}=== La sede no existe..volver a ingresar!! ===${FIN}"
        ;;
esac

echo -e "${AMARILLO}=== Descubriendo hosts activos..esto puede demorar unos segundos ===${FIN}"
nmap -sn "${IP}" --min-rate 10000 | grep 'report' | awk '{print $5}' > $TEMP/$SEDE.hosts
nmap -p135 --open --min-rate 5000 -iL $TEMP/$SEDE.hosts | grep 'report' | awk '{print $5}' > $TEMP/$SEDE.windows
echo -e "${AMARILLO}=== Descubriendo WINDOWS en hosts activos..esto tarda un poco ===${FIN}"
cme smb $TEMP/$SEDE.windows
