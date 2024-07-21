# Script para mostrar la contraseña en texto plano de las redes Wifi guardadas en el equipo

Write-Output ''
Write-Host "[!!] Listando las redes wifi" -ForegroundColor "yellow"
netsh wlan show profile

Write-Output ''
Write-Host "[!!] Escribe el nombre de la red a consultar" -ForegroundColor "yellow"
$NOMBRE_RED = Read-Host

$CLAVE_RED = netsh wlan show profile $NOMBRE_RED key=clear | findstr 'Contenido'

Write-Output ''
Write-Host "[!!] La clave de la red" $NOMBRE_RED "es: "$CLAVE_RED.Split()[-1] -ForegroundColor "green"

