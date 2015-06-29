class servioticy::packages {

    $mysql_root_passwd = $servioticy::params::mysql_root_passwd
    $mysql_version = $servioticy::params::mysql_version

    class { 'apt': }

    exec { "apt-update":
        command => "/usr/bin/apt-get update"
    }

    class { "python" :
        version    => "system",
        pip        => true,
        dev        => false,
        virtualenv => true,
        gunicorn   => false
    }

    python::pip { "Flask" :
        pkgname       => "Flask",
    }

    python::pip { "simplejson" :
        pkgname       => "simplejson",
    }

    apt::ppa { "ppa:webupd8team/java":
        before  => Exec['apt-update'],
    }

    apt::ppa { "ppa:cwchien/gradle":
        before => Exec['apt-update'],
    }

    Exec["apt-update"] ->
    exec {

        "set-licence-selected":
            command => "/bin/echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections";

        "set-licence-seen":
            command => "/bin/echo debconf shared/accepted-oracle-license-v1-1 seen true | /usr/bin/debconf-set-selections";

    } ->
    package { ["oracle-java7-installer", "curl", "unzip", "nano", "vim", "make", "g++", "gradle"]:
        ensure => present,
        require => Exec["set-licence-selected", "set-licence-seen"],
    }

    class { "nodejs":
    } ->
    package { "couchbase":
        ensure   => present,
        provider => "npm",
        require => [ Package["make"], Package["g++"] ]
    } ->
    package { "stompjs":
        ensure   => present,
        provider => "npm",
    } ->
    package { "forever":
        ensure   => present,
        provider => "npm",
    }

    file { "/tmp/mysql-server.response":
        ensure => present,
#        source => "${servioticy::params::vagrantdir}/puppet/files/mysql-server.response",
        content => template("servioticy/mysql-response.erb")
    } ->
    package {"mysql-server-${servioticy::params::mysql_version}":
        ensure => present,
        responsefile => "${servioticy::params::vagrantdir}/puppet/files/mysql-server.response",
    }

    package {"ant":
        ensure => present,
        require=> [ Package["oracle-java7-installer"] ],
    } ->
    class { "motd":
        config_file => "/etc/motd.tail",
        template => "servioticy/motd-servioticy.erb"
    }

}
