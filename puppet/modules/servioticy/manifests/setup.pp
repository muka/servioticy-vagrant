class servioticy::setup {

    include servioticy::params

    include servioticy::packages
    include servioticy::files
    include servioticy::users

    include maven::maven

    class { 'apt':
        always_apt_update    => false,
        update_timeout       => 1800,
        require => Class["servioticy::users"],
    } ->
    host { "servioticy.local":
        ensure => "present",
        target => "/etc/hosts",
        ip => "127.0.0.1",
        host_aliases => [ "localhost", "servioticy" ],
    }

}