#!/usr/bin/env bash
# variables
GO_URL="https://go.dev/dl/go1.20.2.linux-amd64.tar.gz"
GO_TAR_GZ="go1.20.2.linux-amd64.tar.gz"
USER_PROFILE="/home/vagrant/.profile"

# handler
function check_go {
    go version
}
trap check_go EXIT

# descargar go
wget -q --show-progress --progress=bar:force 2>&1 "${GO_URL}"

# extraer binario
sudo tar -xzf "${GO_TAR_GZ}" -C /usr/local/

# agregando go al path
echo "PATH=$PATH:/usr/local/go/bin" >> "$USER_PROFILE" && source "$USER_PROFILE"
