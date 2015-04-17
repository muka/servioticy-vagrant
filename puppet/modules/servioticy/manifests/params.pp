class servioticy::params {

    $user = "servioticy"
    
    ${servioticy::params::installdir}     = "/opt"
    $srcdir         = "/usr/src"
    $datadir        = "/data"
    $downloaddir    = "/tmp/servioticy"
    $logdir         = "${installdir}/logs"
    $vagrantdir     = "${installdir}/servioticy-vagrant"

    $dispatcher_jar = "dispatcher-0.4.3-security-SNAPSHOT-jar-with-dependencies.jar"
    $idm_jar = "COMPOSEIdentityManagement-0.8.0.jar"
    
    $mysql_connector_jar = "mysql-connector-java-5.1.28.jar"
    
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

    $couchbase_url = "http://packages.couchbase.com/releases/3.0.0/couchbase-server-enterprise_3.0.0-ubuntu12.04_amd64.deb"
    $es_url = "https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.3.4.deb"
    
    $storm_version = "0.9.2-incubating"
    $storm_url = "http://www.eu.apache.org/dist/storm/apache-storm-$storm-incubating_version/apache-storm-$storm-incubating_version.tar.gz"

    $kestrel_version = "2.4.1"
    $kestrel_url = "http://twitter.github.io/kestrel/download/kestrel-${kestrel_version}.zip"

    $apollo_src = "http://archive.apache.org/dist/activemq/activemq-apollo/1.7/apache-apollo-1.7-unix-distro.tar.gz"


    $git_servioticy_url = "https://github.com/servioticy/servioticy.git"
    $git_servioticy_revision = "master"

    $git_rhinomod_src = "https://github.com/WolframG/Rhino-Prov-Mod.git"
    $git_rhinomod_revision = "master"

    $git_vagrant_src = "https://github.com/muka/servioticy-vagrant.git"
    $git_vagrant_revision = "refactor"
 
    $git_bridge_src = "https://github.com/servioticy/servioticy-brokers.git"   
    $git_bridge_revision = "master"

    $git_composer_url = "https://github.com/servioticy/servioticy-composer.git"
    $git_composer_revision = "vagrant"

    $git_es_capi_url = "https://github.com/couchbaselabs/couchbase-capi-server.git"
    $git_es_capi_revision = "3cbcfdff4a06e3f080eba3d4d7439f0bab5a834e"

    $git_es_transport_url = "https://github.com/couchbaselabs/elasticsearch-transport-couchbase.git"
    $git_es_transport_revision = "83e588076e0a3df6fa61c0824256e6a00d08a081"
    
    $git_esindices_url = "https://github.com/servioticy/servioticy-elasticsearch-indices.git"
    $git_esindices_revision = "master"
    
    $git_idm_url = "https://github.com/nopobyte/compose-idm"
    $git_idm_revision = "master"
    
    $git_pdp_url = "https://github.com/nopbyte/servioticy-pdp"
    $git_pdp_revision = "master"

    $git_servicemgm_url = "https://github.com/muka/servioticy-mgr.git"
    $git_servicemgm_revision = "master"
    
    $git_uaa_url = "git://github.com/cloudfoundry/uaa.git"
    $git_uaa_revision = "9156eed2dcc13d8aa1198523d5ce3876e3fe61d7"
}