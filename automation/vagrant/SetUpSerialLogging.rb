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

# Enables serial logging on the requested instances. This can be usefull for checking
# startup errors on the VM itself. WARNING: Heavy performance intensive, only
# user for low-level debugging requirements.
def setUpSerialLogging(vmName)
	if $vmSerialLoggingEnabled
		currentTime = Time.now.strftime("%d-%m-%Y-%H-%M")

		serialLogDirectory =  "generated/vagrant/serial/%s/" % vmName
		serialFile = "%s%s.log" % [serialLogDirectory, currentTime]

		FileUtils.mkdir_p(serialLogDirectory)
		FileUtils.touch(serialFile)
	end
end