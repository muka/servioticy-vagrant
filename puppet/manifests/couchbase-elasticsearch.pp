vcsrepo { "/usr/src/couchbase-capi-server":
  ensure   => latest,
  provider => git,
  owner    => 'root',
  group    => 'root',
  require  => [ Package["git"], Class['maven::maven'], Package['oracle-java7-installer'] ],
  source   => "https://github.com/couchbaselabs/couchbase-capi-server.git",
  revision => 'master',
} ->
exec { "build_couchbase_capi":
   cwd     => "/usr/src/couchbase-capi-server",
   command => "mvn install",
   path    => "/usr/local/bin/:/usr/bin:/bin/",
   user    => 'root'
} ->
vcsrepo { "/usr/src/elasticsearch-transport-couchbase":
  ensure   => latest,
  provider => git,
  owner    => 'root',
  group    => 'root',
  require  => [ Package["git"], Class['maven::maven'], Package['oracle-java7-installer'] ],
  source   => "https://github.com/couchbaselabs/elasticsearch-transport-couchbase.git",
  revision => 'master',
} ->
exec { "build_elasticsearch-transport-couchbase":
   cwd     => "/usr/src/elasticsearch-transport-couchbase",
   command => "mvn install",
   path    => "/usr/local/bin/:/usr/bin:/bin/",
   user    => 'root'
}

elasticsearch::plugin{ 'transport-couchbase':
  module_dir => 'transport-couchbase',
  url        => 'file:////usr/src/elasticsearch-transport-couchbase/target/releases/elasticsearch-transport-couchbase-2.0.0.zip',
  instances  => 'serviolastic',
  require  => [ Package["git"], Package['oracle-java7-installer'], Exec['build_elasticsearch-transport-couchbase']],
}

#exec {
#    'create-xdcr':
#      command => '/bin/sh create_xdcr.sh',
#      cwd => "/vagrant/puppet/files",
#      path =>  "/usr/local/bin/:/bin/:/usr/bin/",      
#      require => [Exec['create_buckets'], Exec['build_elasticsearch-transport-couchbase'], Exec['create-indices']]     
#}
