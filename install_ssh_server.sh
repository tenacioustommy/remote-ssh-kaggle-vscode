#!/bin/bash#
# Setup public - private key
mkdir -p /kaggle/working/.ssh
echo $1
FILE=/kaggle/working/.ssh/authorized_keys
if test -f "$FILE"; 
then
    wget $1 -O /kaggle/working/.ssh/temp
    cat /kaggle/working/.ssh/temp >> /kaggle/working/.ssh/authorized_keys
    rm /kaggle/working/.ssh/temp
else
    wget $1 -O /kaggle/working/.ssh/authorized_keys
fi

chmod 700 /kaggle/working/.ssh
chmod 600 /kaggle/working/.ssh/authorized_keys

# Install SSH-Server
sudo apt update
sudo apt install openssh-server -y

# SSH Config
sudo echo "PermitRootLogin no" >> /etc/ssh/sshd_config
sudo echo "PasswordAuthentication no" >> /etc/ssh/sshd_config
sudo echo "AuthorizedKeysFile /kaggle/working/.ssh/authorized_keys" >> /etc/ssh/sshd_config
sudo echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config

sudo service ssh restart
