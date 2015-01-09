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

# Should the VM provider output debug data about the VM through serial logs.
$vmSerialLoggingEnabled = true

# Should the VM provider build a headed VM.
$vmGUIEnabled = false

# How many cores should each VM have.
$vmCPUCores = 1

# How much MB memory should each VM have.
$vmMemory = 1024

# Which image to use for the control Ubuntu machines.
$controlRequestImagePath = "current"

# On which port do we expose the Docker registry that is running on the Control
# machine.
$controlDockerRegistryPort = 5000

# This value needs to be between 1 and 8. The number of CoreOS machines to spin up.
$coreInstances = 3

# The updated channel to use for CoreOS images.
$coreUpdateChannel = 'stable'

# The CoreOS image version requested.
$coreRequiredImageVersion = ">= 308.0.1"

# The CoreOS image to check for online.
$coreRequestImagePath = "current"

# Should the CoreOS machines expose their internal Docker socket.
$coreExposeDocker = true

# If the above is true, on which port should the Docker server listen for requests.
$coreExposedDockerPort = 2375
