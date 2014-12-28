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
# Version 0.0.2
#

require 'fileutils'

Vagrant.require_version ">= 1.6.0"

$coreUserConfiguration = File.join(File.dirname(__FILE__), "userdata.yml")
$configurationVariables = File.join(File.dirname(__FILE__), "vagrantconfiguration.rb")

if File.exist?($configurationVariables)
	require $configurationVariables
end

Vagrant.configure("2") do |config|
	config.ssh.insert_key = true

	(1..$numberOfCoreInstances).each do |instanceID|
		config.vm.define vmName = "core-%02d" % instanceID do |core|
			core.vm.hostname = vmName
			core.vm.box = "coreos-%s" % $coreUpdateChannel
			core.vm.box_version = ">= 308.0.1"
			core.vm.network :private_network, ip: "10.10.10.#{instanceID + 9}"

			core.vm.provider :virtualbox do |vb, override|
				override.vm.box_url = "http://%s.release.core-os.net/amd64-usr/current/coreos_production_vagrant.json" % $coreUpdateChannel
			end

			core.vm.provider :vmware_fusion do |vb, override|
				override.vm.box_url = "http://%s.release.core-os.net/amd64-usr/current/coreos_production_vagrant_vmware_fusion.json" % $coreUpdateChannel
			end

			core.vm.provider :virtualbox do |v|
				v.check_guest_additions = false
				v.functional_vboxsf     = false
			end

			if Vagrant.has_plugin?("vagrant-vbguest") then
				core.vbguest.auto_update = false
			end

			if $exposeDocker
				core.vm.network "forwarded_port", guest: 2375, host: ($exposedDockerPort + instanceID - 1), auto_correct: true
			end

			if File.exists?($coreUserConfiguration)
				core.vm.provision :file, :source => "#{$coreUserConfiguration}", :destination => "/tmp/vagrantfile-user-data"
				core.vm.provision :shell, :inline => "mv /tmp/vagrantfile-user-data /var/lib/coreos-vagrant/", :privileged => true
			end
		end
	end
end
