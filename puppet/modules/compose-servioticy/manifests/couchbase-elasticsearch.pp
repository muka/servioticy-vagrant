class servioticy::couchbase-elasticsearch {

    file { "dir couchbase-capi-server":
        path     => "${servioticy::params::srcdir}/couchbase-capi-server",
        ensure  => directory,
        recurse => true,
        owner   => $servioticy::params::user,
        mode    => 0774
    } ->
    vcsrepo { "couchbase-capi-server":
        path     => "${servioticy::params::srcdir}/couchbase-capi-server",
        ensure   => latest,
        provider => git,
        owner    => "root",
        group    => "root",

        source   => $servioticy::params::git_es_capi_url,
        revision => $servioticy::params::git_es_capi_revision,

    } ->
    exec { "build_couchbase_capi":
        cwd     => "${servioticy::params::srcdir}/couchbase-capi-server",
        command => "mvn install",
        path    => "/usr/local/bin/:/usr/bin:/bin/",
        user    => "root",
    } ->
    file { "dir elasticsearch-transport-couchbase":
        path     => "${servioticy::params::srcdir}/elasticsearch-transport-couchbase",
        ensure  => directory,
        recurse => true,
        owner   => $servioticy::params::user,
        mode    => 0774
    } ->
    vcsrepo { "elasticsearch-transport-couchbase":
        path     => "${servioticy::params::srcdir}/elasticsearch-transport-couchbase",
        ensure   => latest,
        provider => git,
        owner    => "root",
        group    => "root",

        source   => $servioticy::params::git_es_transport_url,
        revision => $servioticy::params::git_es_transport_revision,

    } ->
    exec { "build_elasticsearch-transport-couchbase":
        cwd     => "${servioticy::params::srcdir}/elasticsearch-transport-couchbase",
        command => "mvn install",
        path    => "/usr/local/bin/:/usr/bin:/bin/",
        user    => "root",
    }

}
