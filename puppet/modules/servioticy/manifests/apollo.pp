class servioticy::apollo {
    
    include servioticy::params    

    archive { "apache-apollo-1.7":
        ensure => present,
        follow_redirects => true,
        checksum => false,
        url    => $apollo_src,
        target => $servioticy::params::installdir,
        src_target => $servioticy::params::downloaddir,
        require  => Class["servioticy::packages"],
        timeout => 0
    } ->
    file { "${servioticy::params::installdir}/apache-apollo-1.7":
        owner    => $user,
        group    => $user,

    } ->
    exec { "create_broker":
        require => [ Package["oracle-java7-installer"] ],
        creates => "${servioticy::params::installdir}/servibroker",
        cwd => "${servioticy::params::installdir}/apache-apollo-1.7/bin/",
        path => "/bin:/usr/bin/:${servioticy::params::installdir}/apache-apollo-1.7/bin/",
        command => "apollo create ${servioticy::params::installdir}/servibroker",
        #logoutput => true,
    } ->
    file { "${servioticy::params::installdir}/servibroker":
        owner    => $user,
        group    => $user,
    } ->
    file { "${servioticy::params::installdir}/servibroker/etc/apollo.xml":
        ensure => present,
        replace => true,
        owner    => $user,
        group    => $user,
        source => "${servioticy::params::vagrantdir}/puppet/files/apollo.xml",
    } ->
    file { "${servioticy::params::installdir}/servibroker/etc/users.properties":
        ensure => present,
        replace => true,
        owner    => $user,
        group    => $user,
        source => "${servioticy::params::vagrantdir}/puppet/files/users.properties",
    }->
    file { "${servioticy::params::installdir}/servibroker/etc/groups.properties":
        ensure => present,
        replace => true,
        owner    => $user,
        group    => $user,
        source => "${servioticy::params::vagrantdir}/puppet/files/groups.properties",
        require => Class["servioticy::packages"]
    }

}