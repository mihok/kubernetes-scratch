#!/bin/bash

set -x;

# Flannel

cd /opt/

# Download the release
curl -L https://github.com/coreos/flannel/releases/download/v0.5.5/flannel-0.5.5-linux-amd64.tar.gz -o flanneld-0.5.5.tar.gz

# Create the directory the binaries will live in
mkdir /opt/flanneld-0.5.5

# Extract the contents of the release
tar -zxvf flanneld-0.5.5.tar.gz  -C flanneld-0.5.5 --strip-components=1

# Make symlinks so we can access the binaries
ln -s /opt/flanneld-0.5.5/flanneld /usr/local/bin/flanneld

# Copy our Upstart script
cp /vagrant/flanneld.conf /etc/init/flanneld.conf

# Create flannel's logging directory
mkdir /var/log/flannel
chown vagrant:vagrant /var/log/flannel