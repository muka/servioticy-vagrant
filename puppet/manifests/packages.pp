class servioticy::packages {
    
    include servioticy::params

    apt::ppa { 'ppa:webupd8team/java':
        before => Exec['apt-get update']
    }
    apt::ppa { 'ppa:chris-lea/node.js':
        before => Exec['apt-get update']
    }

    class { 'python' :
        version    => 'system',
        pip        => true,
        dev        => false,
        virtualenv => true,
        gunicorn   => false    
    }

    exec { 'apt-get update':
        path => '/usr/bin'
    }

    exec {
        'set-licence-selected':
            command => '/bin/echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections';

        'set-licence-seen':
            command => '/bin/echo debconf shared/accepted-oracle-license-v1-1 seen true | /usr/bin/debconf-set-selections';
    }

    package { 'couchbase':
        ensure   => present,
        provider => 'npm',
        require => [Package['nodejs'], Package['make'], Package['g++']]
    }

    package { 'stompjs':
        ensure   => present,
        provider => 'npm',
        require => [Package['nodejs']]
    }

    package { ['nodejs']:
        ensure => present,
        require => [Exec['apt-get update'], Package['g++']]
    }

    package { ['oracle-java7-installer', 'curl', 'unzip', 'nano', 'vim', 'make', 'g++']:
        ensure => present,
        require => Exec['apt-get update', 'set-licence-selected', 'set-licence-seen']
    }

    package { 'forever':
        ensure   => present,
        provider => 'npm',
        require => [Package['nodejs']]
    }

    python::pip { 'Flask' :
        pkgname       => 'Flask',
    }

    python::pip { 'simplejson' :
        pkgname       => 'simplejson',
    }

    package {'mysql-server-5.5':
        ensure => present,
        responsefile => '$installdir/servioticy-vagrant/puppet/files/mysql-server.response',
        require => [ Exec['apt-get update'], Vcsrepo["$installdir/servioticy-vagrant"] ],
    }

    vcsrepo { "$installdir/servioticy-vagrant":
        ensure   => latest,
        provider => git,
        owner    => $user,
        group    => $user,
        require  => [ Class["servioticy::user"], Package["git"] ],
        source   => $git_vagrant_src,
        revision => $git_vagrant_revision,
    }

    package {'ant':
        ensure => present,
        require=> [ Package['oracle-java7-installer'],Exec['apt-get update'] ],
    }

    package {'libmysql-java':
        ensure => present,
        require=> [ Package['oracle-java7-installer'],Exec['apt-get update'] ],
    }

    package {'tomcat7':
        ensure => present,
        require=> [ Package['oracle-java7-installer'],Exec['apt-get update'] ],
    }

}