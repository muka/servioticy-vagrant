class servioticy::serviolastic {
    
    class { "elasticsearch":
        package_url     => $servioticy::params::es_url,
        init_defaults   => $servioticy::params::es_hash,
    }

    elasticsearch::instance { "serviolastic":
        config  => $servioticy::params::es_config_hash,
        datadir => "${servioticy::params::datadir}/elasticsearch-data",
    }

    elasticsearch::plugin{ "mobz/elasticsearch-head":
        module_dir => "head",
        instances  => "serviolastic",
    }

    elasticsearch::plugin{ "transport-couchbase":
        module_dir => "transport-couchbase",
        url        => "file:///${servioticy::params::srcdir}/elasticsearch-transport-couchbase/target/releases/${servioticy::params::es_transport_pkg}",
        instances  => "serviolastic",
        require    => Class["servioticy::couchbase-elasticsearch"],
    }

    file { "dir servioticy-indices":
        path    => "${servioticy::params::installdir}/servioticy-indices",
        ensure  => directory,
        recurse => true,
        owner   => $servioticy::params::user,
        mode    => 0774
    } ->
    vcsrepo { "servioticy-indices":

        path     => "${servioticy::params::installdir}/servioticy-indices",
        ensure   => latest,
        provider => git,

        owner    => $servioticy::params::user,
        group    => $servioticy::params::user,

        source   => $servioticy::params::git_esindices_url,
        revision => $servioticy::params::git_esindices_revision,
    }

}
