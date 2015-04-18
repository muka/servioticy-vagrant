class servioticy::files {


    file { "/etc/servioticy":
        ensure => directory,
        replace => true,
        owner    => "root",
        group    => "root",
        source => "${servioticy::params::vagrantdir}/puppet/files/servioticy-etc",
        recurse => remote,
    } ->
    file { "datadir/demo":
        path => "${servioticy::params::datadir}/demo",
        ensure => directory,
        replace => true,
        owner    => $servioticy::params::user,
        group    => $servioticy::params::user,
        source => "${servioticy::params::vagrantdir}/puppet/files/demo",
        recurse => remote,
    } ->
    file { "installdir/servioticy-dispatcher":
        path => "${servioticy::params::installdir}/servioticy-dispatcher",
        ensure => "directory",
        owner    => $servioticy::params::user,
        group    => $servioticy::params::user,
    } ->
    file { "installdir/servioticy-dispatcher/dispatcher.xml":
        path => "${servioticy::params::installdir}/servioticy-dispatcher/dispatcher.xml",
        ensure      => present,
        source      => "${servioticy::params::vagrantdir}/puppet/files/dispatcher.xml",
        owner       => $servioticy::params::user,
        group       => $servioticy::params::user,
    } ->
    file { "installdir/apache-storm-0.9.2-incubating":
        path        => "${servioticy::params::installdir}/apache-storm-0.9.2-incubating",
        ensure      => "directory",
        owner       => $servioticy::params::user,
        group       => $servioticy::params::user,
    } ->
    file { "installdir/servioticy_scripts":
        path     => "${servioticy::params::installdir}/servioticy_scripts",
        ensure   => directory,
        replace  => true,
        owner    => $servioticy::params::user,
        group    => $servioticy::params::user,
        source   => "${servioticy::params::vagrantdir}/puppet/scripts",
        recurse  => remote,
    } ->
    file { "installdir/compose-idm":
        path => "${servioticy::params::installdir}/compose-idm",
        ensure => "directory",
        owner => $servioticy::params::user,
        group => $servioticy::params::user
    } ->
    file { "/usr/bin/start-servioticy":
        ensure => "link",
        target => "${servioticy::params::installdir}/servioticy_scripts/startAll.sh",
        mode => 755
    } ->
    file { "/usr/bin/stop-servioticy":
        ensure => "link",
        target => "${servioticy::params::installdir}/servioticy_scripts/stopAll.sh",
        mode => 755
    } ->
    file { "LICENSE.txt":
        path        => "${servioticy::params::installdir}/LICENSE.txt",
        ensure      => present,
        replace     => true,
        owner       => $servioticy::params::user,
        group       => $servioticy::params::user,
        source      => "${servioticy::params::vagrantdir}/puppet/files/other/LICENSE.txt",
    } ->
    file { "README.txt":
        path        => "${servioticy::params::installdir}/README.txt",
        ensure      => present,
        replace     => true,
        owner       => $servioticy::params::user,
        group       => $servioticy::params::user,
        source      => "${servioticy::params::vagrantdir}/puppet/files/other/README.txt",
    } ->
    file { "README.demos.txt":
        path        => "${servioticy::params::installdir}/README.demos.txt",
        ensure      => present,
        replace     => true,
        owner       => $servioticy::params::user,
        group       => $servioticy::params::user,
        source      => "${servioticy::params::vagrantdir}/puppet/files/other/README.demos.txt",
    } ->
    file { "VERSION.txt":
        path        => "${servioticy::params::installdir}/VERSION.txt",
        ensure      => present,
        replace     => true,
        owner       => $servioticy::params::user,
        group       => $servioticy::params::user,
        source      => "${servioticy::params::vagrantdir}/puppet/files/other/VERSION.txt",
    }
}
