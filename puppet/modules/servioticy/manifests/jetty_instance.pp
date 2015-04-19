class servioticy::jetty_instance {

    class { "jetty":

        manage_user => false,

        version     => "9.2.3.v20140905",

        home        => $servioticy::params::installdir,
        user        => $servioticy::params::user,
        group       => $servioticy::params::user,

    } ->
    exec{ "stop-jetty":
        command => "/etc/init.d/jetty stop",
    } ->
    file { "jetty/start.ini":
        path    => "${servioticy::params::installdir}/jetty/start.ini",
        ensure  => "present",
        audit   => "all",
    } ->
    file_line { "cross_origin":
        path    => "${servioticy::params::installdir}/jetty/start.ini",
        line    => "--module=servlets",
    }

}