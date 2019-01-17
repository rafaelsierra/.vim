#!/bin/bash

#
# Creates a private key to access the container
# The user has a chance to enter a password if so desired
#
printf "Creating access key for user %s, copy it into .ssh/id_rsa-vim\n", $USER
sudo -u $USER ssh-keygen -t rsa -b 2048 -f /home/$USER/.ssh/id_rsa
sudo -u $USER cp /home/$USER/.ssh/id_rsa.pub /home/$USER/.ssh/authorized_keys

#
# Displays the key so the user can copy it without having to rely on
# `docker cp` (might change in the future)
#
cat /home/$USER/.ssh/id_rsa
read -s -p "Press enter to clear screen and continue"
clear

#
# Starts ssh server
#
printf "Starting SSH server...\n"
mkdir -p /run/sshd
/usr/sbin/sshd -D
