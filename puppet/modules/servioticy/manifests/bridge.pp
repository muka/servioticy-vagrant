class servioticy::bridge {

    file { "dir servioticy-bridge":
        path     => "${servioticy::params::installdir}/servioticy-bridge",
        ensure  => directory,
        recurse => true,
        owner   => $servioticy::params::user,
        mode    => 0774
    } ->
    vcsrepo { "servioticy-bridge":
        path     => "${servioticy::params::installdir}/servioticy-bridge",
        ensure   => latest,
        provider => git,
        owner    => $servioticy::params::user,
        group    => $servioticy::params::user,
        source   => $git_bridge_src,
        revision => $git_bridge_revision,
    }

}