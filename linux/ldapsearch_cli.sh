#!/usr/bin/env bash
####### script para hacer mas amigable la busqueda via ldapsearch

####### colores
VERDE="\e[0;32m\033[1m"
ROJO="\e[0;31m\033[1m"
AMARILLO="\e[0;33m\033[1m"
FIN="\033[0m\e[0m"

####### Ctrl-C
trap ctrl_c INT
function ctrl_c(){
        echo -e "\n${rojo}Programa Terminado por el usuario ${end}"
        exit 0
}

###### variables
read -p "Ingresa el nombre del servidor ldap: " LDAP_SERVER
read -p "Ingresa el administrador del servidor (Ej: cn=admin,dc=cultura,dc=lab): " LDAP_ADMIN
read -p "Ingresa el DIT del servidor ldap (ej: dc=cultura,dc=lab) " LDAP_DIT
read -s -p "Ingresa el password para el administrador: " LDAP_PASSWORD

function menu(){
    echo -e "${VERDE} 1)listar las unidades organizacionales (ous) ${FIN}"
    echo -e "${VERDE} 2)listar los usuarios (uid) ${FIN}"
    echo -e "${VERDE} 3)listar los usuarios (mail) ${FIN}"
    echo -e "${VERDE} 4)listar los usuarios (passwords) ${FIN}"
    echo -e "${VERDE} 5)listar los grupos (cn) ${FIN}"
    echo -e "${VERDE} 6)listar miembros por grupo ${FIN}"
    echo -e "${VERDE} 7)buscar por usuarios ${FIN}"
    echo -e "${VERDE} 8)cerrar el programa ${FIN}"
    read -p "$(echo -e "\n${AMARILLO}"Ingresa una opcion "${FIN}") >>>  " OPT
}

##### funciones
function listar_ous() {
    ldapsearch -x -D "${LDAP_ADMIN}" -w "${LDAP_PASSWORD}" -H "ldap://${LDAP_SERVER}" -b "${LDAP_DIT}" ou | grep 'ou:'
}

function listar_uid() {
    ldapsearch -x -D "${LDAP_ADMIN}" -w "${LDAP_PASSWORD}" -H "ldap://${LDAP_SERVER}" -b "${LDAP_DIT}" uid | grep 'uid:'
}

function listar_email() {
    ldapsearch -x -D "${LDAP_ADMIN}" -w "${LDAP_PASSWORD}" -H "ldap://${LDAP_SERVER}" -b "${LDAP_DIT}" mail | grep 'mail:'
}

function listar_password() {
    ldapsearch -x -D "${LDAP_ADMIN}" -w ${LDAP_PASSWORD} -H "ldap://${LDAP_SERVER}" -b "${LDAP_DIT}" userPassword | grep -B1 'userPassword:'
}

function listar_grupos() {
    ldapsearch -x -D "${LDAP_ADMIN}" -w ${LDAP_PASSWORD} -H "ldap://${LDAP_SERVER}" -b "${LDAP_DIT}" "(objectClass=groupOfNames)" | grep -E 'dn:'
}

function listar_miembros() {
    ldapsearch -x -D "${LDAP_ADMIN}" -w "${LDAP_PASSWORD}" -H "ldap://${LDAP_SERVER}" -b "${LDAP_DIT}" "(objectClass=groupOfNames)" | grep -B1 'member'
}

function buscar_usuarios() {
    read -p "Ingresa el nombre del usuario a buscar: " USUARIO
    ldapsearch -x -D "${LDAP_ADMIN}" -w ${LDAP_PASSWORD} -H "ldap://${LDAP_SERVER}" -b "${LDAP_DIT}" "(&(uid=${USUARIO})(objectClass=*))"
}

clear
menu # llamada a function menu

while [ "${OPT}" != '' ]; do
    if [ "${OPT}" = '' ]; then
        exit 1;
    else
        case "${OPT}" in
        1) clear; listar_ous; echo; menu
        ;;
        2) clear; listar_uid; echo; menu
        ;;
        3) clear; listar_email; echo; menu
        ;;
        4) clear; listar_password; echo; menu
        ;;
        5) clear; listar_grupos; echo; menu
        ;;
        6) clear; listar_miembros; echo; menu
        ;;
        7) clear; buscar_usuarios; echo; menu
        ;;
        8) clear; exit 0
        ;;
        *) clear; echo -e "Elegi una opcion válida del menu"; menu
        ;;
        esac
    fi
done
