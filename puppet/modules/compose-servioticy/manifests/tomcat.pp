class servioticy::tomcat {

    group { "tomcat7_gid":
        name    => "tomcat7",
        ensure  => present,
    } ->
    user { "tomcat7_user":
        ensure  => present,
        name    => "tomcat7",
        groups  => "tomcat7",
    } ->
    package {"tomcat7":
        ensure  => present,
    } ->
    file { "/etc/tomcat7":
        ensure  => "directory",
        owner   => "tomcat7",
        group   => "tomcat7",
    } ->
    file { "/etc/tomcat7/server.xml":
        ensure  => present,
        replace => true,
        owner   => "tomcat7",
        group   => "tomcat7",
        source  => "${servioticy::params::vagrantdir}/puppet/files/tomcat-server.xml",
    }

}
