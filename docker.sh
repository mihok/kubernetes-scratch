#!/bin/bash

# Docker Daemon Options
cp /vagrant/docker.default /etc/default/docker

service docker stop
service docker start