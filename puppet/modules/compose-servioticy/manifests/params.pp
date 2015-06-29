class servioticy::params {

    $user = "servioticy"

    $installdir     = "/opt/servioticy"
    $srcdir         = "/usr/src"
    $datadir        = "/data"
    $downloaddir    = "/tmp/servioticy"
    $logdir         = "${installdir}/logs"
    $vagrantdir     = "${installdir}/servioticy-vagrant"

    ## services settings

    $dispatcher_jar = "dispatcher-0.4.3-security-SNAPSHOT-jar-with-dependencies.jar"
    $idm_jar = "COMPOSEIdentityManagement-0.8.0.jar"
    $pdp_jar = "PDPComponentServioticy-0.1.0.jar"
    $uaa_war = "cloudfoundry-identity-uaa-1.11.war"

    $gradle_path = "/usr/lib/gradle/default/bin/"

    $mysql_connector_jar = "mysql-connector-java-5.1.28.jar"

    $mysql_version = "5.5"
    $mysql_root_passwd = "root"

    ####
    # Elastic search settings
    ####

    $es_hash = {
        "ES_USER"     => "elasticsearch",
        "ES_GROUP"    => "elasticsearch",
        "ES_HEAP_SIZE"=> "1g",
        "DATA_DIR"    => "${datadir}/elasticsearch",
        "CONF_FILE"   => "/etc/elasticsearch/serviolastic/elasticsearch.yml"
    }

    $es_config_hash = {
        "cluster.name" => "serviolastic",
        "couchbase.password" => "password",
        "couchbase.username" => "admin",
        "couchbase.maxConcurrentRequests" => "1024",
        "bootstrap.mlockall" => "true",
        "node.name" => "servinode",
        "network.publish_host" => "127.0.0.1",
        "discovery.zen.ping.multicast.enabled" => "false",
        "discovery.zen.ping.unicast.hosts" => "[\"${::ipaddress_eth0}\", \"127.0.0.1\"]"
    }

    # compatible version with couchbase transport plugin (~v2.1) is ES 1.3 - 1.5.2  and CB 2.5 - 3.0

#    $es_transport_pkg = "elasticsearch-transport-couchbase-2.0.0.zip"
    $es_transport_pkg="elasticsearch-transport-couchbase-2.1.1-SNAPSHOT.zip"

    $git_es_transport_url = "https://github.com/couchbaselabs/elasticsearch-transport-couchbase.git"
#    $git_es_transport_revision = "83e588076e0a3df6fa61c0824256e6a00d08a081"
    $git_es_transport_revision = "2.1.1-RC"

    $git_es_capi_url = "https://github.com/couchbaselabs/couchbase-capi-server.git"
#    $git_es_capi_revision = "3cbcfdff4a06e3f080eba3d4d7439f0bab5a834e"
    $git_es_capi_revision = "master"

#    $es_version="1.3.4"
    $es_version="1.5.2" 
    $es_url = "https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-${es_version}.deb"


    ####
    # Couchbase
    ####

    $couchbase_deb = "couchbase-server-enterprise_3.0.0-ubuntu12.04_amd64.deb"
    $couchbase_url = "http://packages.couchbase.com/releases/3.0.0/${$couchbase_deb}"
    
    ####
    # Storm
    ####

#    $storm_version = "0.9.2"
#    $storm_url = "http://www.eu.apache.org/dist/storm/apache-storm-0.9.2-incubating/apache-storm-0.9.2-incubating.tar.gz"

    $storm_version = "0.9.4"
    $storm_url = "http://www.eu.apache.org/dist/storm/apache-storm-${storm_version}/apache-storm-${storm_version}.tar.gz"

    ####
    # Kestrel
    ####

    $kestrel_version = "2.4.1"
    $kestrel_url = "http://twitter.github.io/kestrel/download/kestrel-${kestrel_version}.zip"

    ####
    # Apollo
    ####

    $apollo_version = "1.7.1"
    $apollo_src = "http://mirror.nohup.it/apache/activemq/activemq-apollo/${apollo_version}/apache-apollo-${apollo_version}-unix-distro.tar.gz"

    ####
    # Jetty
    ####

    $jetty_version = "9.3.0.v20150612"
    $jetty_user = "jetty"
    $jetty_host = "0.0.0.0"
    $jetty_port = "8070"

    $jetty_dir = "${installdir}/jetty-distribution-${jetty_version}"
    $jetty_url = "http://download.eclipse.org/jetty/stable-9/dist/jetty-distribution-${jetty_version}.tar.gz"

    ####
    # Git repositories
    ####

#    $git_servioticy_url = "https://github.com/servioticy/servioticy.git"
    $git_servioticy_url = "https://github.com/muka/servioticy.git"
    $git_servioticy_revision = "security"

    $git_rhinomod_src = "https://github.com/WolframG/Rhino-Prov-Mod.git"
    $git_rhinomod_revision = "master"

#    $git_vagrant_src = "https://github.com/servioticy/servioticy-vagrant.git"
    $git_vagrant_src = "https://github.com/muka/servioticy-vagrant.git"
    $git_vagrant_revision = "security"

#    $git_bridge_src = "https://github.com/servioticy/servioticy-brokers.git"
    $git_bridge_src = "https://github.com/muka/servioticy-brokers.git"
    $git_bridge_revision = "master"

    $git_composer_url = "https://github.com/servioticy/servioticy-composer.git"
    $git_composer_revision = "vagrant"

    $git_esindices_url = "https://github.com/servioticy/servioticy-elasticsearch-indices.git"
    $git_esindices_revision = "master"

#    $git_idm_url = "https://github.com/nopobyte/compose-idm"
    $git_idm_url = "https://github.com/muka/compose-idm"
    $git_idm_revision = "master"

    $git_pdp_url = "https://github.com/nopbyte/servioticy-pdp"
    $git_pdp_revision = "master"

    $git_servicemgm_url = "https://github.com/muka/servioticy-mgr.git"
    $git_servicemgm_revision = "security"

    $git_uaa_url = "https://github.com/cloudfoundry/uaa.git"
    $git_uaa_revision = "9156eed2dcc13d8aa1198523d5ce3876e3fe61d7"

}
