
#file { '/data/userDB':
#          ensure => directory,
#          replace => true,
#          owner    => 'servioticy',
#          group    => 'servioticy',
#          source => "/opt/servioticy-vagrant/puppet/files/userDB",
#          recurse => remote,
#          before     => Exec['run_userDB']
#}

# use a symlink to /data/userDB/users.db to allow external access to VM users.db
file { '/data/userDB':
   ensure => 'link',
   target => '/opt/servioticy-vagrant/puppet/files/userDB',
}

exec { 'run_userDB':
    require => [ Package['python-pip'], File['/data/userDB']],
    user    => 'servioticy',
    group    => 'servioticy',
    unless => "ps -fA | grep userDB | grep -v grep",
    cwd => "/data/userDB/",
    path => "/bin:/usr/bin/",
    command => "python userDB.py &"
}