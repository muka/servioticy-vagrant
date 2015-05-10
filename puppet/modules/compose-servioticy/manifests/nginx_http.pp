class servioticy::nginx_http {


    
    package { "nginx":
        ensure => present,
    } ->
    file { "/etc/nginx/sites-enabled/servioticy.conf":
        ensure => "link",
        target => "${servioticy::params::vagrantdir}/puppet/files/nginx-host.conf",
        mode => 755
    }

}
