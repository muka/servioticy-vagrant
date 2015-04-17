class servioticy::bridge {

    include servioticy::params

    vcsrepo { "servioticy-bridge-dir":
        path     => "${installdir}/servioticy-bridge",
        ensure   => latest,
        provider => git,
        owner    => $user,
        group    => $user,
        require  => Class["servioticy::packages"],
        source   => $git_bridge_src,
        revision => $git_bridge_revision,
    }

}