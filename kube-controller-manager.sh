#!/bin/bash

set -x;

# Make symlinks so we can access the binaries
ln -s /opt/kubernetes-1.3.0/server/kubernetes/server/bin/kube-controller-manager /usr/local/bin/kube-controller-manager

# Copy the Upstart script into the machine
cp /vagrant/kube-controller-manager.conf /etc/init/kube-controller-manager.conf

start kube-controller-manager