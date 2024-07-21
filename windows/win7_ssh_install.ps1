# Script para instalar SSH en Windows-7

$url_ssh_32 = "https://github.com/PowerShell/Win32-OpenSSH/releases/download/V8.6.0.0p1-Beta/OpenSSH-Win32.zip"
$url_ssh_64 = "https://github.com/PowerShell/Win32-OpenSSH/releases/download/V8.6.0.0p1-Beta/OpenSSH-Win64.zip"
$url_7z_32 = "http://www.7-zip.org/a/7z1900.msi"
$url_7z_64 = "http://www.7-zip.org/a/7z1900-x64.msi"

$out_ssh_32 = "C:\Temp\OpenSSH-Win32.zip"
$out_ssh_64 = "C:\Temp\OpenSSH-Win64.zip"
$out_7z_32 = "C:\Temp\7z1900.msi"
$out_7z_64 = "C:\Temp\7z1900x64.msi"

$script = "C:\Temp\SSH\install-sshd.ps1"

$arq = Read-Host "Ingresa el tipo de arquitectura de tu equipo, especifica si es 32 o 64"

mkdir C:\Temp
Write-Output ''

switch ($arq) {

    32 {

    Write-Output ''
    Write-Host "[!!] Descargando el instalador de 7zip para windows7-32" -ForegroundColor "yellow"
    certutil.exe -urlcache -split -f $url_7z_32 $out_7z_32 | out-null
    
    Write-Output ''
    Write-Host "[!!] Instalando 7zip para windows7-32" -ForegroundColor "yellow"
    msiexec /i $out_7z_32 /qn /norestart
    sleep 10

    Write-Output ''
    Write-Host "[!!] Descargando el instalador de SSH para windows7-32" -ForegroundColor "yellow"
    certutil.exe -urlcache -split -f $url_ssh_32 $out_ssh_32 | out-null

    Write-Output ''
    Write-Host "[!!] Descomprimiendo el zip de 32 bits" -ForegroundColor "yellow"
    C:\'Program Files'\7-Zip\7z.exe e 'C:\Temp\OpenSSH-Win32.zip' -oC:'\Temp\SSH'

    Write-Output ''
    Write-Host "[!!] Corriendo el script de 32 bits" -ForegroundColor "yellow"
    .$script
    }
    
    64 {
    Write-Output ''
    Write-Host "[!!] Descargando el instalador para windows7-64" -ForegroundColor "yellow"
    certutil.exe -urlcache -split -f $url_7z_64 $out_7z_64 | out-null
    
    Write-Output ''
    Write-Host "[!!] Instalando 7zip para windows7-64" -ForegroundColor "yellow"
    msiexec /i $out_7z_64 /qn /norestart
    sleep 10
    
    Write-Output ''
    Write-Host "[!!] Descargando el instalador de SSH para windows7-64" -ForegroundColor "yellow"
    certutil.exe -urlcache -split -f $url_ssh_64 $out_ssh_64 | out-null

    Write-Output ''
    Write-Host "[!!] Descomprimiendo el zip de 64 bits" -ForegroundColor "yellow"
    C:\'Program Files'\7-Zip\7z.exe e 'C:\Temp\OpenSSH-Win64.zip' -oC:'\Temp\SSH'

    Write-Output ''
    Write-Host "[!!] Corriendo el script de 64 bits" -ForegroundColor "yellow"
    .$script
    }
}        

Write-Output ''
Write-Host "[**] El servicio se instalo correctamente [**]" -ForegroundColor "green"
