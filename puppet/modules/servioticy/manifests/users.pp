class servioticy::users {

    include servioticy::params

    group {"servioticy_gid":
        ensure => present
    } ->
    user {"servioticy_user":
        ensure => present,
        gid => $user,
        shell => "/bin/bash",
        home => "/home/$user",
        managehome => "true",
        password => "$1$D55RTbl1$UnXplGcyAd2T7fhxSM4ks.",
        require => [ Group["servioticy_gid"] ]
    } ->
    group { "tomcat7_gid":
        name => "tomcat7",
        ensure => present,
    } ->
    user { "tomcat7_user":
        name => "tomcat7",
        ensure => present,
        groups => "tomcat7",
    }

}