#exec {"wait for api":
#  require => [Package['couchbase-server'],Package['curl'],Service["jetty"], File['/opt/servioticy_scripts']],
#  command => "/bin/sh /opt/servioticy_scripts/wait_for_api.sh",
#}

vcsrepo { "/usr/src/servioticy":
  ensure   => latest,
  provider => git,
  owner    => 'servioticy',
  group    => 'servioticy',
  require  => [ Package["git"] ],
  source   => "https://github.com/servioticy/servioticy.git",
  revision => 'master',
} ->
class { "maven::maven":
  version => "3.2.2", # version to install
} ->
 # Setup a .mavenrc file for the specified user
maven::environment { 'maven-env' :
    user => 'servioticy',
    # anything to add to MAVEN_OPTS in ~/.mavenrc
    maven_opts => '-Xmx1384m',       # anything to add to MAVEN_OPTS in ~/.mavenrc
    maven_path_additions => "",      # anything to add to the PATH in ~/.mavenrc
} ->
exec { "build_servioticy":
   cwd     => "/usr/src/servioticy",
   command => "git submodule update --init --recursive; mvn -Dmaven.test.skip=true package",
   path    => "/usr/local/bin/:/usr/bin:/bin/",
   user    => 'servioticy',
   timeout => 0
}

#exec{ 'prepare_map_demo':
#    user    => 'servioticy',
#    group    => 'servioticy',
#    cwd => "/data/demo/map/utils",
#    path => "/bin:/usr/bin/",
#    command => "sh create_all.sh",
#    require => [ Package['python-pip'], File['/data/demo'], Package['couchbase-server'],  Package['couchbase'], Exec['create-xdcr'], Exec['wait for api'], Exec['run_kestrel'], Exec['run_storm'] ],
#}


#exec{ 'stop_all':
#    user    => 'servioticy',
#    group    => 'servioticy',
#    cwd => "/opt/servioticy_scripts",
#    path => "/bin:/usr/bin/:/opt/servioticy_scripts",
#    command => "sh stopAll.sh; sh stopAll.sh",
#    require => [ Exec['build-uaa'] ],
#}

#file_line { 'motd0':
#   path => '/etc/motd.tail',
#   line => '*********************************************************',
#} ->
#file_line { 'motd1':
#   path => '/etc/motd.tail',
#   line => 'Welcome to servIoTicy Virtual Appliance',
#} ->
#file_line { 'motd2':
#   path => '/etc/motd.tail',
#   line => " * You can run 'start-servioticy' and 'stop-servioticy' to start and stop all the services",
#} ->
#file_line { 'motd3':
#   path => '/etc/motd.tail',
#   line => "Enjoy!",
#}->
#file_line { 'motd4':
#   path => '/etc/motd.tail',
#   line => '*********************************************************',
##   before => Exec['stop_all']
#}

