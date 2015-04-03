class { 'jetty':
  version => "9.2.3.v20140905",
  home    => "/opt",
  user    => "servioticy",
  group   => "servioticy",
#  require => [Package["couchbase-server"]],
} ->
exec{ 'stop-jetty':
  require => [Class['jetty']],
  command => "/etc/init.d/jetty stop",
}


file { '/opt/jetty/start.ini':
  ensure => 'present',
  audit  => 'all',
} ->
file_line { 'cross_origin':
   path => '/opt/jetty/start.ini',
   line => '--module=servlets',
   #notify  => Service["jetty"],
}