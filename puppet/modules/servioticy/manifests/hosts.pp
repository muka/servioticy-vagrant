class servioticy::hosts {


    host { "servioticy.local":
        ensure              => "present",
        target              => "/etc/hosts",
        ip                  => "127.0.0.1",
        host_aliases        => [ "localhost", "servioticy" ],
    }


}