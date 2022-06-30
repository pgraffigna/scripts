#!/bin/bash
# script para descargar audio,video,playlist de Youtube usando youtube-dl

#Colores
greenColour="\e[0;32m\033[1m"
redColour="\e[0;31m\033[1m"
yellowColour="\e[0;33m\033[1m"
blueColour="\e[0;34m\033[1m"
endColour="\033[0m\e[0m"

#Variable Global
AUDIO=$'\U1F4FB'
VIDEO=$'\U1F3AC'

#Ctrl-C
trap ctrl_c INT
function ctrl_c(){
        echo -e "\n${redColour}[++]Programa Terminado por el usuario [++]${endColour}"
        exit 0
}

# condicional que chequea que si esta instalada la aplicacion
if [ "$(command -v /usr/local/bin/youtube-dl)" -eq 0  ]; then
echo -e "${greenColour}youtube-dl esta instalado!!!..seguimos ${endColour}"

else
echo -e "${yellowColour}Instalando youtube-dl ${endColour}"
sudo apt update && sudo apt install -y wget
sudo wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl  
sudo chmod a+rx /usr/local/bin/youtube-dl
fi

read -pr "$(echo -e "${yellowColour}"Ingresa MP3 o MP4 según lo que quieras descargar: "${endColour}")" RESPUESTA
case "$RESPUESTA" in
   mp3|MP3|mP3|Mp3)
    read -pr "$(echo -e $AUDIO "${blueColour}"Pega el link del video: "${endColour}")" URL
    youtube-dl -q -x --audio-format mp3 --output "%(title)s.%(ext)s" "$URL"
    ;;
   mp4|MP4|mP4|Mp4)
    read -pr "$(echo -e $VIDEO "${blueColour}"Pega el link del video: "${endColour}")" URL
    youtube-dl -q -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4' --output "%(title)s.%(ext)s" "$URL"
    ;;
  *)
    echo -e "${redColour}Respuesta incorrecta: ${endColour}"
    ;;
esac


