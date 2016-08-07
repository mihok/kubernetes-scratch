#!/bin/bash

set -x;

# Make symlinks so we can access the binaries
ln -s /opt/kubernetes-1.3.0/server/kubernetes/server/bin/kube-scheduler /usr/local/bin/kube-scheduler

# Copy the Upstart script into the machine
cp /vagrant/kube-scheduler.conf /etc/init/kube-scheduler.conf

start kube-scheduler