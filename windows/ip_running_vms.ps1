# Script para encontrar la dirección IP de las máquinas virtuales en ejecución (VirtualBox)

Write-Output ''
Write-Host "[!!] Listando VMs corriendo" -ForegroundColor "yellow"
$RUNNING = (C:\"Program Files"\Oracle\VirtualBox\vboxmanage list runningvms | %{ $_.Split(' ')[0]; })
$RUNNING

Write-Output ''
Write-Host "[!!] Escribe el nombre de la VMs a consultar"
$VM_NAME = Read-Host 
$VM = (C:\"Program Files"\Oracle\VirtualBox\vboxmanage list runningvms | findstr $VM_NAME)

Write-Output ''
Write-Host "[!!] Buscando el identificador de la VM" -ForegroundColor "yellow"
$UUID = echo $VM | %{ $_.Split(' ')[1]; }
$UUID = $UUID -replace '[{}]',""
$UUID

Write-Output ''
Write-Host "[!!] Buscando la direccion MAC de la VM" -ForegroundColor "yellow"
$VMINFO = (C:\"Program Files"\Oracle\VirtualBox\vboxmanage showvminfo --details $UUID | findstr "MAC")
$VMINFO -match '^[a-fA-F0-9:]{17}|[a-fA-F0-9]{12}'
$MAC = ($MATCHES[0] -replace '(..)','$1-').trim('-')
$MAC

Write-Output ''
Write-Host "[!!] Listando la direccion IP de la VM" -ForegroundColor "yellow"
$IP = (arp -a | findstr /i $MAC) 
$IP

Write-Output ''
Write-Host "[**] Todos los procesos terminaron correctamente [**]" -ForegroundColor "green"
