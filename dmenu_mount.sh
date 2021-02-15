#!/bin/bash
#script para montar USBs via dmenu

#Colores
greenColour="\e[0;32m\033[1m"
purpleColour="\e[0;35m\033[1m"
endColour="\033[0m\e[0m"

trap ctrl_c INT
function ctrl_c(){
        echo -e "\n${redColour}Programa Terminado ${endColour}"
        exit 0
}

#Dependencias
read -p "$(echo -e ${purpleColour}Necesitas tener instalado libnotify-bin y dmenu para usar el programa..si queres instalarlo escribi..SI..sino dale al ENTER: ${endColour})" SI 
case "$SI" in
    [sS] | [sS][iI])
    sudo apt update && sudo apt install -y libnotify-bin dmenu
    ;;
    *)
    echo -e "${greenColour}No hace falta instalar los programas ${endColour}"
    ;;
esac

DISCOS=$(lsblk -lp | grep 'part $' | awk '{print $1, "(" $4 ")"}')
[ -z "$DISCOS" ] && exit 1

D_ELEGIDO=$(echo "$DISCOS" | dmenu -i -p "Que disco USB queres montar?" | awk '{print $1}')
[ -z "$D_ELEGIDO" ] && exit 1

CARPETAS=$(find /mnt /media /tmp -type d -maxdepth 2 2>/dev/null)

P_MONTAJE=$(echo "$CARPETAS" | dmenu -i -p "Elegi el punto de montaje")

if [ ! -d "$P_MONTAJE" ]; then
	CREAR_CARP=$(echo -e "si\nno" | dmenu -i -p "$P_MONTAJE no existe..lo creamos?")
	[ "$CREAR_CARP" = si ] && sudo mkdir -p "$P_MONTAJE"
else
	[ "$CREAR_CARP" = no ] && exit 0
fi

sudo mount $D_ELEGIDO $P_MONTAJE && notify-send "El disco $D_ELEGIDO fue montado en $P_MONTAJE"
lsblk -f