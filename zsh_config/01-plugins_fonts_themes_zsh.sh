#!/bin/bash
# script para instalar plugins, temas y fuentes para zsh

# Colores
verde="\e[0;32m\033[1m"
rojo="\e[0;31m\033[1m"
amarillo="\e[0;33m\033[1m"
fin="\033[0m\e[0m"

# Ctrl-C
trap ctrl_c INT
function ctrl_c(){
        echo -e "\n${rojo}Programa Terminado por el usuario ${fin}"
        exit 0
}

# backup .zshrc original
cp -r ~/.zshrc ~/.zshrc-backup
echo -e "${verde}Realizado backup de .zshrc en .zshrc-backup ${fin}\n"

# copiando archivos 
cp ~/zsh_config/p10k.zsh ~/.p10k.zsh
cp ~/zsh_config/zshrc ~/.zshrc

# plugins
git clone --quiet --depth=1 https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions &>/dev/null
git clone --quiet --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting &>/dev/null
git clone --quiet --depth=1 https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions &>/dev/null

# fuentes
echo -e "${amarillo}Instalando Nerd Fonts ${fin}\n"
wget -q --show-progress -N --progress=bar:force 2>&1 https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf -P ~/.fonts/
wget -q --show-progress -N --progress=bar:force 2>&1 https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/RobotoMono/Regular/complete/Roboto%20Mono%20Nerd%20Font%20Complete.ttf -P ~/.fonts/
wget -q --show-progress -N --progress=bar:force 2>&1 https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete.ttf -P ~/.fonts/
fc-cache -fv ~/.fonts 2>/dev/null

# temas
git clone --quiet --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k &>/dev/null

# configurar como default
chsh -s $(which zsh)

echo -e "${verde}[**] Cerrar y Re-Abrir la sesion para que tome los cambios [**] ${fin}"


