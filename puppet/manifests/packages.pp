
vcsrepo { "/opt/servioticy-vagrant":
  ensure   => latest,
  provider => git,
  owner    => 'servioticy',
  group    => 'servioticy',
  require  => [ User["servioticy_user"], Package["git"] ],
  source   => "https://github.com/servioticy/servioticy-vagrant.git",
# revision => 'master'
  revision => 'security'
}

apt::ppa { 'ppa:webupd8team/java':
            before => Exec['apt-get update']
}
apt::ppa { 'ppa:chris-lea/node.js':
            before => Exec['apt-get update']
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

package { 'forever':
  ensure   => present,
  provider => 'npm',
  require => [Package['nodejs']]
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


package { ['oracle-java7-installer', 'curl', 'unzip', 'vim', 'make', 'g++']:
  ensure => present,
  require => Exec['apt-get update', 'set-licence-selected', 'set-licence-seen']
}

python::pip { 'Flask' :
    pkgname       => 'Flask',
    before     => Exec['run_userDB']
}

python::pip { 'simplejson' :
    pkgname       => 'simplejson',
#    before     => Exec['prepare_map_demo']
}

package {'mysql-server-5.5':
  ensure => present,
  responsefile => '/opt/servioticy-vagrant/puppet/files/mysql-server.response',
  require => [ Exec['apt-get update'], Vcsrepo["/opt/servioticy-vagrant"] ],
}

package { 'muka/servioticy-mgr':
  provider => 'npm',
  require  => [ Package['nodejs'], User['servioticy_user'] ]
}

#exec { "servioticy_start":
#   cwd     => "/root",
#   command => "servioticy start",
#   path    => "/usr/local/bin/:/usr/bin:/bin/",
#   user    => 'root',
#}