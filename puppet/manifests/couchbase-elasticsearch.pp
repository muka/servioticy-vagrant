class servioticy::composer {

    include servioticy::params

    vcsrepo { "$srcdir/couchbase-capi-server":
      ensure   => latest,
      provider => git,
      owner    => 'root',
      group    => 'root',
      require  => Class['servioticy::packages', 'maven::maven'],
      source   => $git_es_capi_url,
      revision => $git_es_capi_revision,
    } ->
    exec { "build_couchbase_capi":
       cwd     => "$srcdir/couchbase-capi-server",
       command => "mvn install",
       path    => "/usr/local/bin/:/usr/bin:/bin/",
       user    => 'root',
       require => Class['servioticy::servioticy']
    } ->
    vcsrepo { "$srcdir/elasticsearch-transport-couchbase":
      ensure   => latest,
      provider => git,
      owner    => 'root',
      group    => 'root',
      require  => Class['servioticy::packages', 'maven::maven'],
      source   => $git_es_transport_url,
      revision => $git_es_transport_revision,
    } ->
    exec { "build_elasticsearch-transport-couchbase":
       cwd     => "$srcdir/elasticsearch-transport-couchbase",
       command => "mvn install",
       path    => "/usr/local/bin/:/usr/bin:/bin/",
       user    => 'root',
       require => [ Exec["build_servioticy"] ]
    }

    elasticsearch::plugin{ 'transport-couchbase':
      module_dir => 'transport-couchbase',
      url        => 'file:///$srcdir/elasticsearch-transport-couchbase/target/releases/elasticsearch-transport-couchbase-2.0.0.zip',
      instances  => 'serviolastic',
      require  => [ Class['servioticy::packages'], Exec['build_elasticsearch-transport-couchbase'] ],
    }

}
