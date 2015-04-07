
group {'servioticy_gid':
    ensure => present
}

user {'servioticy_user':
    ensure => present,
    gid => 'servioticy',
    shell => '/bin/bash',
    home => '/home/servioticy',
    managehome => 'true',
    password => '$1$D55RTbl1$UnXplGcyAd2T7fhxSM4ks.',
    require => [ Group['servioticy_gid'] ]
}
