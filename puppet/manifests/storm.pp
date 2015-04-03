archive { 'apache-storm-0.9.2':
  ensure => present,
  follow_redirects => true,
  checksum => false,
  url    => 'http://www.eu.apache.org/dist/storm/apache-storm-0.9.2-incubating/apache-storm-0.9.2-incubating.tar.gz',
  target => '/opt',
  src_target => '/tmp/servioticy',
  require  => [ Package["curl"], File['/tmp/servioticy/'] ],
}

#exec { "run_storm":
#    command => "storm jar /opt/servioticy-dispatcher/dispatcher-0.4.1-jar-with-dependencies.jar com.servioticy.dispatcher.DispatcherTopology -f /opt/servioticy-dispatcher/dispatcher.xml &",
#    cwd     => "/opt/apache-storm-0.9.2-incubating/bin",
#    require => [Exec['run_kestrel'], File['/opt/servioticy-dispatcher/dispatcher-0.4.1-jar-with-dependencies.jar'], File['/opt/servioticy-dispatcher/dispatcher.xml']],
#    user    => 'servioticy',
#    group    => 'servioticy',
#    path    => "/bin:/usr/bin/:/opt/apache-storm-0.9.2-incubating/bin",
#    unless => "ps -fA | grep storm | grep -v grep",
#    logoutput => true,
#}
