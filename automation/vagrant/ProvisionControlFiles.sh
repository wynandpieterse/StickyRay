#!/bin/bash
#
# The MIT License (MIT)
# 
# Copyright (c) 2014 Wynand Pieterse
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# 
# Version 0.0.4
#

echo "Building Ansible configuration file"

cat > /tmp/.ansible.cfg << EOF
[defaults]
host_key_checking = False

[ssh_connection]
ssh_args = -o ControlMaster=auto -o ControlPersist=60s -F /home/vagrant/.ssh.cfg
EOF

echo "Building Ansible SSH configuration file"

cat > /tmp/.ssh.cfg << EOF
Host *
   User core
   UserKnownHostsFile /dev/null
   StrictHostKeyChecking no
   PasswordAuthentication no
   IdentityFile /home/vagrant/.ssh/VagrantPrivateKey
   IdentitiesOnly yes
   LogLevel FATAL

EOF

echo "Copying over Vagrant private key"

sudo cp /vagrant/automation/vagrant/VagrantPrivateKey /home/vagrant/.ssh/VagrantPrivateKey > /dev/null 2>&1
sudo chmod 400 /home/vagrant/.ssh/VagrantPrivateKey > /dev/null 2>&1
sudo chown vagrant:vagrant /home/vagrant/.ssh/VagrantPrivateKey > /dev/null 2>&1

echo "Building default Ansible host file for local development"

sudo mkdir /etc/ansible > /dev/null 2>&1
sudo cp /vagrant/automation/LocalInventory /etc/ansible/hosts > /dev/null 2>&1
sudo chmod 666 /etc/ansible/hosts > /dev/null 2>&1

echo "Copying Ansible configuration files to correct location"

sudo cp /tmp/.ansible.cfg /home/vagrant/.ansible.cfg > /dev/null 2>&1
sudo cp /tmp/.ssh.cfg /home/vagrant/.ssh.cfg > /dev/null 2>&1
