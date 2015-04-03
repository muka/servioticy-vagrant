archive { 'apache-apollo-1.7':
  ensure => present,
  follow_redirects => true,
  checksum => false,
  url    => 'http://archive.apache.org/dist/activemq/activemq-apollo/1.7/apache-apollo-1.7-unix-distro.tar.gz',
  target => '/opt',
  src_target => '/tmp/servioticy',
  require  => [ Package["curl"], File['/tmp/servioticy'] ],
  timeout => 0
} ->
file { '/opt/apache-apollo-1.7':
  owner    => 'servioticy',
  group    => 'servioticy',

} ->
exec { 'create_broker':
  require => [ Package['oracle-java7-installer'] ],
  creates => '/opt/servibroker',
  cwd => "/opt/apache-apollo-1.7/bin/",
  path => "/bin:/usr/bin/:/opt/apache-apollo-1.7/bin/",
  command => "apollo create /opt/servibroker",
  #logoutput => true,
} ->
file { '/opt/servibroker':
  owner    => 'servioticy',
  group    => 'servioticy',
  before   => [File['/opt/servibroker/etc/apollo.xml'], File['/opt/servibroker/etc/users.properties'], File['/opt/servibroker/etc/groups.properties']]
}

file { '/opt/servibroker/etc/apollo.xml':
          ensure => present,
          replace => true,
          owner    => 'servioticy',
          group    => 'servioticy',
          source => "/opt/servioticy-vagrant/puppet/files/apollo.xml",
          require => Exec['create_broker']
}

file { '/opt/servibroker/etc/users.properties':
          ensure => present,
          replace => true,
          owner    => 'servioticy',
          group    => 'servioticy',
          source => "/opt/servioticy-vagrant/puppet/files/users.properties",
          require => Exec['create_broker']
}

file { '/opt/servibroker/etc/groups.properties':
          ensure => present,
          replace => true,
          owner    => 'servioticy',
          group    => 'servioticy',
          source => "/opt/servioticy-vagrant/puppet/files/groups.properties",
          require => Exec['create_broker']
}

#exec { 'run_broker':
#    require => [ Package['oracle-java7-installer'], File['/opt/servibroker/etc/apollo.xml'], File['/opt/servibroker/etc/users.properties'], File['/opt/servibroker/etc/groups.properties']],
#    user    => 'servioticy',
#    group    => 'servioticy',
#    unless => "ps -fA | grep apollo | grep -v grep",
#    cwd => "/opt/servibroker/bin/",
#    path => "/bin:/usr/bin/:/opt/servibroker/bin/",
#    command => "apollo-broker run &"
#}
