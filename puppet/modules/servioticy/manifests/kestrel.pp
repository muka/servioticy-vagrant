class servioticy::kestrel {

    archive { "kestrel-download":

        ensure           => present,
        follow_redirects => true,
        extension        => "zip",
        checksum         => false,
        timeout          => 0,

        url              => $servioticy::params::kestrel_url,
        target           => $servioticy::params::installdir,
        src_target       => $servioticy::params::downloaddir,

    } ->
    file { "dir kestrel":
        path     => "${servioticy::params::installdir}/kestrel-${servioticy::params::kestrel_version}",
        owner    => $servioticy::params::user,
        group    => $servioticy::params::user
    } ->
    file { "servioticy_queues.scala":
        ensure    => present,
        path      => "${servioticy::params::installdir}/kestrel-${servioticy::params::kestrel_version}/config/servioticy_queues.scala",
        source    => "${servioticy::params::vagrantdir}/puppet/files/servioticy_queues.scala",
        owner     => $servioticy::params::user,
        group     => $servioticy::params::user,
    }

}