# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

unless Vagrant.has_plugin?("vagrant-puppet-install")
  raise 'vagrant-puppet-install is not installed!'
end


Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "trusty64"
  #config.puppet_install.puppet_version = :latest

  # required by maven
  config.ssh.shell = "export JAVA_HOME=/usr/lib/jvm/java-7-oracle"

  # required by couchbase-cli
  config.ssh.shell = "export LC_ALL=\"en_US.UTF-8\""
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
  #config.vm.provision "shell", path: "provision.sh"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network :private_network, ip: "192.168.56.101"

  config.vm.provider :virtualbox do |vb|
    #vb.gui = true

    vb.customize ["modifyvm", :id, "--memory", 4096 ]
    vb.customize ["modifyvm", :id, "--cpus", 4]

    #unless File.exist?("./datadisk.vdi")
    #  vb.customize ['createhd', '--filename', './datadisk.vdi', '--size', 2 * 1024]
    #  vb.customize ['storageattach', :id, '--storagectl', "SATA Controller", '--port', 1, '--device', 0, '--type', 'hdd', '--medium', './datadisk.vdi' ]
    #end
  end
  
  #config.vm.provision :shell, :inline => "sudo apt-get update && sudo apt-get install puppet -y"
  config.vm.provision :shell, :path => "install_puppet.sh"
  config.vm.provision :shell, :path => "prepare_env.sh"

  #puppet config
  config.vm.provision "puppet" do |puppet|
    puppet.module_path = "puppet/modules"
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file = "."
    puppet.options = "--environment dev --graph --graphdir /vagrant/puppet/dependency_graph"
  end

end
