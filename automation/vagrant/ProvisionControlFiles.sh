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

sudo cp /vagrant/automation/vagrant/VagrantPrivateKey /home/vagrant/.ssh/VagrantPrivateKey
sudo chmod 400 /home/vagrant/.ssh/VagrantPrivateKey
sudo chown vagrant:vagrant /home/vagrant/.ssh/VagrantPrivateKey

sudo cp /vagrant/automation/LocalInventory /etc/ansible/hosts
sudo chmod 666 /etc/ansible/hosts

cat > /tmp/.ansible.cfg << EOF
[defaults]
host_key_checking = False

[ssh_connection]
ssh_args = -o ControlMaster=auto -o ControlPersist=60s -F /home/vagrant/.ssh.cfg
EOF

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

sudo cp /tmp/.ansible.cfg /home/vagrant/.ansible.cfg
sudo cp /tmp/.ssh.cfg /home/vagrant/.ssh.cfg
