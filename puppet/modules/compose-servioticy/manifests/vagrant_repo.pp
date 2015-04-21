class servioticy::vagrant_repo {

    package { 'git':
    } ->
    file { "create vagrantdir":
        path    => $servioticy::params::vagrantdir,
        ensure  => directory,
        recurse => true,
        owner   => $servioticy::params::user,
        mode    => 0774
    } ->
    vcsrepo { "vagrantdir":

        path     => $servioticy::params::vagrantdir,
        ensure   => latest,
        provider => git,

        owner    => $servioticy::params::user,
        group    => $servioticy::params::user,

        source   => $servioticy::params::git_vagrant_src,
        revision => $servioticy::params::git_vagrant_revision,
        
    }

}