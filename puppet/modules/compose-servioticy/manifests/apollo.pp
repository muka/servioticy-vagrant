class servioticy::apollo {

    archive { "apache-apollo-${servioticy::params::apollo_version}":
        ensure => present,
        follow_redirects => true,
        checksum => false,
        url    => $servioticy::params::apollo_src,
        target => $servioticy::params::installdir,
        src_target => $servioticy::params::downloaddir,
        timeout => 0
    } ->
    file { "${servioticy::params::installdir}/apache-apollo-${servioticy::params::apollo_version}":
        owner    => $servioticy::params::user,
        group    => $servioticy::params::user,
    } ->

    exec { "create_broker":
        creates => "${servioticy::params::installdir}/servibroker",
        cwd => "${servioticy::params::installdir}/apache-apollo-${servioticy::params::apollo_version}/bin/",
        path => "/bin:/usr/bin/:${servioticy::params::installdir}/apache-apollo-${servioticy::params::apollo_version}/bin/",
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
        source  => "${servioticy::params::vagrantdir}/puppet/files/broker/servibroker/apollo.xml",
    } ->
    file { "${servioticy::params::installdir}/servibroker/etc/users.properties":
        path    => "${servioticy::params::installdir}/servibroker/etc/users.properties",
        ensure  => present,
        replace => true,
        owner   => $servioticy::params::user,
        group   => $servioticy::params::user,
        source  => "${servioticy::params::vagrantdir}/puppet/files/broker/servibroker/users.properties",
    }->
    file { "${servioticy::params::installdir}/servibroker/etc/groups.properties":
        path    => "${servioticy::params::installdir}/servibroker/etc/groups.properties",
        ensure  => present,
        replace => true,
        owner   => $servioticy::params::user,
        group   => $servioticy::params::user,
        source  => "${servioticy::params::vagrantdir}/puppet/files/broker/servibroker/groups.properties",
    } ->

    exec { "create_internal_broker":
        creates => "${servioticy::params::installdir}/internal-broker",
        cwd => "${servioticy::params::installdir}/apache-apollo-${servioticy::params::apollo_version}/bin/",
        path => "/bin:/usr/bin/:${servioticy::params::installdir}/apache-apollo-${servioticy::params::apollo_version}/bin/",
        command => "apollo create ${servioticy::params::installdir}/internal-broker",
        #logoutput => true,
    } ->
    file { "${servioticy::params::installdir}/internal-broker":
        path     => "${servioticy::params::installdir}/internal-broker",
        owner    => $servioticy::params::user,
        group    => $servioticy::params::user,
    } ->
    file { "${servioticy::params::installdir}/internal-broker/etc/apollo.xml":
        path    => "${servioticy::params::installdir}/internal-broker/etc/apollo.xml",
        ensure  => present,
        replace => true,
        owner   => $servioticy::params::user,
        group   => $servioticy::params::user,
        source  => "${servioticy::params::vagrantdir}/puppet/files/broker/internal/apollo.xml",
    } ->
    file { "${servioticy::params::installdir}/internal-broker/etc/users.properties":
        path    => "${servioticy::params::installdir}/internal-broker/etc/users.properties",
        ensure  => present,
        replace => true,
        owner   => $servioticy::params::user,
        group   => $servioticy::params::user,
        source  => "${servioticy::params::vagrantdir}/puppet/files/broker/internal/users.properties",
    }->
    file { "${servioticy::params::installdir}/internal-broker/etc/groups.properties":
        path    => "${servioticy::params::installdir}/internal-broker/etc/groups.properties",
        ensure  => present,
        replace => true,
        owner   => $servioticy::params::user,
        group   => $servioticy::params::user,
        source  => "${servioticy::params::vagrantdir}/puppet/files/broker/internal/groups.properties",
    }

}