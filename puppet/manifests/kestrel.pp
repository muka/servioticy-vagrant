class servioticy::kestrel {

    include servioticy::params

    archive { 'kestrel-$kestrel_version':
        ensure      => present,
        follow_redirects => true,
        extension   => "zip",
        checksum    => false,
        url         => $kestrel_url,
        target      => '$installdir',
        src_target  => '$downloaddir',
        timeout     => 0,
        require     => Class['servioticy::files', 'servioticy::packages'],
    } ->
    file { '$installdir/kestrel-$kestrel_version':
        owner    => '$user',
        group    => '$user'
    } ->
    file { '$installdir/kestrel-$kestrel_version/config/servioticy_queues.scala':
        ensure    => present,
        source    => "$installdir/servioticy-vagrant/puppet/files/servioticy_queues.scala",
        owner     => '$user',
        group     => '$user',
    }

}