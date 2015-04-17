class servioticy::es {

    include servioticy::params

    exec {"wait for elasticsearch":
        require => [Elasticsearch::Instance["serviolastic"], File["installdir/servioticy_scripts"]],
        command => "/bin/sh ${servioticy::params::installdir}/servioticy_scripts/wait_for_elasticsearch.sh",
        timeout => 0
    }

    class { "elasticsearch":
        package_url => $es_url,
        init_defaults => $es_hash,
        require => Class["servioticy::packages"],
    }

    elasticsearch::instance { "serviolastic":
        config => $es_config_hash,
        datadir => "${servioticy::params::datadir}/elasticsearch",
    }

    vcsrepo { "installdir/servioticy-indices":
        path     => "${servioticy::params::installdir}/servioticy-indices",
        ensure   => latest,
        provider => git,
        owner    => $user,
        group    => $user,
        require => Class["servioticy::packages"],
        source   => $git_esindices_url,
        revision => $git_esindices_revision,
    } 

    elasticsearch::plugin{ "mobz/elasticsearch-head":
        module_dir => "head",
        instances  => "serviolastic",
        require => Class["servioticy::packages"],
    }

}
