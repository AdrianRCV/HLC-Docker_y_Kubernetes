ACVclone_git(){
    mkdir /home/${USUARIO}/app
    cd /home/${USUARIO}/app
    git clone https://github.com/morgadodesarrollador/Autocaravaneando.git
} 

ACVcheck_clone(){
    if [ ! -d "/home/${USUARIO}/app/Autocaravaneando" ]
    then
        echo "No se ha clonado correctamente Autocaravaneando" >> /root/logs/archivo.log
    else 
        echo "Se ha clonado correctamente Autocaravaneando" >> /root/logs/archivo.log
    fi
}

ACVconfig_react(){
    cd /home/${USUARIO}/app/Autocaravaneando
    if [ ! -d "/home/${USUARIO}/app/Autocaravaneando/node_modules" ]
    then
        echo "node_modules no se encuentra en Autocaravaneando" >> /root/logs/archivo.log
        return 0
    else 
        npm install
        return 1
}

ACVstart() {
    ACVconfig_react
    if [ "$?" -eq 1 ]
    then 
        npm start
    fi
}

ACVconfReact(){
    ACVclone_git
    ACVcheck_clone
    #ACVconfig_react
    #ACVstart
}