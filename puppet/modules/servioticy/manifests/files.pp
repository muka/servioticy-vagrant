class servioticy::files {

    include servioticy::params
    
    file { "downloaddir" :
        path    => $servioticy::params::downloaddir,
        ensure  => "directory",
        require => Class["servioticy::packages", "servioticy::setup"],
    } ->
    file { "/home/user/LICENSE.txt":
        path => "/home/$user/LICENSE.txt",
        ensure => present,
        replace => true,
        owner    => $user,
        group    => $user,
        source => "${servioticy::params::vagrantdir}/puppet/files/other/LICENSE.txt",
    } ->
    file { "/home/user/README.txt":
        path => "/home/$user/README.txt",
        ensure => present,
        replace => true,
        owner    => $user,
        group    => $user,
        source => "${servioticy::params::vagrantdir}/puppet/files/other/README.txt",
    } ->
    file { "/home/user/README.demos.txt":
        path => "/home/user/README.demos.txt",
        ensure => present,
        replace => true,
        owner    => $user,
        group    => $user,
        source => "${servioticy::params::vagrantdir}/puppet/files/other/README.demos.txt",
    } ->
    file { "/home/user/VERSION.txt":
        path => "/home/user/VERSION.txt",
        ensure => present,
        replace => true,
        owner    => $user,
        group    => $user,
        source => "${servioticy::params::vagrantdir}/puppet/files/other/VERSION.txt",
    } ->
    file { "/home/$user/.bash_aliases":
        path => "/home/$user/.bash_aliases",
        ensure => "link",
        target => "${servioticy::params::vagrantdir}/puppet/scripts/env.sh",
        require => Class["servioticy::packages"],
    } ->
    file { "/etc/servioticy":
        ensure => directory,
        replace => true,
        owner    => "root",
        group    => "root",
        source => "${servioticy::params::vagrantdir}/puppet/files/servioticy-etc",
        recurse => remote,
    } ->
    file { "datadir" :
        path => $servioticy::params::datadir,
        ensure => "directory",
    } ->
    file { "datadir/demo":
        path => "${servioticy::params::datadir}/demo",
        ensure => directory,
        replace => true,
        owner    => $user,
        group    => $user,
        source => "${servioticy::params::vagrantdir}/puppet/files/demo",
        recurse => remote,
        require => Class["servioticy::packages"],
    } ->
    file { "installdir/servioticy-dispatcher":
        path => "${servioticy::params::installdir}/servioticy-dispatcher",
        ensure => "directory",
        owner    => $user,
        group    => $user,
        require => Class["servioticy::packages"],
    } ->
    file { "installdir/servioticy-dispatcher/dispatcher.xml":
        path => "${servioticy::params::installdir}/servioticy-dispatcher/dispatcher.xml",
        ensure => present,
        source => "${servioticy::params::vagrantdir}/puppet/files/dispatcher.xml",
        owner    => $user,
        group    => $user,
    } ->
    file { "installdir/apache-storm-0.9.2-incubating":
        path => "${servioticy::params::installdir}/apache-storm-0.9.2-incubating",
        ensure => "directory",
        owner => $user,
        group => $user,
    } ->
    file { "installdir/servioticy_scripts":
        path => "${servioticy::params::installdir}/servioticy_scripts",
        ensure => directory,
        replace => true,
        owner    => $user,
        group    => $user,
        source => "${servioticy::params::vagrantdir}/puppet/scripts",
        recurse => remote,
        require => Class["servioticy::packages"],
    } ->
    file { "installdir/compose-idm":
        path => "${servioticy::params::installdir}/compose-idm",
        ensure => "directory",
        owner => $user,
        group => $user
    }


    file { "/usr/bin/start-servioticy":
        ensure => "link",
        target => "${servioticy::params::installdir}/servioticy_scripts/startAll.sh",
        require => File["installdir/servioticy_scripts"],
        mode => 755
    } ->
    file { "/usr/bin/stop-servioticy":
        ensure => "link",
        target => "${servioticy::params::installdir}/servioticy_scripts/stopAll.sh",
        require => File["installdir/servioticy_scripts"],
        mode => 755
    } ->
    file { "/tmp/mysql-server.response":
        ensure => present,
        source => "${servioticy::params::vagrantdir}/puppet/files/mysql-server.response",
    } ->
    file { "/usr/share/tomcat7/lib/mysql_connector_jar":
        path => "/usr/share/tomcat7/lib/$mysql_connector_jar",
        ensure => present,
        source => "/usr/share/java/${mysql_connector}_jar",
    }

}
