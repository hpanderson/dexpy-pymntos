# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
    v.cpus = 2
  end

  config.vm.box = "ubuntu/xenial64"
  config.vm.synced_folder ".", "/vagrant/dexpy-pymntos"
  config.vm.network :forwarded_port, guest: 8888, host: 8888
  config.vm.provision :shell, inline: "sudo echo \"nameserver 208.67.222.222\" > /etc/resolv.conf"
  config.vm.provision :shell, path: "bootstrap.sh"

  # launch ipython
  config.vm.provision :shell, run: "always", path: "start_jupyter.sh"

end
