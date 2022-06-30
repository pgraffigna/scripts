#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
redColour="\e[0;31m\033[1m"
yellowColour="\e[0;33m\033[1m"
endColour="\033[0m\e[0m"

#CTRL-C
trap ctrl_c INT
function ctrl_c(){
        echo -e "\n${redColour}Programa Terminado ${endColour}"
        exit 0
}

echo -e "\n${yellowColour}Instalando dependencias ${endColour}"
sudo apt update; sudo apt install -y xfce4 xfce4-goodies tightvncserver

echo -e "\n${yellowColour}Configurando VNC - La contraseña debe tener entre seis y ocho caracteres de largo ${endColour}"
vncserver

echo -e "\n${yellowColour}Detenemos la instancia para hacer cambios ${endColour}"
vncserver -kill :1

echo -e "\n${yellowColour}Hacemos copia de seguridad del archivo y creamos uno nuevo ${endColour}"
mv ~/.vnc/xstartup ~/.vnc/xstartup.bak && touch ~/.vnc/xstartup

echo -e "\n${yellowColour}Modificamos el archivo ${endColour}"
cat <<EOF >> ~/.vnc/xstartup
#!/bin/bash
xrdb $HOME/.Xresources 
startxfce4 & 
EOF

echo -e "\n${yellowColour}Le damos permiso de ejecución ${endColour}"
chmod +x ~/.vnc/xstartup

echo -e "\n${yellowColour}Iniciamos el servicio ${endColour}"
vncserver

echo -e "\n${yellowColour}Creación de servicio de sistema ${endColour}"
sudo touch /etc/systemd/system/vncserver@.service
sudo tee -a /etc/systemd/system/vncserver@.service > /dev/null  <<EOF

[Unit]
Description=Inicia el servidor TightVNC con el SO
After=syslog.target network.target

[Service]
Type=forking
User=usuario
Group=usuario
WorkingDirectory=/home/usuario

PIDFile=/home/usuario/.vnc/%H:%i.pid
ExecStartPre=-/usr/bin/vncserver -kill :%i > /dev/null 2>&1
ExecStart=/usr/bin/vncserver -depth 24 -geometry 1280x800 :%i
ExecStop=/usr/bin/vncserver -kill :%i

[Install]
WantedBy=multi-user.target
EOF

echo -e "\n${yellowColour}Modificando los datos de nuestro usuario ${endColour}"
read -rp "Ingresa el nombre del usuario local
 >> " USUARIO
sudo sed -i "s/usuario/$USUARIO/g" /etc/systemd/system/vncserver@.service

echo -e "\n${yellowColour}Recargamos y activamos el servicio ${endColour}"
sudo systemctl daemon-reload && sudo systemctl enable vncserver@1.service

echo -e "\n${yellowColour}Detenemos la instancia ${endColour}"
vncserver -kill :1

echo -e "\n${yellowColour}Iniciamos el servicio VNC ${endColour}"
sudo systemctl start vncserver@1

echo -e "\n${greenColour}Todos los procesos terminaron correctamente!!! ${endColour}"

# Para consultar el estado del servicio
# sudo systemctl status vncserver@1

# Tunel local para encriptar la conexión VNC
# Desde el equipo cliente
# ssh -L 5901:127.0.0.1:5901 -C -N -l vagrant 192.168.60.10

# para conectar desde otro equipo usar localhost:5901
