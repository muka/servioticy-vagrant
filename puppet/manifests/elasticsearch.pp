class servioticy::elasticsearch {

    include servioticy::params

    exec {"wait for elasticsearch":
        require => [Elasticsearch::Instance['serviolastic'], File['$installdir/servioticy_scripts']],
        command => "/bin/sh $installdir/servioticy_scripts/wait_for_elasticsearch.sh",
        timeout => 0
    }

    class { 'elasticsearch':
        package_url => $es_url,
        init_defaults => $es_hash,
        require => Class["servioticy::packages"],
    }

    elasticsearch::instance { 'serviolastic':
        config => $es_config_hash,
        datadir => '$datadir/elasticsearch',
    }

    vcsrepo { "$installdir/servioticy-indices":
        ensure   => latest,
        provider => git,
        owner    => '$user',
        group    => '$user',
        require => Class["servioticy::packages"],
        source   => $git_esindices_url,
        revision => $git_esindices_revision,
    } 

    elasticsearch::plugin{ 'mobz/elasticsearch-head':
        module_dir => 'head',
        instances  => 'serviolastic',
        require => Class["servioticy::packages"],
    }

}
