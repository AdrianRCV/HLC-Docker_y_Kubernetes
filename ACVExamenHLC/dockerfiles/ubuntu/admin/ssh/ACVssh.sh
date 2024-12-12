ACVconfig_ssh(){
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
    sed -i 's/#Port 22/Port 22/' /etc/ssh/sshd_config
    if [ ! -d /home/${USUARIO}/.ssh ]; then
        mkdir /home/${USUARIO}/.ssh
        cat /root/datos/id_rsa.pub >> /home/${USUARIO}/.ssh/authorized_keys
    fi
    /etc/init.d/ssh start
}


ACVconfig_sudoers(){
    if [ -f /etc/sudoers ]
    then
        echo "${USUARIO} ALL=(ALL:ALL) ALL" >> /etc/sudoers
    fi
}


ACVnewSSH(){
    ACVconfig_ssh
    ACVconfig_sudoers
}
