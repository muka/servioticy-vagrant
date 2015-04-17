class servioticy::jetty {

    include servioticy::params

    class { 'jetty':
        version => "9.2.3.v20140905",
        home    => "$installdir",
        user    => "$user",
        group   => "$user",
    } ->
    exec{ 'stop-jetty':
        require => Class['jetty'],
        command => "/etc/init.d/jetty stop",
    }

    file { '$installdir/jetty/start.ini':
        ensure => 'present',
        audit  => 'all',
    } ->
    file_line { 'cross_origin':
        path => '$installdir/jetty/start.ini',
        line => '--module=servlets',
    }

}