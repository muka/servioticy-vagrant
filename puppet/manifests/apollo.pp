class servioticy::apollo {
    
    include servioticy::params
    
    $apollo_src = 'http://archive.apache.org/dist/activemq/activemq-apollo/1.7/apache-apollo-1.7-unix-distro.tar.gz'

    archive { 'apache-apollo-1.7':
        ensure => present,
        follow_redirects => true,
        checksum => false,
        url    => $apollo_src,
        target => $installdir,
        src_target => $downloaddir,
        require  => [ Package["curl"], File['$downloaddir'] ],
        timeout => 0
    } ->
    file { '$installdir/apache-apollo-1.7':
        owner    => $user,
        group    => $user,

    } ->
    exec { 'create_broker':
        require => [ Package['oracle-java7-installer'] ],
        creates => '$installdir/servibroker',
        cwd => "$installdir/apache-apollo-1.7/bin/",
        path => "/bin:/usr/bin/:$installdir/apache-apollo-1.7/bin/",
        command => "apollo create $installdir/servibroker",
        #logoutput => true,
    } ->
    file { '$installdir/servibroker':
        owner    => $user,
        group    => $user,
        before   => [File['$installdir/servibroker/etc/apollo.xml'], File['$installdir/servibroker/etc/users.properties'], File['$installdir/servibroker/etc/groups.properties']]
    }

    file { '$installdir/servibroker/etc/apollo.xml':
        ensure => present,
        replace => true,
        owner    => $user,
        group    => $user,
        source => "$installdir/servioticy-vagrant/puppet/files/apollo.xml",
        require => [ Exec['create_broker'], Vcsrepo["$installdir/servioticy-vagrant"] ]
    }

    file { '$installdir/servibroker/etc/users.properties':
        ensure => present,
        replace => true,
        owner    => $user,
        group    => $user,
        source => "$installdir/servioticy-vagrant/puppet/files/users.properties",
        require => [Vcsrepo["$installdir/servioticy-vagrant"], Exec['create_broker']]
    }

    file { '$installdir/servibroker/etc/groups.properties':
        ensure => present,
        replace => true,
        owner    => $user,
        group    => $user,
        source => "$installdir/servioticy-vagrant/puppet/files/groups.properties",
        require => [Vcsrepo["$installdir/servioticy-vagrant"], Exec['create_broker']]
    }

}