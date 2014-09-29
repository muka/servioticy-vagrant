#!/bin/bash

CWD=/vagrant

source $CWD/config.sh

echo "*******************************************************"
echo "* Initial setup                                       *"
echo "*******************************************************"
$CWD/setup/prepare.sh

echo "*******************************************************"
echo "* Installing Apollo MQ                                *"
echo "*******************************************************"
$CWD/setup/start-apollo.sh

#echo "*******************************************************"
#echo "* Glassfish                                           *"
#echo "*******************************************************"
#$CWD/setup/start-glassfish.sh

echo "*******************************************************"
echo "* Jetty                                               *"
echo "*******************************************************"
$CWD/setup/start-jetty.sh

echo "*******************************************************"
echo "* Couchbase                                           *"
echo "*******************************************************"
$CWD/setup/start-couchbase.sh

echo "*******************************************************"
echo "* Storm & Kestrel                                     *"
echo "*******************************************************"
$CWD/setup/start-storm.sh

echo "*******************************************************"
echo "* Elastic search                                      *"
echo "*******************************************************"
$CWD/setup/start-elasticsearch.sh

echo "*******************************************************"
echo "* Checking sources                                    *"
echo "*******************************************************"
$CWD/setup/checkout-deps.sh

echo "*******************************************************"
echo "* Install mvn deps                                    *"
echo "*******************************************************"
$CWD/setup/install-mvn-deps.sh

echo "*******************************************************"
echo "* Installing Servioticy                               *"
echo "*******************************************************"
$CWD/setup/start-servioticy.sh

