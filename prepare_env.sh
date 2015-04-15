
#if [ ! -e "/vagrant" ]; then;
#	sudo ln -s /vagrant /opt/servioticy-vagrant
#fi;

mkdir -p /vagrant
echo "" > puppet-provision.log
