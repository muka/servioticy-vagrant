file { '/tmp/servioticy/':
  ensure => 'directory',
}

file { '/data':
  ensure => 'directory',
}

file { '/data/couchbase':
  ensure => 'directory',
  owner => "couchbase",
  group => "couchbase",
  require => Package['couchbase-server']
}

file { '/opt/apache-storm-0.9.2-incubating':
          ensure => 'directory',
          owner => 'servioticy',
          group => 'servioticy',
#          before => Exec['run_storm']
}

file { '/home/servioticy/LICENSE.txt':
          ensure => present,
          replace => true,
          owner    => 'servioticy',
          group    => 'servioticy',
          source => "/opt/servioticy-vagrant/puppet/files/other/LICENSE.txt",
}

file { '/home/servioticy/README.txt':
          ensure => present,
          replace => true,
          owner    => 'servioticy',
          group    => 'servioticy',
          source => "/opt/servioticy-vagrant/puppet/files/other/README.txt",
}

file { '/home/servioticy/README.demos.txt':
          ensure => present,
          replace => true,
          owner    => 'servioticy',
          group    => 'servioticy',
          source => "/opt/servioticy-vagrant/puppet/files/other/README.demos.txt",
}

file { '/home/servioticy/VERSION.txt':
          ensure => present,
          replace => true,
          owner    => 'servioticy',
          group    => 'servioticy',
          source => "/opt/servioticy-vagrant/puppet/files/other/VERSION.txt",
}

file { '/opt/servioticy-dispatcher':
          ensure => 'directory',
          owner => 'servioticy',
          group => 'servioticy'
}

file { '/opt/servioticy-dispatcher/dispatcher-0.4.3-SNAPSHOT-jar-with-dependencies.jar':
          ensure => present,
          source => "/usr/src/servioticy/servioticy-dispatcher/target/dispatcher-0.4.3-SNAPSHOT-jar-with-dependencies.jar",
          require => [File['/opt/servioticy-dispatcher'],Exec['build_servioticy'],File['/opt/servioticy-dispatcher']],
          owner => 'root',
          group => 'root'
}

file { '/opt/servioticy-dispatcher/dispatcher.xml':
          ensure => present,
          source => "/opt/servioticy-vagrant/puppet/files/dispatcher.xml",
          require => [File['/opt/servioticy-dispatcher'], Exec['build_servioticy'],File['/opt/servioticy-dispatcher']],
          owner => 'root',
          group => 'root'
}

file { '/data/demo':
          ensure => directory,
          replace => true,
          owner    => 'servioticy',
          group    => 'servioticy',
          source => "/opt/servioticy-vagrant/puppet/files/demo",
          recurse => remote
}


file { '/opt/servioticy_scripts':
          ensure => directory,
          replace => true,
          owner    => 'servioticy',
          group    => 'servioticy',
          source => "/opt/servioticy-vagrant/puppet/scripts",
          recurse => remote
}


file { '/opt/jetty/webapps/private.war':
          ensure => present,
          source => "/usr/src/servioticy/servioticy-api-private/target/api-private.war",
          notify  => Service["jetty"],
          require => Exec['build_servioticy']
}

file { '/opt/jetty/webapps/root.war':
          ensure => present,
          source => "/usr/src/servioticy/servioticy-api-public/target/api-public.war",
          notify  => Service["jetty"],
          require => Exec['build_servioticy']
}

file { '/usr/bin/start-servioticy':
   ensure => 'link',
   target => '/opt/servioticy_scripts/startAll.sh',
   require => File['/opt/servioticy_scripts'],
   mode => 755
}

file { '/usr/bin/stop-servioticy':
   ensure => 'link',
   target => '/opt/servioticy_scripts/stopAll.sh',
   require => File['/opt/servioticy_scripts'],
   mode => 755
}

file { '/home/vagrant/.bash_aliases':
   ensure => 'link',
   target => '/vagrant/puppet/scripts/env.sh',
}
