class servioticy::files {

    include servioticy::params
    
    file { '$downloaddir':
        ensure => 'directory',
        require => Class['servioticy::packages', 'servioticy::setup'],
    } ->
    file { '$datadir':
        ensure => 'directory',
    } ->
    file { '$datadir/couchbase':
        ensure => 'directory',
        owner => "couchbase",
        group => "couchbase",
    } ->
    file { '$installdir/apache-storm-0.9.2-incubating':
        ensure => 'directory',
        owner => $user,
        group => $user,
    } ->
    file { '/home/$user/LICENSE.txt':
        ensure => present,
        replace => true,
        owner    => '$user',
        group    => '$user',
        source => "$installdir/servioticy-vagrant/puppet/files/other/LICENSE.txt",
    } ->
    file { '/home/$user/README.txt':
        ensure => present,
        replace => true,
        owner    => '$user',
        group    => '$user',
        source => "$installdir/servioticy-vagrant/puppet/files/other/README.txt",
    } ->
    file { '/home/$user/README.demos.txt':
        ensure => present,
        replace => true,
        owner    => '$user',
        group    => '$user',
        source => "$installdir/servioticy-vagrant/puppet/files/other/README.demos.txt",
    } ->
    file { '/home/servioticy/VERSION.txt':
        ensure => present,
        replace => true,
        owner    => '$user',
        group    => '$user',
        source => "$installdir/servioticy-vagrant/puppet/files/other/VERSION.txt",
    } ->
    file { '/etc/servioticy':
        ensure => directory,
        replace => true,
        owner    => 'root',
        group    => 'root',
        source => "$installdir/servioticy-vagrant/puppet/files/servioticy-etc",
        recurse => remote,
        require => Class["servioticy::servioticy"],
    }

    file { '$installdir/servioticy-dispatcher':
        ensure => 'directory',
        owner    => '$user',
        group    => '$user',
        require => Class['servioticy::packages'],
    } ->
    file { '$installdir/servioticy-dispatcher/$dispatcher_jar':
        ensure => present,
        source => "$srcdir/servioticy/servioticy-dispatcher/target/$dispatcher_jar",
        owner    => '$user',
        group    => '$user',
        require => Class["servioticy::servioticy"],
    } ->
    file { '$installdir/servioticy-dispatcher/dispatcher.xml':
        ensure => present,
        source => "$installdir/servioticy-vagrant/puppet/files/dispatcher.xml",
        owner    => '$user',
        group    => '$user',
    }

    file { '$datadir/demo':
        ensure => directory,
        replace => true,
        owner    => '$user',
        group    => '$user',
        source => "$installdir/servioticy-vagrant/puppet/files/demo",
        recurse => remote,
        require => Class["servioticy::packages"],
    }

    file { '$installdir/servioticy_scripts':
        ensure => directory,
        replace => true,
        owner    => '$user',
        group    => '$user',
        source => "$installdir/servioticy-vagrant/puppet/scripts",
        recurse => remote,
        require => Class["servioticy::packages"],
    }

    file { '/usr/bin/start-servioticy':
        ensure => 'link',
        target => '$installdir/servioticy_scripts/startAll.sh',
        require => File['$installdir/servioticy_scripts'],
        mode => 755
    }

    file { '/usr/bin/stop-servioticy':
        ensure => 'link',
        target => '$installdir/servioticy_scripts/stopAll.sh',
        require => File['$installdir/servioticy_scripts'],
        mode => 755
    }

    file { '$installdir/compose-idm':
        ensure => 'directory',
        owner => '$user',
        group => '$user'
    } ->
    file { '$installdir/compose-idm/$idm_jar':
        ensure => present,
        source => "$srcdir/compose-idm/build/libs/$idm_jar",
        require => Class[ "servioticy::packages", "servioticy::idm" ]
    }

    file { '$srcdir/compose-idm/src/main/resources/uaa.properties':
        ensure => present,
        source => "$installdir/servioticy-vagrant/puppet/files/idm/uaa.properties",
        require => Class[ "servioticy::packages", "servioticy::security" ]
    }

    file { '/tmp/mysql-server.response':
        ensure => present,
        source => "$installdir/servioticy-vagrant/puppet/files/mysql-server.response",
        require => Class[ "servioticy::packages" ]
    }

    file { '/usr/share/tomcat7/lib/$mysql_connector_jar':
        ensure => present,
        source => "/usr/share/java/$mysql_connector_jar",
        require => Class["servioticy::packages"],
    }

    file { '/home/$user/.bash_aliases':
        ensure => 'link',
        target => '$installdir/servioticy-vagrant/puppet/scripts/env.sh',
        require => Class["servioticy::packages"],
    }

    file { '$installdir/jetty/webapps/private.war':
        ensure => present,
        source => "$srcdir/servioticy/servioticy-api-private/target/api-private.war",
        notify  => Service["jetty"],
        require => Class["servioticy::servioticy"],
    }

    file { '$installdir/jetty/webapps/root.war':
        ensure => present,
        source => "$srcdir/servioticy/servioticy-api-public/target/api-public.war",
        notify  => Service["jetty"],
        require => Class["servioticy::servioticy"],
    }

    file { '/var/lib/tomcat7/webapps/uaa.war':
        ensure => present,
        source => "$srcdir/cf-uaa/uaa/build/libs/cloudfoundry-identity-uaa-1.11.war",
        require => [Exec['build-uaa'], Package['tomcat7']]
    }

}
