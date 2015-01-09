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
# Version 0.1.0
#

require $setUpSerialLogging
require $setUpProvisionLogging
require $setUpCoreOSClusterToken

# Creates and builds the CoreOS cluster for our testing purposes. These machines
# will be controlled by the control VM.
def defineCoreOSVM(core, vmName, instanceID)
	core.vm.hostname = vmName
	core.vm.box = "coreos-%s" % $coreUpdateChannel
	core.vm.box_version = $coreRequiredImageVersion
	core.vm.network :private_network, ip: "10.10.10.#{instanceID + 10}"

	# Select the image to use for our core VM's.
	core.vm.provider :virtualbox do |vb, override|
		override.vm.box_url = "http://%s.release.core-os.net/amd64-usr/%s/coreos_production_vagrant.json" % [$coreUpdateChannel, $coreRequestImagePath]
	end

	core.vm.provider :vmware_fusion do |vb, override|
		override.vm.box_url = "http://%s.release.core-os.net/amd64-usr/%s/coreos_production_vagrant_vmware_fusion.json" % [$coreUpdateChannel, $coreRequestImagePath]
	end

	# Expose the web server port for application access
	core.vm.network "forwarded_port", guest: 80, host: $coreExposeWebPort, auto_correct: true

	# Expose the internal Docker server port if the user chooses for that.
	if $coreExposeDocker
		core.vm.network "forwarded_port", guest: 2375, host: ($coreExposedDockerPort + instanceID - 1), auto_correct: true
	end

	# Enable serial logging if the user requested that.
	setUpSerialLogging vmName

	# Build the location where log files can output their logs.
	logFile = setUpProvisionLogging vmName

	# Provision the machines.
	core.vm.provision :file, :source => setUpCoreOSClusterToken, :destination => "/tmp/vagrantfile-user-data"
	core.vm.provision :shell, :inline => "mv /tmp/vagrantfile-user-data /var/lib/coreos-vagrant/", :privileged => true

	# Disable guest additions as CoreOS has no need for that.
	core.vm.provider :virtualbox do |v|
		v.check_guest_additions = false
		v.functional_vboxsf     = false
	end

	# Disable guest addition update checks.
	if Vagrant.has_plugin?("vagrant-vbguest") then
		core.vbguest.auto_update = false
	end
end
