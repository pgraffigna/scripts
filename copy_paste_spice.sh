#!/bin/bash
# script para habilitar copy-paste en VMs con spice
# ejecutar en la VM

if ! [ "$(command -v spice-vdagent)" ]; then
    sudo apt install -y spice-vdagent
    systemctl restart spice-vdagentd.service && spice-vdagent
else
    echo "El programa ya esta instalado..iniciando"
    spice-vdagent
    exit 0
fi
