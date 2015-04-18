class servioticy::prepare {

    include servioticy::params

    group {"servioticy_gid":
        name        => $servioticy::params::user,
        ensure      => present
    } ->
    user {"servioticy_user":
        ensure      => present,
        name        => $servioticy::params::user,
        gid         => $servioticy::params::user,
        shell       => "/bin/bash",
        home        => "/home/${servioticy::params::user}",
        system      => false,
        managehome  => true,
        password    => "$1$D55RTbl1$UnXplGcyAd2T7fhxSM4ks.",
    } ->
    file { "downloaddir" :
        path        => $servioticy::params::downloaddir,
        ensure      => "directory",
    } ->
    file { "datadir" :
        path        => $servioticy::params::datadir,
        ensure      => "directory",
    } ->
    file { "installdir":
        path        => "${servioticy::params::installdir}",
        ensure      => "directory",
        owner       => $servioticy::params::user,
        group       => $servioticy::params::user,
    }
    # ->
    #file { ".bash_aliases":
    #    path => "/home/${servioticy::params::user}/.bash_aliases",
    #    ensure => "link",
    #    target => "${servioticy::params::vagrantdir}/puppet/scripts/env.sh",
    #}
}