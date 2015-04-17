class servioticy::tomcat {

    include servioticy::params

    file { "/etc/tomcat7":
        ensure => "directory",
        owner => "tomcat7",
        group => "tomcat7",
    } ->
    file { "/etc/tomcat7/server.xml":
        ensure => present,
        replace => true,
        owner    => "tomcat7",
        group    => "tomcat7",
        before => Package["tomcat7"],
        source => "${servioticy::params::vagrantdir}/puppet/files/server.xml",
        require => Class["servioticy::packages"],
    }

}