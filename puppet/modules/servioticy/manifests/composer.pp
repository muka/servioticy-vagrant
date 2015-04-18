class servioticy::composer {

    file { "dir servioticy-composer":
        path    => "${servioticy::params::installdir}/servioticy-composer",
        ensure  => directory,
        recurse => true,
        owner   => $servioticy::params::user,
        mode    => 0774
    } ->
    vcsrepo { "servioticy-composer":
        path     => "${servioticy::params::installdir}/servioticy-composer",
        ensure   => latest,
        provider => git,
        owner    => $servioticy::params::user,
        group    => $servioticy::params::user,
        source   => $git_composer_url,
        revision => $git_composer_revision,
    }

}
