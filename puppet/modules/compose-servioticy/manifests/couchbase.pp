class servioticy::couchbase {

    wget::fetch { "couchbase-server-source":
      source      => $servioticy::params::couchbase_url,
      destination => "${servioticy::params::downloaddir}/${servioticy::params::couchbase_deb}",
      timeout     => 0,
      verbose     => false,
    } ->
    package { "couchbase-server":
        provider => dpkg,
        ensure => installed,
        source => "${servioticy::params::downloaddir}/${servioticy::params::couchbase_deb}"
    } ->
    file { "datadir/couchbase":
        path => "${servioticy::params::datadir}/couchbase",
        ensure => "directory",
        owner => "couchbase",
        group => "couchbase",
    }


}
