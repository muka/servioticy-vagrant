class servioticy::start_all {

    exec { "start-all":

        path    => "/usr/local/bin/:/usr/bin:/bin/",
        cwd     => "${servioticy::params::installdir}",

        command => "servioticy start",

        user    => "root",
        group   => "root",
    }

}