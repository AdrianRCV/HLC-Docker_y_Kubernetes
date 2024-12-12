clone_git(){
    mkdir /home/${USUARIO}/app
    cd /home/${USUARIO}/app
    git clone https://github.com/morgadodesarrollador/Autocaravaneando.git
} 

check_clone(){
    if [ ! -d "/home/${USUARIO}/app/Autocaravaneando" ]
    then
        echo "No se ha clonado correctamente Autocaravaneando" >> /root/logs/archivo.log
        return 0
    else 
        echo "Se ha clonado correctamente Autocaravaneando" >> /root/logs/archivo.log
}