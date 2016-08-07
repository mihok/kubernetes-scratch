#!/bin/bash

set -x;

# Make symlinks so we can access the binaries
ln -s /opt/kubernetes-1.3.0/server/kubernetes/server/bin/kubelet /usr/local/bin/kubelet

# Copy the Upstart script into the machine
cp /vagrant/kubelet.conf /etc/init/kubelet.conf

start kubelet