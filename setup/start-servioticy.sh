
source /vagrant/config.sh

v=/vagrant

cd $v

if [! -f $v/servioticy ]; then;

	echo "Cannot find servioticy directory. Checking out sources"
	
	mkdir $v/servioticy
	cd $v/servioticy

	git clone https://github.com/servioticy/servioticy-api-commons.git
	git clone https://github.com/servioticy/servioticy-api-private.git
	git clone https://github.com/servioticy/servioticy-api-public.git
	git clone https://github.com/servioticy/servioticy-datamodel.git
	git clone https://github.com/servioticy/servioticy-dispatcher.git
	git clone https://github.com/servioticy/servioticy-queue-client.git
	git clone https://github.com/servioticy/servioticy-rest-client.git

fi;

if [ ! -f $WAR_public ]; then

    echo "Packaging and deploy public api"
    echo "--------------------------------------------------------"

    cd $servioticy_api_public
    mvn package

fi;

if [ ! -f $WAR_private ]; then

    echo "Packaging and deploy private api"
    echo "--------------------------------------------------------"

    cd $servioticy_api_private
    mvn package

fi;


if [ ! -f "$JETTY/root.war" ]; then
    ln -s $WAR_public $JETTY/webapps/root.war
fi;

if [ ! -f "$JETTY/private.war" ]; then
    ln -s $WAR_private $JETTY/webapps/private.war
fi;
