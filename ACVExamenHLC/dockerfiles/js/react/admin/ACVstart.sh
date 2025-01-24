#!/bin/bash
set -e

config_git(){
   # descarga el proyecto via Git en /home/${USUARIO}/app
   mkdir /home/${USUARIO}/app
   cd /home/${USUARIO}/app
   git clone ${GITHUB}
   echo "Proyecto ${PROYECTO} clonado..." >> /root/logs/archivo.log

}

config_react(){
   cd /home/${USUARIO}/app/PokeAPI-HLC/ReactIAW
   echo "Dentro de ${PROYECTO}..." >> /root/logs/archivo.log
   # Verifica si React con TypeScript ya está inicializado
   if [ ! -d "node_modules" ]; then
      # Ejecutar npm install
      npm install 
      if [ $? -ne 0 ]; then
         echo "Error al instalar dependencias. Abortando." >> /root/logs/archivo.log
         exit 1
      fi
      echo "dependencias instaladas..." >> /root/logs/archivo.log
      # Ejecutar npm start
      npm start &
      if [ $? -ne 0 ]; then
         echo "Error al iniciar la aplicación. Abortando."
         exit 1
      fi
      echo "Iniciando la aplicación en 3000.." >> /root/logs/react.log
   fi
  
   if [ ! -d "build" ]; then
      echo "Construyendo la aplicación React para producción..." >> /root/logs/react.log
      # Ejecutar npm run build
      npm run build 
      # copiamos
      if [ $? -ne 0 ]; then
            echo "Error al construir la aplicación.">> /root/logs/react.log
            exit 1
      fi
      # Mover al html
      cp -r /home/adrian/app/PokeAPI-HLC/ReactIAW/dist/* /var/www/html
      chown -R www-data /var/www/html
      chmod -R 755  /var/www/html
      service nginx restart
      echo "Build movido a /var/www/html... Sirviendo nginx" >> /root/logs/react.log
      echo "Todo completado exitosamente.">> /root/logs/react.log
   fi
}

load_entrypoint_nginx(){
   #ejecutar entrypoint ngin. Invoca a EP de base, configura nginx y lanza nginx &
   /root/admin/ACVstart.sh
}

main(){
   touch /root/logs/react.log
   load_entrypoint_nginx 
   config_git
   config_react

   tail -f /dev/null
}

main