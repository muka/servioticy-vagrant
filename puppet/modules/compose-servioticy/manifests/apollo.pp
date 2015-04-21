class servioticy::apollo {
    
    archive { "apache-apollo-1.7":
        ensure => present,
        follow_redirects => true,
        checksum => false,
        url    => $servioticy::params::apollo_src,
        target => $servioticy::params::installdir,
        src_target => $servioticy::params::downloaddir,
        timeout => 0
    } ->
    file { "${servioticy::params::installdir}/apache-apollo-1.7":
        owner    => $servioticy::params::user,
        group    => $servioticy::params::user,
    } ->
    exec { "create_broker":
        creates => "${servioticy::params::installdir}/servibroker",
        cwd => "${servioticy::params::installdir}/apache-apollo-1.7/bin/",
        path => "/bin:/usr/bin/:${servioticy::params::installdir}/apache-apollo-1.7/bin/",
        command => "apollo create ${servioticy::params::installdir}/servibroker",
        #logoutput => true,
    } ->
    file { "${servioticy::params::installdir}/servibroker":
        path     => "${servioticy::params::installdir}/servibroker",
        owner    => $servioticy::params::user,
        group    => $servioticy::params::user,
    } ->
    file { "${servioticy::params::installdir}/servibroker/etc/apollo.xml":
        path    => "${servioticy::params::installdir}/servibroker/etc/apollo.xml",
        ensure  => present,
        replace => true,
        owner   => $servioticy::params::user,
        group   => $servioticy::params::user,
        source  => "${servioticy::params::vagrantdir}/puppet/files/apollo.xml",
    } ->
    file { "${servioticy::params::installdir}/servibroker/etc/users.properties":
        path    => "${servioticy::params::installdir}/servibroker/etc/users.properties",
        ensure  => present,
        replace => true,
        owner   => $servioticy::params::user,
        group   => $servioticy::params::user,
        source  => "${servioticy::params::vagrantdir}/puppet/files/users.properties",
    }->
    file { "${servioticy::params::installdir}/servibroker/etc/groups.properties":
        path    => "${servioticy::params::installdir}/servibroker/etc/groups.properties",
        ensure  => present,
        replace => true,
        owner   => $servioticy::params::user,
        group   => $servioticy::params::user,
        source  => "${servioticy::params::vagrantdir}/puppet/files/groups.properties",
    }

}