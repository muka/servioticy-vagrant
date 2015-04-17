# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    # Every Vagrant virtual environment requires a box to build off of.
    config.vm.box = "trusty64"

    # required by maven
    # config.ssh.shell = "export JAVA_HOME=/usr/lib/jvm/java-7-oracle"

    # required by couchbase-cli
    # config.ssh.shell = "export LC_ALL=\"en_US.UTF-8\""
    # config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
    #config.vm.provision "shell", path: "provision.sh"

    # Create a private network, which allows host-only access to the machine
    # using a specific IP.
    config.vm.network :private_network, ip: "192.168.56.101"

    config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", 4096 ]
        vb.customize ["modifyvm", :id, "--cpus", 4]
    end

    config.vm.provision :shell, :path => "prepare_env.sh"

    #puppet config
    config.vm.provision "puppet" do |puppet|
        puppet.module_path = "puppet/modules"
        puppet.manifests_path = "puppet/manifests/"
        puppet.manifest_file = "."
        puppet.options = "--environment dev --graph --graphdir /vagrant/puppet/dependency_graph --logdest /vagrant/puppet-provision.log"
    end

end
