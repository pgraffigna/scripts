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
FIN="\033[0m\e[0m"

# Ctrl-C
trap ctrl_c INT
function ctrl_c(){
    echo -e "\n${ROJO}=== Programa Terminado por el usuario ===${FIN}"
    exit 0
}

clear

if [[ ! -n $1 ]];
then
    echo -e "${AMARILLO}=== Modo de uso: $0 https://example.com ===${FIN}"
	exit 0
fi

# comprobación si la URL contiene un "/" al final, y en caso de tenerlo lo quitamos
if [[ "${1: -1}" == "/" ]]; then
    URL="${1%/*}"
else
    URL=$1
fi

sleep 1

echo -e "${AMARILLO}=== Buscando usuarios en $URL ===${FIN}"
if ! [ "$(command -v jq)" ]; then
    sudo apt-get update && sudo apt-get install -y jq
fi

echo -e "${AMARILLO}=== Usuarios encontrados: ===${FIN}"
echo -e "${VERDE}$(curl -s "$URL/wp-json/wp/v2/users" | jq -r '.[].slug')${FIN}"

sleep 1

echo -e "\n${AMARILLO}=== Buscando archivos expuestos en $URL ===${FIN}"
PALABRA=("wp-login.php" "xmlrcp.php" "feed" "cron.php" "wp-admin.php" "wp-activate.php" "wp-config.php" "readme.html" "sitemap.xml")

for PALABRAS in "${PALABRA[@]}"; do
    RESPUESTA=$(curl -s -o /dev/null -w "%{http_code}" "$URL/$PALABRAS")
    if [ $RESPUESTA -eq 200 ]; then
        echo -e "${VERDE}/$PALABRAS encontrado!${FIN}"
    else
        echo -e "${ROJO}/$PALABRAS no encontrado!${FIN}"
    fi
sleep 1
done

echo -e "\n${AMARILLO}=== Buscando version de wordpress en $URL ===${FIN}"
echo -e "${VERDE}version: $(curl -s $URL | grep '<meta name="generator" content=' | awk '{print $(NF-1)}' | tr -d \")${FIN}"

sleep 1
echo -e "\n${AMARILLO}=== Buscando plugins de wordpress instalados en $URL ===${FIN}"
echo -e "${VERDE}plugins: $(curl -s -X GET $URL/support/article/pages/ | grep -E 'wp-content/plugins/' | sed -E 's,href=|src=,THIIIIS,g' | awk -F "THIIIIS" '{print $2}' | cut -d "'" -f2)${FIN}"

sleep 1
echo -e "\n${AMARILLO}=== Buscando temas de wordpress en $URL ===${FIN}"
echo -e "${VERDE}temas: $(curl -s -X GET $URL/support/article/pages/ | grep -E 'wp-content/themes' | sed -E 's,href=|src=,THIIIIS,g' | awk -F "THIIIIS" '{print $2}' | cut -d "'" -f2)${FIN}"

sleep 1
echo -e "\n${VERDE}=== Scan Terminado ===${FIN}"

