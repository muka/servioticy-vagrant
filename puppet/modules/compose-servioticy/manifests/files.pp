class servioticy::files {


    file { "/etc/servioticy":
        ensure => directory,
        replace => true,
        owner    => "root",
        group    => "root",
        source => "${servioticy::params::vagrantdir}/puppet/files/servioticy-etc",
        recurse => remote,
    }
}
