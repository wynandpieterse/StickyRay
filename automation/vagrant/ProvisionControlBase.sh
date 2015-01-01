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

echo "Updating package list"

sudo apt-get update > /dev/null 2>&1

echo "Installing dos2unix utility"

sudo apt-get install dos2unix -y > /dev/null 2>&1

echo "Converting files to correct format for Linux"

sudo dos2unix /vagrant/automation/LocalInventory > /dev/null 2>&1
sudo dos2unix /vagrant/automation/vagrant/ProvisionControlFiles.sh > /dev/null 2>&1
sudo dos2unix /vagrant/automation/vagrant/ProvisionControlAnsible.sh > /dev/null 2>&1
sudo dos2unix /vagrant/automation/vagrant/ProvisionControlDocker.sh > /dev/null 2>&1
sudo dos2unix /vagrant/automation/vagrant/ProvisionControlRegistry.sh > /dev/null 2>&1
