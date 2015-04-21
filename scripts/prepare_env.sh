
echo "" > puppet-provision.log

. /etc/lsb-release

release="puppetlabs-release-$DISTRIB_CODENAME.deb"

if [ ! -e "./$release" ]; then

    echo "Installing puppet..."
    wget "https://apt.puppetlabs.com/$release"
    sudo dpkg -i "$release"

    sudo apt-get update -qq
    sudo apt-get install puppet -yqq

fi
