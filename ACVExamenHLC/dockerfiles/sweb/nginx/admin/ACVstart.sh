#!/bin/bash
set -e

main(){
    #bash /root/admin/ACVstart.sh
    #nginx -g 'daemon off;'
    nginx &
    #tail -f /dev/null
}

main
