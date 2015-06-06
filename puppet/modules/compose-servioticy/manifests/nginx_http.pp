class servioticy::nginx_http {


    
    package { "nginx":
        ensure  => present,
    } ->
    file { "link nginx host":
        path    => "/etc/nginx/sites-enabled/servioticy.conf",
        ensure  => "link",
        target  => "${servioticy::params::vagrantdir}/puppet/files/nginx-host.conf",
        mode    => 755
    } ->
    file { "rm nginx default":
        path    => "/etc/nginx/sites-enabled/default",
        ensure  => "absent"
    }
    

}
