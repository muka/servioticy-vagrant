class servioticy::nginx {

    include servioticy::params

    class { 'nginx': 
        service_ensure => 'stopped'
    }

    nginx::resource::vhost { 'localhost':
        www_root    => '$datadir/demo/map/app',
        listen_port => 8090,
        ssl         => false,
    } 

}
