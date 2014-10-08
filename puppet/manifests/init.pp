include nodejs, wget, git, apt


file { '/home/vagrant/downloads/':
  ensure => 'directory',
}

file { '/data':
  ensure => 'directory',
}

file { '/data/couchbase':
  ensure => 'directory',
  owner => "couchbase",
  group => "couchbase",
  require => Package['couchbase-server']
}


apt::ppa { 'ppa:webupd8team/java': } ->
exec { 'apt-get update':
  path => '/usr/bin'
}

exec {
    'set-licence-selected':
      command => '/bin/echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections';
 
    'set-licence-seen':
      command => '/bin/echo debconf shared/accepted-oracle-license-v1-1 seen true | /usr/bin/debconf-set-selections';
}


package { ['libssl0.9.8', 'oracle-java7-installer', 'curl']:
  ensure => present,
  require => Exec['apt-get update', 'set-licence-selected', 'set-licence-seen']
}


wget::fetch { "download storm":
  source      => 'http://ftp.cixug.es/apache/incubator/storm/apache-storm-0.9.1-incubating/apache-storm-0.9.1-incubating.tar.gz',
  destination => '/home/vagrant/downloads/apache-storm-0.9.1-incubating.tar.gz',
  timeout     => 0,
  verbose     => false,
}

wget::fetch { "download kestrel":
  source      => 'http://twitter.github.io/kestrel/download/kestrel-2.4.1.zip',
  destination => '/home/vagrant/downloads/kestrel-2.4.1.zip',
  timeout     => 0,
  verbose     => false,
  require     => File['/home/vagrant/downloads/']
}


wget::fetch { "couchbase-server-source":
  source      => 'http://packages.couchbase.com/releases/2.2.0/couchbase-server-enterprise_2.2.0_x86_64_openssl098.deb',
  destination => '/home/vagrant/downloads/couchbase-server-enterprise_2.2.0_x86_64_openssl098.deb',
  timeout     => 0,
  verbose     => false,
  require     => File['/home/vagrant/downloads/']
} ->
package { "couchbase-server":
  provider => dpkg,
  ensure => installed,
  source => "/home/vagrant/downloads/couchbase-server-enterprise_2.2.0_x86_64_openssl098.deb"
} ->
exec { "create_buckets":
    command => "sleep 10 && cd /vagrant/puppet/files; sh create_buckets.sh",
    path    => "/bin:/opt/couchbase/bin/",
    require => Package['couchbase-server']
}

$init_hash = {
  'ES_USER' => 'elasticsearch',
  'ES_GROUP' => 'elasticsearch',
  'ES_HEAP_SIZE' => '2g',
  'DATA_DIR' => '/data/elasticsearch',
}

class { 'elasticsearch':
  package_url => 'https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.0.1.deb',
  #require => Class["java"],
  init_defaults => $init_hash 
}

$config_hash = {
  'cluster.name' => 'serviolastic',
  'couchbase.password' => 'password',
  'couchbase.username' => 'admin',
  'bootstrap.mlockall' => 'true',
  'node.name' => 'servinode',
  'network.publish_host' => '127.0.0.1'
}

elasticsearch::instance { 'serviolastic':
  config => $config_hash,
  datadir => '/data/elasticsearch'
} ->
vcsrepo { "/home/vagrant/servioticy-indices":
  ensure   => latest,
  provider => git,
  owner    => 'vagrant',
  group    => 'vagrant',
  require  => [ Package["git"] ],
  source   => "https://github.com/servioticy/servioticy-elasticsearch-indices.git",
  revision => 'master',
} ->
exec {
    'create-indices':
      command => 'sleep 10 && /bin/sh /home/vagrant/servioticy-indices/create_soupdates.sh; /bin/sh /home/vagrant/servioticy-indices/create_subscriptions.sh',
      path =>  "/usr/local/bin/:/bin/:/usr/bin/"    
} ->
exec {
    'create-xdcr':
      command => '/bin/sh /vagrant/puppet/files/create_xdcr.sh',
      path =>  "/usr/local/bin/:/bin/:/usr/bin/",
      require => Exec['create_buckets']    
}


elasticsearch::plugin{ 'transport-couchbase':
  module_dir => 'transport-couchbase',
  url        => 'http://packages.couchbase.com.s3.amazonaws.com/releases/elastic-search-adapter/1.3.0/elasticsearch-transport-couchbase-1.3.0.zip',
  instances  => 'serviolastic'
}

elasticsearch::plugin{ 'mobz/elasticsearch-head':
  module_dir => 'head',
  instances  => 'serviolastic'
}

vcsrepo { "/usr/src/servioticy":
  ensure   => latest,
  provider => git,
  owner    => 'vagrant',
  group    => 'vagrant',
  require  => [ Package["git"] ],
  source   => "https://github.com/servioticy/servioticy.git",
  revision => 'master',
} ->
class { "maven::maven":
  version => "3.0.5", # version to install
#  require => Class["java"]
} ->
 # Setup a .mavenrc file for the specified user
maven::environment { 'maven-env' : 
    user => 'vagrant',
    # anything to add to MAVEN_OPTS in ~/.mavenrc
    maven_opts => '-Xmx1384m',       # anything to add to MAVEN_OPTS in ~/.mavenrc
    maven_path_additions => "",      # anything to add to the PATH in ~/.mavenrc
} -> 
exec { "build_servioticy":
   cwd     => "/usr/src/servioticy",
   command => "mvn -Dmaven.test.skip=true package",
   path    => "/usr/local/bin/:/usr/bin:/bin/",
   user    => 'vagrant'
} 

file { '/opt/jetty/webapps/private.war':
          ensure => present,
          source => "/usr/src/servioticy/servioticy-api-private/target/api-private.war",
          notify  => Service["jetty"],
          require => Exec['build_servioticy']
}

file { '/opt/jetty/webapps/root.war':
          ensure => present,
          source => "/usr/src/servioticy/servioticy-api-public/target/api-public.war",
          notify  => Service["jetty"],
          require => Exec['build_servioticy']
}


class { 'jetty':
  version => "9.2.3.v20140905",
  home    => "/opt",
  user    => "vagrant",
  group   => "vagrant",
  require => Package["couchbase-server"]
}





vcsrepo { "/home/vagrant/servioticy-broker":
  ensure   => latest,
  provider => git,
  owner    => 'vagrant',
  group    => 'vagrant',
  require  => [ Package["git"] ],
  source   => "https://github.com/servioticy/servioticy-brokers.git",
  revision => 'master',
}


