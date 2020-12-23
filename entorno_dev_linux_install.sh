# Instalación del entorno XFCE4 + el servicio XRDP
sudo apt update
sudo apt install -y -qq xfce4 xfce4-goodies xorg dbus-x11 x11-xserver-utils
sudo apt install -y xrdp
sudo adduser xrdp ssl-cert
sudo adduser $USER ssl-cert
sudo systemctl status xrdp

# Instalación de Powershell
sudo apt update
sudo apt install -y -qq powershell

# Instalación de IDE VSCODE
sudo apt update
sudo apt install -y -qq software-properties-common apt-transport-https wget
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt update
sudo apt install -y -qq code

