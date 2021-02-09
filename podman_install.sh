#!/bin/bash
#programa para instalar PODMAN en WSL2

#Variables
. /etc/os-release

sudo sh -c "echo 'deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/x${NAME}_${VERSION_ID}/ /' | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list"

curl -fsSL https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/x${NAME}_${VERSION_ID}/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/devel_kubic_libcontainers_stable.gpg > /dev/null

sudo apt update && sudo apt install -y podman

sudo mkdir -p /etc/containers && echo -e "[registries.search]\nregistries = ['docker.io', 'quay.io']" | sudo tee /etc/containers/registries.conf

# error
# /run/systemd/journal/socket: sendmsg: no such file or directory"
## editar /etc/containers/containers.conf
## descomentar y cambiar a 'events_logger = "file"'

# testear podman
# podman run -d -p 8081:80 nginx

# https://oldgitops.medium.com/setting-up-podman-on-wsl2-in-windows-10-be2991c2d443
# https://software.opensuse.org/download/package?package=catatonit&project=devel%3Akubic%3Alibcontainers%3Astable
