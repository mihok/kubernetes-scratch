# -*- mode: ruby -*-
# vi: set ft=ruby :

$instances = 3
$instance_name_prefix = "app"

$app_cpus = 1
$app_memory = 1024

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  (1..$instances).each do |i|
    config.vm.define vm_name = "%s-%02d" % [$instance_name_prefix, i] do |config|
      config.vm.hostname = vm_name

      # Set the VM memory and cpu allocations
      config.vm.provider :virtualbox do |vb|
        vb.memory = $app_memory
        vb.cpus = $app_cpus
      end

      # Create a private network, which allows host-only access to the machine
      # using a specific IP.
      ip = "44.0.0.#{i+100}"
      config.vm.network :private_network, ip: ip

      # Section (A) -- etcd

      # First machine gets a new state, and is the first in our cluster list
      state = "new"
      cluster = "app-01=http:\\/\\/44.0.0.101:2380"
      if i > 1
        # All other machines get an existing state since they're set up sequentially
        state = "existing"

        # Add each additional machine to our cluster list
        (2..i).each do |j|
          cluster = "#{cluster},app-0#{j}=http:\\/\\/44.0.0.#{j+100}:2380"
        end
      end

      # The actual vagrant provision call
      config.vm.provision "shell", path: "etcd.sh", name: "etcd", env: {"IP" => ip, "CLUSTER_STATE" => state, "CLUSTER" => cluster}

      # Section (B) -- flannel

      # Provision flannel binaries and services
      config.vm.provision "shell", path: "flanneld.sh", name: "flannel"

      if i == 1
        # Create our flannel configuration in etcd
        config.vm.provision "shell", name: "flannel-config", inline: "etcdctl mkdir /network; etcdctl mk /network/config </vagrant/flanneld.json"
      end

      # Start flannel
      config.vm.provision "shell", name: "flannel", inline: "start flanneld"

      # Add the next node if we aren't the last node
      if $instances > 1 && i < $instances
        config.vm.provision "shell", name: "etcd-add", inline: "etcdctl member add app-0#{i+1} http://44.0.0.#{i+101}:2380"
      end

      # Section (C) -- docker

      config.vm.provision "docker"

      config.vm.provision "shell", name: "docker", path: "docker.sh"
    end
  end
end