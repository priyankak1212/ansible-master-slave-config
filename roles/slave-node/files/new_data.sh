#!/bin/bash

PASSWORD=p@ssw0rd
ENCRYPTED_PASSWORD=$(openssl passwd -1 ${PASSWORD})
#sudo useradd ansible
sudo useradd -m -p $ENCRYPTED_PASSWORD ansible

SEARCH="PasswordAuthentication no"
REPLACE="PasswordAuthentication yes"
FILEPATH="/etc/ssh/sshd_config"
sudo sed -i "s;$SEARCH;$REPLACE;" $FILEPATH

# Restart the SSH service for change to take effect.
sudo service sshd restart

# Give the ansible user passwordless sudo
echo 'ansible ALL=(ALL) NOPASSWD: ALL' | sudo EDITOR='tee -a' visudo



#SEARCH="PasswordAuthentication no"
#REPLACE="PasswordAuthentication yes"
#FILEPATH="/etc/ssh/sshd_config"
#sudo sed -i "s;$SEARCH;$REPLACE;" $FILEPATH


sudo mkdir  /home/ansible/.ssh
cd /home/ansible/.ssh
chmod 777 .ssh
touch  .ssh/authorized_keys
chmod 700 .ssh/authorized_keys
cat >> /home/ansible/.ssh/authorized_keys <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCeu9ZKD55XShgl2jciXiI0XKAqaETjsHtfryF3mRdAh3wHmGogMZPgXf8N/NjMXNFfhL4oQYj4hg0a83/BH7FbH3vumwVmzaG0/vAOeVszeSYeFSXYF5fuIdDTBYOykgU7lvUbTid3vJLbFT2jJ0S4vlRF1oxOqcW1L/UXJSAHfJ4VZ8qoOBGBvCQbI5hMI2Eg+mpauDeMMGfGBIZQIRGFRS2w+lP8jXKrlcpzN9JYwj3QOkCAR/mUn4IP+J/SIn80yHG9dTemxCvcPpczGViAp3Ae+g37XhYERK+/Un5vArZ7dQLZHr7ansLfrJ5jxPSCdWqAbrBB8XBQjmEwmLTD ansible@ip-172-31-83-146.ec2.internal
EOF
