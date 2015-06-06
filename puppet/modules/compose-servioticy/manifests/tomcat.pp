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
    package {"libmysql-java":
        ensure  => present,
    } ->
    package {"tomcat7":
        ensure  => present,
    } ->
    file { "/usr/share/tomcat7/lib/mysql_connector_jar":
        path    => "/usr/share/tomcat7/lib/${servioticy::params::mysql_connector_jar}",
        ensure  => present,
        source  => "/usr/share/java/${servioticy::params::mysql_connector_jar}",
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