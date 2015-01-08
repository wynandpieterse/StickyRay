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
# Version 0.0.6
#

config.vm.define "control", primary: true do |control|
	control.vm.hostname = "control"
	control.vm.box = "https://cloud-images.ubuntu.com/vagrant/utopic/20141222/utopic-server-cloudimg-amd64-vagrant-disk1.box"
	control.vm.network :private_network, ip: "10.10.10.10"
	control.vm.network "forwarded_port", guest: 5000, host: 5000

	if $vmSerialLoggingEnabled
		serialLogDirectory = File.join(File.dirname(__FILE__), "generated/vagrant/serial/control/")
		FileUtils.mkdir_p(serialLogDirectory)

		currentTime = Time.now.strftime("%d-%m-%Y-%H-%M")

		serialFile = File.join(serialLogDirectory, "%s.log" % currentTime)
		FileUtils.touch(serialFile)
	end

	$currentTime = Time.now.strftime("%d-%m-%Y-%H-%M")
	$logDirectory = "/vagrant/generated/vagrant/provisioning/"
	$logFile = "%s%s.log" % [$logDirectory, $currentTime]

	control.vm.provision :shell, :path => "automation/vagrant/tasks/ProvisionControlBase.sh", :privileged => false, :args => "%s %s" % [$logFile, $logDirectory]
	control.vm.provision :shell, :path => "automation/vagrant/tasks/ProvisionControlFiles.sh", :privileged => false, :args => "%s %s" % [$logFile, $coreInstances]
	control.vm.provision :shell, :path => "automation/vagrant/tasks/ProvisionControlAnsible.sh", :privileged => false, :args => "%s" % $logFile
	control.vm.provision :shell, :path => "automation/vagrant/tasks/ProvisionControlDocker.sh", :privileged => false, :args => "%s" % $logFile
	control.vm.provision :shell, :path => "automation/vagrant/tasks/ProvisionControlRegistry.sh", :privileged => false, :args => "%s" % $logFile
end
