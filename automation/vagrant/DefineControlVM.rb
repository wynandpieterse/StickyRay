# 
# The MIT License (MIT)
# 
# Copyright (c) 2015 Wynand Pieterse
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
# Version 0.1.0
#

require $setUpSerialLogging
require $setUpProvisionLogging

# Defines our control VM, the primary VM for all tasks.
def defineControlVM(control, vmName)
	control.vm.hostname = vmName
	control.vm.box = "https://cloud-images.ubuntu.com/vagrant/utopic/%s/utopic-server-cloudimg-amd64-vagrant-disk1.box" % $controlRequestImagePath
	control.vm.network :private_network, ip: "10.10.10.10"

	# Map the project directory to the VM
	control.vm.synced_folder "../", "/application"

	# Forward our Docker registry port to the outside world.
	control.vm.network "forwarded_port", guest: 5000, host: $controlDockerRegistryPort, auto_correct: true

	# Enabled serial logging if the user asked for it.
	setUpSerialLogging vmName

	# Build the log directory where all internal control machines logs will go to.
	logFile = setUpProvisionLogging vmName

	# Provision the machines.
	control.vm.provision :shell, :path => "automation/vagrant/tasks/ProvisionControlBase.sh", :privileged => false, :args => "%s" % logFile
	control.vm.provision :shell, :path => "automation/vagrant/tasks/ProvisionControlFiles.sh", :privileged => false, :args => "%s %s" % [logFile, $coreInstances]
	control.vm.provision :shell, :path => "automation/vagrant/tasks/ProvisionControlAnsible.sh", :privileged => false, :args => "%s" % logFile
	control.vm.provision :shell, :path => "automation/vagrant/tasks/ProvisionControlDocker.sh", :privileged => false, :args => "%s" % logFile
	control.vm.provision :shell, :path => "automation/vagrant/tasks/ProvisionControlRegistry.sh", :privileged => false, :args => "%s" % logFile
end
