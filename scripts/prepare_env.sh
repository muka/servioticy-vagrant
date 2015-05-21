
echo "" > puppet-provision.log

. /etc/lsb-release

release="puppetlabs-release-$DISTRIB_CODENAME.deb"

if [ ! -e "./$release" ]; then

    echo "Installing puppet..."
    wget "https://apt.puppetlabs.com/$release"
    sudo dpkg -i "$release"

    sudo apt-get update -qq
    sudo apt-get install puppet -yqq

    sudo puppet module install puppetlabs-apt --version 1.8.0
    sudo puppet module install camptocamp-archive --version 0.5.2
    sudo puppet module install camptocamp-augeas --version 1.2.3
    sudo puppet module install puppetlabs-concat --version 1.2.1
    sudo puppet module install elasticsearch-elasticsearch --version 0.9.5
    sudo puppet module install maestrodev-jetty --version 1.1.2
    sudo puppet module install maestrodev-maven --version 1.4.0
    sudo puppet module install saz-motd --version 2.2.1
    sudo puppet module install jfryman-nginx --version 0.2.6
    sudo puppet module install stankevich-python --version 1.9.4
    sudo puppet module install puppetlabs-stdlib --version 1.0.0
    sudo puppet module install puppetlabs-vcsrepo --version 1.2.0
    sudo puppet module install maestrodev-wget --version  1.6.0
    sudo puppet module install reidmv-yamlfile --version 0.2.0
    sudo puppet module install puppetlabs-nodejs --version 0.8.0

fi

if [ ! -e "/etc/puppet/modules/servioticy" ]
then


  dir=/vagrant
  if [ ! -e "/vagrant" ]
  then
    dir=$PWD
  fi

  sudo ln -s $dir/puppet/modules/compose-servioticy /etc/puppet/modules/servioticy

fi
