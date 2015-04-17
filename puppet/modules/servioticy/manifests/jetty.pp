class servioticy::jetty {

    include servioticy::params

    class { "jetty":
        version => "9.2.3.v20140905",
        home    => $servioticy::params::installdir,
        user    => $servioticy::params::user,
        group   => $servioticy::params::user,
    }

    exec{ "stop-jetty":
        require => Class["jetty"],
        command => "/etc/init.d/jetty stop",
    }

    file { "installdir/jetty/start.ini":
        path => "${servioticy::params::installdir}/jetty/start.ini",
        ensure => "present",
        audit  => "all",
    } ->
    file_line { "cross_origin":
        path => "${servioticy::params::installdir}/jetty/start.ini",
        line => "--module=servlets",
    }

}