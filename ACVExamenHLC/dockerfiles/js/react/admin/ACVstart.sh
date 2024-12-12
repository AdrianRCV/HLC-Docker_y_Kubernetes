#!/bin/bash
set -e

#source /root/admin/ConfigReact/ACVconfigreact.sh

#chmod +x /root/admin/ConfigReact/ACVconfigreact.sh

ACVclone_git(){
    mkdir /home/ubuntu/app
    cd /home/ubuntu/app
    git clone https://github.com/morgadodesarrollador/Autocaravaneando.git
} 

ACVcheck_clone(){
    if [ ! -d "/home/ubuntu/app/Autocaravaneando" ]
    then
        echo "No se ha clonado correctamente Autocaravaneando" >> /root/logs/archivo.log
        return 1
    else 
        echo "Se ha clonado correctamente Autocaravaneando" >> /root/logs/archivo.log
        return 0
    fi
}

ACVinstallnpm (){
    ACVcheck_clone
    cd /home/ubuntu/app/Autocaravaneando
    if [ "$?" -eq 0 ]
    then
        npm install
        return 0
    fi
}

ACVstartreact (){
    ACVinstallnpm
    if [ "$?" -eq 0 ]
    then 
        npm start
        return 0
    fi
}

ACVbuild () {
    ACVstartreact
    if [ "$?" -eq 0 ]
    then 
        npm run build
        return 0
    fi
}

ACVcopy () {
    ACVbuild
    if [ "$?" -eq 0 ]
    then
        cp -r /home/ubuntu/app/Autocaravaneando/build/* /var/www/html
        echo "Se ha copiado el build" >> /root/logs/archivo.log
        return 0
    fi
}

ACVpermisos() {
    ACVcopy
    if [ "$?" -eq 0 ]
    then 
        chown -R www-data:www-data /var/www/html
        chmod -R 755 /var/www/html
    fi
}

main(){
    ACVclone_git
    ACVcheck_clone
    ACVinstallnpm
    ACVstartreact
    ACVbuild
    ACVcopy
    ACVpermisos
    #ACVconfReact
    #nginx &
    tail -f /dev/null
}

main
