#!/bin/bash
set -e

config_git(){
   # Descarga el proyecto via Git en /home/${USUARIO}/app
   mkdir -p /home/${USUARIO}/app
   cd /home/${USUARIO}/app
   git clone ${GITHUB}
   echo "Proyecto ${PROYECTO} clonado..." >> /root/logs/next.log
}

config_next(){
   cd /home/${USUARIO}/app/PokeAPINext/nextasir
   echo "Dentro de ${PROYECTO}..." >> /root/logs/next.log

   # Verifica si las dependencias de Next.js ya están instaladas
   if [ ! -d "node_modules" ]; then
      # Instalar dependencias
      npm install
      if [ $? -ne 0 ]; then
         echo "Error al instalar dependencias. Abortando." >> /root/logs/next.log
         exit 1
      fi
      echo "Dependencias instaladas..." >> /root/logs/next.log
   fi

   # Construir la aplicación Next.js (solo en producción)
   if [ "$NODE_ENV" = "production" ]; then
      echo "Construyendo la aplicación Next.js para producción..." >> /root/logs/next.log
      npm run build
      if [ $? -ne 0 ]; then
         echo "Error al construir la aplicación." >> /root/logs/next.log
         exit 1
      fi
      echo "Build de Next.js completado." >> /root/logs/next.log
   fi

   # Iniciar la aplicación Next.js
   if [ "$NODE_ENV" = "production" ]; then
      echo "Iniciando la aplicación Next.js en modo producción..." >> /root/logs/next.log
      npm run start &
   else
      echo "Iniciando la aplicación Next.js en modo desarrollo..." >> /root/logs/next.log
      npm run dev &
   fi

   if [ $? -ne 0 ]; then
      echo "Error al iniciar la aplicación. Abortando." >> /root/logs/next.log
      exit 1
   fi

   
}

load_entrypoint_nginx(){
   # Ejecutar entrypoint de Nginx (si es necesario)
   /root/admin/start.sh
}

main(){
   touch /root/logs/next.log
   #load_entrypoint_nginx
   config_git
   config_next

   # Mantener el contenedor en ejecución
   tail -f /dev/null
}

main