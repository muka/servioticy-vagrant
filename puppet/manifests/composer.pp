class servioticy::composer {

    include servioticy::params

    vcsrepo { "$installdir/servioticy-composer":
        ensure   => latest,
        provider => git,
        owner    => $user,
        group    => $user,
        require  => Class["servioticy::packages"],
        source   => $git_composer_url,
        revision => $git_composer_revision,
    }
}
