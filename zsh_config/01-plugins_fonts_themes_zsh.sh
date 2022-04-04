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

echo -e "${verde}Realizando backup de .zshrc en .zshrc-backup ${fin}\n"
cp ~/.zshrc ~/.zshrc-backup

# plugins
echo -e "${amarillo}Instalando Plugins ${fin}\n"
git clone --quiet https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions &>/dev/null
git clone --quiet https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting &>/dev/null
git clone --quiet https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions &>/dev/null

# fuentes
echo -e "${amarillo}Instalando Nerd Fonts ${fin}\n"
wget -q --show-progress -N --progress=bar:force 2>&1 https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf -P ~/.fonts/
wget -q --show-progress -N --progress=bar:force 2>&1 https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/RobotoMono/Regular/complete/Roboto%20Mono%20Nerd%20Font%20Complete.ttf -P ~/.fonts/
wget -q --show-progress -N --progress=bar:force 2>&1 https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete.ttf -P ~/.fonts/
fc-cache -fv ~/.fonts 

# temas
echo -e "${amarillo}Instalando powerlevel10k ${fin}\n"
git clone --quiet https://github.com/romkatv/powerlevel10k ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k &>/dev/null

echo -e "${amarillo}Configurando el tema powerlevel10k ${fin}\n" 
sed -i 's#ZSH_THEME="robbyrussell"#ZSH_THEME="powerlevel10k/powerlevel10k"#' .zshrc

echo -e "${verde}[**] 1 - Configurar la fuente en la terminal [**] ${fin}"
echo -e "${verde}[**] 2 - cerrar/abrir la terminal para terminar de configurar p10k [**] ${fin}"


                
