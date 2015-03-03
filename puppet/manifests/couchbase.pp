wget::fetch { "couchbase-server-source":
  source      => 'http://packages.couchbase.com/releases/3.0.0/couchbase-server-enterprise_3.0.0-ubuntu12.04_amd64.deb',
  destination => '/tmp/servioticy/couchbase-server-enterprise_3.0.0-ubuntu12.04_amd64.deb',
  timeout     => 0,
  verbose     => false,
  require     => File['/tmp/servioticy/']
} ->
package { "couchbase-server":
  provider => dpkg,
  ensure => installed,
  source => "/tmp/servioticy/couchbase-server-enterprise_3.0.0-ubuntu12.04_amd64.deb"
}


exec {"stop_couchbase":
  require => [Package['couchbase-server']],
  command => "/etc/init.d/couchbase-server stop",
}

#exec {"wait for couchbase":
#  require => [Package['couchbase-server'],File['/opt/servioticy_scripts']],
#  command => "/bin/sh /opt/servioticy_scripts/wait_for_couchbase.sh",
#}

#exec { "create_buckets":
#    command => "/bin/sh create_buckets.sh",
#    cwd     => "/opt/servioticy-vagrant/puppet/files",
#    path    => "/bin:/usr/bin/:/opt/couchbase/bin/",
#    require => [ Package['curl'], Exec['wait for couchbase']],
#    #logoutput => true,
#}