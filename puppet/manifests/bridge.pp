class servioticy::bridge {

    include servioticy::params

    vcsrepo { "/opt/servioticy-bridge":
        ensure   => latest,
        provider => git,
        owner    => $user,
        group    => $user,
        require  => [ Package["git"], Package['forever'] ],
        source   => $git_bridge_src,
        revision => $git_bridge_revision
    }

}