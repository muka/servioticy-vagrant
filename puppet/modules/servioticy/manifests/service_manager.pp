class servioticy::service_manager {

    include servioticy::params

    vcsrepo { "installdir/servioticy-service-manager":
        path     => "${servioticy::params::installdir}/servioticy-service-manager",
        ensure   => latest,
        provider => git,
        owner    => $user,
        group    => $user,
        source   => $git_servicemgm_url,
        revision => $git_servicemgm_revision,
        require  => Class["servioticy::packages"]
    } ->
    file { "/usr/bin/servioticy":
        ensure => "link",
        target => "${servioticy::params::installdir}/servioticy-service-manager/bin/service",
    } ->
    exec { "smgr_add_deps":
        user    => $user,
        group    => $user,
        cwd => "${servioticy::params::installdir}/servioticy-service-manager",
        path => "/bin:/usr/bin/",
        command => "npm i"
    }

}