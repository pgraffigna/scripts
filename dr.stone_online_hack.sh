#!/bin/bash
# script para ver DR-STONE en linea y a demanda

# Menu para ver online o descargar
read -p "Escribe el numero de capitulo que queres ver: " CAPITULO

CAP=$(curl -s -k https://www5.jkanime.video/dr-stone/"$CAPITULO"/ | grep 'load-video' | awk '{print $3}' | awk -F\" '{print "https:"$2}')

# testear con mpv + fullscreen
# necesita reproductor que acepte https

# testear con otra seria como onepiece
#curl -s -k https://www5.jkanime.video/one-piece/"$CAPITULO"/ | grep 'load-video' | awk '{print $3}' | awk -F\" '{print "https:"$2}'

#mpv --http-header-fields="User-Agent: Mozilla/5.0" "$CAP"

read -p "Escribe el numero de capitulo que queres descargar: " CAPITULO
CAP_DOWN=$(curl -s -k https://www5.jkanime.video/dr-stone/CAPITULO/ | grep 'dwld' | awk '{print $4}' | awk -F\" '{print "https:"$2}')
