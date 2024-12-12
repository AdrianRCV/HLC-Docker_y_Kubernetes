#!/bin/bash
set -e

source /root/admin/usuarios/ACVusuarios.sh
source /root/admin/ssh/ACVssh.sh

chmod +x /root/admin/usuarios/ACVusuarios.sh
chmod +x /root/admin/ssh/ACVssh.sh

main(){
    newUser
    newSSH
    # /etc/init.d/ssh start &
    exec /usr/sbin/sshd -D &
    #tail -f /dev/null
}

main