class servioticy::packages {
    
    include servioticy::params

    apt::ppa { "ppa:webupd8team/java":
        before => Exec["apt-get update"]
    }
    apt::ppa { "ppa:chris-lea/node.js":
        before => Exec["apt-get update"]
    }

    package { ["oracle-java7-installer", "curl", "unzip", "nano", "vim", "make", "g++", "git"]:
        ensure => present,
        require => Exec["apt-get update", "set-licence-selected", "set-licence-seen"],
    }

    package { "git":
        ensure => present,
        before => vcsrepo["vagrantdir"],
    }

    class { "python" :
        version    => "system",
        pip        => true,
        dev        => false,
        virtualenv => true,
        gunicorn   => false    
    }

    exec { "apt-get update":
        path => "/usr/bin"
    }

    exec {
        "set-licence-selected":
            command => "/bin/echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections";

        "set-licence-seen":
            command => "/bin/echo debconf shared/accepted-oracle-license-v1-1 seen true | /usr/bin/debconf-set-selections";
    }

    package { "couchbase":
        ensure   => present,
        provider => "npm",
        require => [Package["nodejs"], Package["make"], Package["g++"]]
    }

    package { "stompjs":
        ensure   => present,
        provider => "npm",
        require => [Package["nodejs"]]
    }

    package { ["nodejs"]:
        ensure => present,
        require => [Exec["apt-get update"], Package["g++"]]
    }

    package { "forever":
        ensure   => present,
        provider => "npm",
        require => [Package["nodejs"]]
    }

    python::pip { "Flask" :
        pkgname       => "Flask",
    }

    python::pip { "simplejson" :
        pkgname       => "simplejson",
    }

    package {"mysql-server-5.5":
        ensure => present,
        responsefile => "${servioticy::params::vagrantdir}/puppet/files/mysql-server.response",
        require => [ Exec["apt-get update"], Vcsrepo["vagrantdir"] ],
    }

    vcsrepo { "vagrantdir":
        path     => $servioticy::params::vagrantdir,
        ensure   => latest,
        provider => git,
        owner    => $user,
        group    => $user,
        require  => Class["servioticy::user"],
        source   => $git_vagrant_src,
        revision => $git_vagrant_revision,
    }

    package {"ant":
        ensure => present,
        require=> [ Package["oracle-java7-installer"],Exec["apt-get update"] ],
    }

    package {"libmysql-java":
        ensure => present,
        require=> [ Package["oracle-java7-installer"],Exec["apt-get update"] ],
    }

    package {"tomcat7":
        ensure => present,
        require=> [ Package["oracle-java7-installer"],Exec["apt-get update"] ],
    }

    class { "motd": 
        config_file => "/etc/motd.tail",
        template => getvar("${servioticy::params::vagrantdir}/puppet/modules/servioticy/templates/motd_servioticy.erb")
    }

}