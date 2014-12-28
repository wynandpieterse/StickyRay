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

$enableSerialLogging = false

$virtualBoxGUI = false
$virtualBoxCPUs = 1
$virtualBoxMemory = 1024

$numberOfCoreInstances = 3
$coreUpdateChannel = 'alpha'
$exposeDocker = true
$exposedDockerPort = 2375

if File.exists?('UserData.yml') && ARGV[0].eql?('up')
	require 'open-uri'
	require 'yaml'

	token = open('https://discovery.etcd.io/new').read

	data = YAML.load(IO.readlines('UserData.yml')[1..-1].join)
	data['coreos']['etcd']['discovery'] = token

	yaml = YAML.dump(data)

	File.open('UserData.yml', 'w') { |file| file.write("#{yaml}") }
end
