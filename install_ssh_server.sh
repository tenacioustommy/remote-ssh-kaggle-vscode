#!/bin/bash#
# Setup public - private key
mkdir -p /kaggle/working/.ssh
echo $1
FILE=/kaggle/working/.ssh/id_rsa.pub  
if test -f "$FILE"; 
then
    wget $1 -O /kaggle/working/.ssh/temp
    cat /kaggle/working/.ssh/temp >> /kaggle/working/.ssh/id_rsa.pub  
    rm /kaggle/working/.ssh/temp
else
    wget $1 -O /kaggle/working/.ssh/id_rsa.pub
fi

chmod 700 /kaggle/working/.ssh
chmod 600 /kaggle/working/.ssh/id_rsa.pub 

# Install SSH-Server
sudo apt update
sudo apt install openssh-server -y

# SSH Config
sudo echo "PermitRootLogin no" >> /etc/ssh/sshd_config
sudo echo "PasswordAuthentication no" >> /etc/ssh/sshd_config
sudo echo "AuthorizedKeysFile /kaggle/working/.ssh/id_rsa.pub" >> /etc/ssh/sshd_config
sudo echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config

sudo service ssh restart
