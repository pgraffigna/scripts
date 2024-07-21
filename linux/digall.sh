#!/usr/bin/env bash
# colores
declare -rx FIN='\033[0m'
declare -rx ROJO='\033[0;31m'
declare -rx VERDE='\033[1;32m'
declare -rx AZUL='\033[1;34m'
declare -rx CELESTE='\033[1;36m'

# trap
function ctrl_c(){
  echo -e "\n${ROJO}programa terminado${FIN}"
  exit 0
}
trap ctrl_c INT

if [ -z "$1" ]; then
  echo -e "${ROJO}error: falta dominio a consultar como argumento${FIN}"
else
  echo -e "${AZUL}consulta: (dig +noall +answer '$1' 'registro')...${CELESTE}\n"

  for REGISTRO in SOA NS SPF TXT MX AAAA A; do
    echo -e "${VERDE}consultando el REGISTRO $REGISTRO ..${FIN}${CELESTE}"
    dig +noall +answer "$1" "${REGISTRO}"
    echo -e "${FIN}"
  done
fi
