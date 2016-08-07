#!/bin/bash

set -x;

# Make symlinks so we can access the binaries
ln -s /opt/kubernetes-1.3.0/server/kubernetes/server/bin/kube-proxy /usr/local/bin/kube-proxy

# Copy the Upstart script into the machine
cp /vagrant/kube-proxy.conf /etc/init/kube-proxy.conf

start kube-proxy