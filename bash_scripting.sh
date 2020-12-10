#!/bin/bash
# notas sobre bash scripting

# Operaciones con archivos --> ejemplo [ -e /etc/passwd ]
-d ARCHIVO  # True si ARCHIVO es un directorio
-e ARCHIVO  # True si ARCHIVO existe
-f ARCHIVO  # True si ARCHIVO existe y es un archivo regular
-r ARCHIVO  # True si ARCHIVO existe y es solo lectura
-s ARCHIVO  # True si ARCHIVO existe y no esta vacio
-w ARCHIVO  # True si ARCHIVO existe y tiene permiso de escritura
-x ARCHIVO  # True si ARCHIVO existe y es ejecutable

# Operaciones con Strings
-z STRING  # True si STRING esta vacia
-n STRING  # True si STRING no esta vacia

# Operaciones aritméticas
var1 -eq var2  # True si var1 es igual var2
var1 -ne var2  # True si var1 no es igual var2
var1 -lt var2  # True si var1 es menor que var2
var1 -le var2  # True si var1 es menor o igual a var2
var1 -gt var2  # True si var1 es mayor que var2
var1 -ge var2  # True si var1 es mayor o igual var2

# Case Statements
#!/bin/bash
read -p "Ingrese su respuesta S/N: " RESPUESTA
case "$RESPUESTA" in
  [sS] | [sS][iI])
    echo "La respuesta es SI:)"
    ;;
  [nN] | [nN][oO])
    echo "La respuesta es No:("
    ;;
  *)
    echo "Respuesta incorrecta:/"
    ;;
esac

# FOR
#!/bin/bash
COLORES="red green blue"
for COLOR in $COLORES
do
  echo "El color es: ${COLOR}"
done

# While
#!/bin/bash
LINEA=1
while read LINEA_ACTUAL
do
  echo "${LINEA}: $LINEA_ACTUAL"
  ((LINEA++))
done < /etc/passwd

# Positional Parameters
  $0 -- "script.sh"
  $1 -- "param1"
  $2 -- "param2"
  $3 -- "param3"
  $4 -- "param4"
  $@ -- array of all positional parameters

# funciones
#!/bin/bash
function miFuncion () {
    echo "Hello World!"
}
miFuncion

---
#!/bin/bash
function saludo() {
  for NOMBRE in $@
  do
    echo "Hola ${NOMBRE}"
  done
}

# Debugging
#!/bin/bash -x
Muestra los comandos paso a paso

#! /bin/bash -e 
Si hay error termina la ejecucion del script

#!/bin/bash -v
Modo Verbose
