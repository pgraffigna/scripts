#!/bin/bash

FECHA=`date "+%d/%m/%Y"`
FECHA_NOT=`date "+%d/%m/%Y a las %H:%M"`

/sbin/zfs snapshot pool/imagenes@snap-"${FECHA}"
echo "Snapshot realizado con exito el ${FECHA_NOT}" | mail -s "notificacion de samba" MAIL1,MAIL2
