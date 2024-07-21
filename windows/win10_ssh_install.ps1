# Script para instalar SSH en Windows-10

Write-Output ''
Write-Host "[!!] Instalando el cliente SSH" -ForegroundColor "yellow"
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0

Write-Output ''
Write-Host "[!!] Instalando el servidor SSH" -ForegroundColor "yellow"
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

Write-Output ''
Write-Host "[!!] Configurando el inicio del servicio" -ForegroundColor "yellow"
Get-Service -Name *ssh* | Set-Service -StartupType Automatic

Write-Output ''
Write-Host "[!!] Iniciando el servicio SSHD" -ForegroundColor "yellow"
Get-Service -Name *ssh* | Start-Service

Write-Output ''
Write-Host "[!!] Creando regla en el firewall" -ForegroundColor "yellow"
New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22

Write-Output ''
Write-Host "[**] El servicio se instalo correctamente [**]" -ForegroundColor "green"

#Get-WindowsCapability -Online | Where-Object -Property Name -Like "OpenSSH*"