
file { '/opt/servioticy-vagrant/instance/userDB':
          ensure => directory,
          replace => true,
          owner    => 'servioticy',
          group    => 'servioticy',
          source => "/opt/servioticy-vagrant/puppet/files/userDB",
          recurse => remote,
          before     => Exec['run_userDB']
}

# use a symlink to /data/users.db to allow external access to VM users.db
file { '/data/users.db':
   ensure => 'link',
   target => '/opt/servioticy-vagrant/instance/userDB/users.db',
   require => [File['/opt/servioticy-vagrant/instance/userDB']]
}

exec { 'run_userDB':
    require => [ Package['python-pip'], File['/opt/servioticy-vagrant/instance/userDB']],
    user    => 'servioticy',
    group    => 'servioticy',
    unless => "ps -fA | grep userDB | grep -v grep",
    cwd => "/data/userDB/",
    path => "/bin:/usr/bin/",
    command => "python userDB.py &"
}