#!/bin/bash

set -x;

# Make symlinks so we can access the binaries
ln -s /opt/kubernetes-1.3.0/server/kubernetes/server/bin/kube-apiserver /usr/local/bin/kube-apiserver

# Copy the Upstart script into the machine
cp /vagrant/kube-apiserver.conf /etc/init/kube-apiserver.conf

start kube-apiserver