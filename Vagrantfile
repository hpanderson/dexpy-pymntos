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

  if Vagrant::Util::Platform.windows?
    # You MUST have a ~/.ssh/github_rsa (GitHub specific) SSH key to copy to VM
    if File.exists?(File.join(Dir.home, ".ssh", "github_rsa"))
      # Read local machine's GitHub SSH Key (~/.ssh/github_rsa)
      github_ssh_key = File.read(File.join(Dir.home, ".ssh", "github_rsa"))
      # Copy it to VM as the /home/ubuntu/.ssh/id_rsa key
      config.vm.provision :shell, :inline => "echo 'Windows-specific: Copying local GitHub SSH Key to VM for provisioning...' && mkdir -p /home/ubuntu/.ssh && echo '#{github_ssh_key}' > /home/ubuntu/.ssh/id_rsa && chmod 600 /home/ubuntu/.ssh/id_rsa && chown ubuntu:ubuntu /home/ubuntu/.ssh/id_rsa"
    else
      # Else, throw a Vagrant Error. Cannot successfully startup on Windows without a GitHub SSH Key!
      raise Vagrant::Errors::VagrantError, "\n\nERROR: GitHub SSH Key not found at ~/.ssh/github_rsa (required on Windows).\nYou can generate this key manually OR by installing GitHub for Windows (http://windows.github.com/)\n\n"
    end
  end

  config.ssh.forward_agent = true

  # launch ipython
  config.vm.provision :shell, run: "always", path: "start-jupyter.sh"
end
