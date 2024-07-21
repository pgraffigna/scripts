#Choco
Write-Host "Instalando chocolatey - gestor de paquetes en Windows"
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

Write-Host "Instalando las apps via choco" -ForegroundColor "green"
choco feature enable -n allowGlobalConfirmation
choco install 7zip -r --no-progress
choco install googlechrome --ignore-checksums -r --no-progress
choco install firefox -r --no-progress
choco install openvpn -r --no-progress
