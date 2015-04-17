
#if [ ! -e "/vagrant" ]; then;
#	sudo ln -s /vagrant /opt/servioticy-vagrant
#fi;

mkdir -p /vagrant
echo "" > puppet-provision.log

. /etc/lsb-release

release="puppetlabs-release-$DISTRIB_CODENAME.deb"

if [ ! -e "./$release" ]; then
    echo "Installing puppet..."
    wget "https://apt.puppetlabs.com/$release"
    sudo dpkg -i "$release"

    sudo apt-get update -qq
    sudo apt-get install puppet -yqq

    sudo puppet module install puppetlabs-apt
    sudo puppet module install camptocamp-archive
    sudo puppet module install camptocamp-augeas
    sudo puppet module install puppetlabs-concat
    sudo puppet module install elasticsearch-elasticsearch
    #sudo puppet module install adrien-filemapper
    #sudo puppet module install AlexCline-fstab
    sudo puppet module install puppetlabs-git
    sudo puppet module install gini-gradle --ignore-dependencies
    sudo puppet module install puppetlabs-java
    sudo puppet module install maestrodev-jetty
    #sudo puppet module install puppetlabs-lvm
    sudo puppet module install maestrodev-maven
    sudo puppet module install saz-motd
    sudo puppet module install jfryman-nginx
    sudo puppet module install puppetlabs-nodejs
    sudo puppet module install stankevich-python
    sudo puppet module install  puppetlabs-stdlib
    sudo puppet module install puppetlabs-vcsrepo
    sudo puppet module install maestrodev-wget
    sudo puppet module install reidmv-yamlfile

fi