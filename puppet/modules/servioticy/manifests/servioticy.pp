class servioticy::servioticy {

    include servioticy::params

    vcsrepo { "srcdir/rhinomod":
        path     => "${servioticy::params::srcdir}/rhinomod",
        ensure   => latest,
        provider => git,
        owner    => "root",
        group    => "root",
        require  => Class["servioticy::packages"],
        source   => $git_rhinomod_src,
        revision => $git_rhinomod_revision,
    } ->
    exec { "build_rhinomod":
        cwd     => "${servioticy::params::srcdir}/rhinomod",
        command => "mvn -Dmaven.test.skip=true package",
        path    => "/usr/local/bin/:/usr/bin:/bin/",
        user    => "root",
        timeout => 0
    } ->
    vcsrepo { "srcdir/servioticy":
        path => "${servioticy::params::srcdir}/servioticy",
        ensure   => latest,
        provider => git,
        owner    => "root",
        group    => "root",
        require  => Class["servioticy::packages"],
        source   => $git_servioticy_url,
        revision => $git_servioticy_revision,
    } ->
     # Setup a .mavenrc file for the specified user
    maven::environment { "maven-env" :
        user => "root",
        # anything to add to MAVEN_OPTS in ~/.mavenrc
        maven_opts => "-Xmx1384m",       # anything to add to MAVEN_OPTS in ~/.mavenrc
        maven_path_additions => "",      # anything to add to the PATH in ~/.mavenrc
    } ->
    exec { "build_servioticy":
        cwd     => "${servioticy::params::srcdir}/servioticy",
        command => "git submodule update --init --recursive; mvn -Dmaven.test.skip=true package",
        path    => "/usr/local/bin/:/usr/bin:/bin/",
        user    => "root",
        timeout => 0
    } ->
    file { "installdir/jetty/webapps/private.war":
        path => "${servioticy::params::installdir}/jetty/webapps/private.war",
        ensure => present,
        source => "${servioticy::params::srcdir}/servioticy/servioticy-api-private/target/api-private.war",
        #notify  => Service["jetty"],
    } ->
    file { "installdir/jetty/webapps/root.war":
        path => "${servioticy::params::installdir}/jetty/webapps/root.war",
        ensure => present,
        source => "${servioticy::params::srcdir}/servioticy/servioticy-api-public/target/api-public.war",
        #notify  => Service["jetty"],
    } ->
    file { "installdir/servioticy-dispatcher/dispatcher_jar":
        path => "${servioticy::params::installdir}/servioticy-dispatcher/${servioticy::params::dispatcher_jar}",
        ensure => present,
        source => "${servioticy::params::srcdir}/servioticy/servioticy-dispatcher/target/${servioticy::params::dispatcher_jar}",
        owner    => $user,
        group    => $user,
    }


}
