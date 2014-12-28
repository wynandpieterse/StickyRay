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
# Version 0.0.3
#
#!/bin/bash

cp /vagrant/VagrantPrivateKey /home/vagrant/.ssh/VagrantPrivateKey
chmod 400 ~/.ssh/VagrantPrivateKey

cat > /home/vagrant/.ansible.cfg << EOF
[defaults]
host_key_checking = False

[ssh_connection]
ssh_args = -o ControlMaster=auto -o ControlPersist=60s -F /home/vagrant/.ssh.cfg
EOF

for (( i = 1; i <= $1; i++ ))
do
	printf 'Host 10.10.10.1%s' '$1' >> /home/vagrant/.ssh.cfg
	printf '   User core' >> /home/vagrant/.ssh.cfg
	printf '   UserKnownHostsFile /dev/null' >> /home/vagrant/.ssh.cfg
	printf '   StrictHostKeyChecking no' >> /home/vagrant/.ssh.cfg
	printf '   PasswordAuthentication no' >> /home/vagrant/.ssh.cfg
	printf '   IdentityFile /home/vagrant/.ssh/VagrantPrivateKey' >> /home/vagrant/.ssh.cfg
	printf '   IdentitiesOnly yes' >> /home/vagrant/.ssh.cfg
	printf '   LogLevel FATAL' >> /home/vagrant/.ssh.cfg
	printf ' ' >> /home/vagrant/.ssh.cfg
done
