#!/bin/bash
set -e

config_nginx(){
    #bash /root/admin/ACVstart.sh
    #nginx -g 'daemon off;'
    nginx &
    #tail -f /dev/null
}

load_entrypoint_base(){
   #ejecutar entrypoint ubbase
   /root/admin/ACVstart.sh
}

main(){
   load_entrypoint_base
   config_nginx
 

#   tail -f /dev/null  
}

main
