
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
    sudo puppet module install maestrodev-jetty
    sudo puppet module install maestrodev-maven
    sudo puppet module install saz-motd
    sudo puppet module install jfryman-nginx
    sudo puppet module install stankevich-python
    sudo puppet module install puppetlabs-stdlib
    sudo puppet module install puppetlabs-vcsrepo
    sudo puppet module install maestrodev-wget
    sudo puppet module install reidmv-yamlfile

fi

dir=/vagrant
if [ ! -e "/vagrant" ]
then
  dir=$PWD
fi

sudo ln -s $dir/puppet/modules/compose-servioticy /etc/puppet/modules/servioticy
