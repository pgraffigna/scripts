#!/bin/bash

/usr/bin/rsync -av --ignore-existing /pool/imagenes/ USER@HOST:/home/USER/backup_imagenes
echo "Backup de las imagenes realizado con exito el $(date "+%d/%m/%Y a las %H:%M hs")" | mail -s "notificacion de samba" MAIL1,MAIL2