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

require 'fileutils'

Vagrant.require_version ">= 1.6.0"

$configurationVariables = File.join(File.dirname(__FILE__), "configuration/vagrant/Configuration.rb")
$checkConfigurationVariables = File.join(File.dirname(__FILE__), "automation/vagrant/CheckConfiguration.rb")
$checkCoreOSClusterToken = File.join(File.dirname(__FILE__), "automation/vagrant/CheckCoreOSClusterToken.rb")
$defineCommonVM = File.join(File.dirname(__FILE__), "automation/vagrant/DefineCommonVM.rb")
$defineCoreOSVM = File.join(File.dirname(__FILE__), "automation/vagrant/DefineCoreOSVM.rb")
$defineControlVM = File.join(File.dirname(__FILE__), "automation/vagrant/DefineControlVM.rb")
$setUpSerialLogging = File.join(File.dirname(__FILE__), "automation/vagrant/SetUpSerialLogging.rb")

$coreUserConfiguration = File.join(File.dirname(__FILE__), "generated/coreos/LocalUserData.yml")

require $configurationVariables
require $checkConfigurationVariables
require $checkCoreOSClusterToken

Vagrant.configure("2") do |config|
    eval(IO.read($defineCommonVM), binding)
    eval(IO.read($defineCoreOSVM), binding)
    eval(IO.read($defineControlVM), binding)
end
