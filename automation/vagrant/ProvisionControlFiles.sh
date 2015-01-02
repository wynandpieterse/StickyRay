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
# Version 0.0.5
#

echo "Building system host file"

printf "127.0.0.1 localhost\n" >> /tmp/systemhosts

for (( instance = 1; instance <= $2; instance++ ))
do
	printf "10.10.10.1%i core0%i\n" "$instance" "$instance" >> /tmp/systemhosts
done

echo "Building Ansible configuration file"

cat > /tmp/.ansible.cfg << EOF
[defaults]
host_key_checking = False

[ssh_connection]
ssh_args = -o ControlMaster=auto -o ControlPersist=60s -F /home/vagrant/.ssh.cfg
EOF

echo "Building Ansible SSH configuration file"

for (( instance = 1; instance <= $2; instance++ ))
do
	printf "Host 10.10.10.1%i\n" "$instance" >> /tmp/.ssh.cfg
	printf "   User core\n" >> /tmp/.ssh.cfg
	printf "   UserKnownHostsFile /dev/null\n" >> /tmp/.ssh.cfg
	printf "   StrictHostKeyChecking no\n" >> /tmp/.ssh.cfg
	printf "   PasswordAuthentication no\n" >> /tmp/.ssh.cfg
	printf "   IdentityFile /home/vagrant/.ssh/VagrantPrivateKey\n" >> /tmp/.ssh.cfg
	printf "   IdentitiesOnly yes\n" >> /tmp/.ssh.cfg
	printf "   LogLevel FATAL\n" >> /tmp/.ssh.cfg
	printf "\n" >> /tmp/.ssh.cfg
done

for (( instance = 1; instance <= $2; instance++ ))
do
	printf "Host core0%i\n" "$instance" >> /tmp/.ssh.cfg
	printf "   User core\n" >> /tmp/.ssh.cfg
	printf "   UserKnownHostsFile /dev/null\n" >> /tmp/.ssh.cfg
	printf "   StrictHostKeyChecking no\n" >> /tmp/.ssh.cfg
	printf "   PasswordAuthentication no\n" >> /tmp/.ssh.cfg
	printf "   IdentityFile /home/vagrant/.ssh/VagrantPrivateKey\n" >> /tmp/.ssh.cfg
	printf "   IdentitiesOnly yes\n" >> /tmp/.ssh.cfg
	printf "   LogLevel FATAL\n" >> /tmp/.ssh.cfg
	printf "\n" >> /tmp/.ssh.cfg
done

echo "Building default Ansible host file for local development"

printf "localhost ansible_connection=local\n" >> /tmp/hosts

for (( instance = 1; instance <= $2; instance++ ))
do
	printf "core0%i ansible_connection=ssh ansible_ssh_host=10.10.10.1%i ansible_python_interpreter=\"PATH=/home/core/bin:$PATH python\"\n" "$instance" "$instance" >> /tmp/hosts
done

printf "\n" >> /tmp/hosts

printf "[control]\n" >> /tmp/hosts
printf "localhost\n" >> /tmp/hosts
printf "\n" >> /tmp/hosts

printf "[mainmonitor]\n" >> /tmp/hosts
printf "localhost\n" >> /tmp/hosts
printf "\n" >> /tmp/hosts

printf "[core]\n" >> /tmp/hosts
for (( instance = 1; instance <= $2; instance++ ))
do
	printf "core0%i\n" "$instance" >> /tmp/hosts
done

printf "\n" >> /tmp/hosts

printf "[web]\n" >> /tmp/hosts
for (( instance = 1; instance <= $2; instance++ ))
do
	printf "core0%i\n" "$instance" >> /tmp/hosts
done

printf "\n" >> /tmp/hosts

printf "[database]\n" >> /tmp/hosts
for (( instance = 1; instance <= $2; instance++ ))
do
	printf "core0%i\n" "$instance" >> /tmp/hosts
done

printf "\n" >> /tmp/hosts

printf "[monitor]\n" >> /tmp/hosts
for (( instance = 1; instance <= $2; instance++ ))
do
	printf "core0%i\n" "$instance" >> /tmp/hosts
done

printf "\n" >> /tmp/hosts

echo "Copying built system hosts file"

sudo cp /tmp/systemhosts /etc/hosts

echo "Copying Ansible host file"

sudo mkdir /etc/ansible &>> $1
sudo cp /tmp/hosts /etc/ansible/hosts &>> $1
sudo cp /tmp/hosts /vagrant/automation/inventories/LocalInventory &>> $1
sudo chmod 666 /etc/ansible/hosts &>> $1

echo "Copying over Vagrant private key"

sudo cp /vagrant/automation/vagrant/VagrantPrivateKey /home/vagrant/.ssh/VagrantPrivateKey &>> $1
sudo chmod 400 /home/vagrant/.ssh/VagrantPrivateKey &>> $1
sudo chown vagrant:vagrant /home/vagrant/.ssh/VagrantPrivateKey &>> $1

echo "Copying Ansible configuration files to correct location"

sudo cp /tmp/.ansible.cfg /home/vagrant/.ansible.cfg &>> $1
sudo cp /tmp/.ssh.cfg /home/vagrant/.ssh.cfg &>> $1
