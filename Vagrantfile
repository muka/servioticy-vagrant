# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    # Every Vagrant virtual environment requires a box to build off of.
    config.vm.box = "trusty64"

    # Create a private network, which allows host-only access to the machine
    # using a specific IP.
    config.vm.network :private_network, ip: "192.168.56.101"

    # ensure hostname matches puppet fqdn node
    config.vm.hostname = "servioticy.local"

   config.vm.synced_folder "../../src/servioticy", "/home/vagrant/src", :nfs => true

    config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", 4096 ]
        vb.customize ["modifyvm", :id, "--cpus", 4]
    end

    config.vm.provision :shell, :path => "scripts/prepare_env.sh"

    #puppet config
    config.vm.provision "puppet" do |puppet|
        #puppet.module_path = "puppet/modules"
        puppet.manifests_path = "puppet/manifests/"
        puppet.manifest_file = "site.pp"
        #puppet.options = "--environment dev --graph --graphdir /vagrant/puppet/dependency_graph --logdest /vagrant/puppet-provision.log"
        puppet.options = " --debug --environment development --graph --graphdir /vagrant/puppet/dependency_graph"
    end

end
