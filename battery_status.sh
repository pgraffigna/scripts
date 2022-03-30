#!/bin/bash
#script para monitorear el estado de la bateria

#Colores
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"

#Emojis
BATTERY=$'\U1F50B'
STATS=$'\U1F50C'

#variables
CAPACITY=$(cat /sys/class/power_supply/BAT1/capacity)
STATUS=$(cat /sys/class/power_supply/BAT1/status)

echo -e "$BATTERY ${greenColour}$CAPACITY% \n$STATS $STATUS ${endColour}"

