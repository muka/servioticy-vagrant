class servioticy::service_manager {

    file { "dir servioticy-service-manager":
        path     => "${servioticy::params::installdir}/servioticy-service-manager",
        ensure  => directory,
        recurse => true,
        owner   => $servioticy::params::user,
        mode    => 0774
    } ->
    vcsrepo { "servioticy-service-manager":

        path     => "${servioticy::params::installdir}/servioticy-service-manager",
        ensure   => latest,
        provider => git,

        owner    => $servioticy::params::user,
        group    => $servioticy::params::user,

        source   => $servioticy::params::git_servicemgm_url,
        revision => $servioticy::params::git_servicemgm_revision,
    } ->
    file { "/usr/bin/servioticy":
        ensure   => "link",
        target   => "${servioticy::params::installdir}/servioticy-service-manager/bin/service",
    } ->
    exec { "smgr_add_deps":
        user     => $servioticy::params::user,
        group    => $servioticy::params::user,
        cwd      => "${servioticy::params::installdir}/servioticy-service-manager",
        path     => "/bin:/usr/bin/",
        command  => "npm i"
    }

}