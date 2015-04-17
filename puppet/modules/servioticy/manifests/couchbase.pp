class servioticy::couchbase {

    include servioticy::params

    wget::fetch { "couchbase-server-source":
      source      => $couchbase_url,
      destination => "${servioticy::params::downloaddir}/couchbase-server-enterprise_3.0.0-ubuntu12.04_amd64.deb",
      timeout     => 0,
      verbose     => false,
      require     => Class["servioticy::files"]
    } ->
    package { "couchbase-server":
        provider => dpkg,
        ensure => installed,
        source => "${servioticy::params::downloaddir}/couchbase-server-enterprise_3.0.0-ubuntu12.04_amd64.deb"
    } ->
    file { "datadir/couchbase":
        path => "${servioticy::params::datadir}/couchbase",
        ensure => "directory",
        owner => "couchbase",
        group => "couchbase",
    }


}
