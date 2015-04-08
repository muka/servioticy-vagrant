vcsrepo { "/opt/servioticy-service-manager":
  ensure   => latest,
  provider => git,
  owner    => 'servioticy',
  group    => 'servioticy',
  source   => "https://github.com/muka/servioticy-mgr.git",
  revision => 'master',
} ->
file { '/usr/bin/servioticy':
   ensure => 'link',
   target => '/opt/servioticy-service-manager/bin/service',
} ->
exec { 'smgr_add_deps':
    require => [ Package['nodejs']],
    user    => 'servioticy',
    group    => 'servioticy',
    cwd => "/opt/servioticy-service-manager",
    path => "/bin:/usr/bin/",
    command => "npm i"
}