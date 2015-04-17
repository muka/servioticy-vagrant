class servioticy::kestrel {

    include servioticy::params

    archive { "kestrel-${servioticy::params::kestrel_version}":
        ensure      => present,
        follow_redirects => true,
        extension   => "zip",
        checksum    => false,
        url         => $kestrel_url,
        target      => ${servioticy::params::installdir},
        src_target  => ${servioticy::params::downloaddir},
        timeout     => 0,
        require     => Class["servioticy::files", "servioticy::packages"],
    } ->
    file { "${servioticy::params::installdir}/kestrel-${servioticy::params::kestrel_version}":
        owner    => $user,
        group    => $user
    } ->
    file { "${servioticy::params::installdir}/kestrel-${servioticy::params::kestrel_version}/config/servioticy_queues.scala":
        ensure    => present,
        source    => "${servioticy::params::vagrantdir}/puppet/files/servioticy_queues.scala",
        owner     => $user,
        group     => $user,
    }

}