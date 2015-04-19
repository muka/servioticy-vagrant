class servioticy::servioticy {

    vcsrepo { "srcdir/rhinomod":

        path     => "${servioticy::params::srcdir}/rhinomod",
        ensure   => latest,
        provider => git,

        owner    => "root",
        group    => "root",

        source   => $servioticy::params::git_rhinomod_src,
        revision => $servioticy::params::git_rhinomod_revision,

    } ->
    exec { "ant_jar_rhinomod":
        cwd     => "${servioticy::params::srcdir}/rhinomod",
        command => "ant jar",
        path    => "/usr/local/bin/:/usr/bin:/bin/",
        user    => "root",
        timeout => 0
    } ->
    exec { "mvn_install_rhinomod":
        cwd     => "${servioticy::params::srcdir}/rhinomod",
        #command => "mvn deploy:deploy-file -Durl=file://${servioticy::params::srcdir}/rhinomod -Dfile=${servioticy::params::srcdir}/rhinomod/build/rhino1_7R5pre/js.jar -DgroupId=org.mozilla -DartifactId=rhino -Dversion=1.7R4-mod-SNAPSHOT -Dpackaging=jar",
        command => "mvn install:install-file -Dfile=build/rhino1_7R5pre/js.jar -DgroupId=org.mozilla -DartifactId=rhino -Dversion=1.7R4-mod-SNAPSHOT -Dpackaging=jar",
        path    => "/usr/local/bin/:/usr/bin:/bin/",
        user    => "root",
        timeout => 0
    } ->
    vcsrepo { "src servioticy":

        path => "${servioticy::params::srcdir}/servioticy",
        ensure   => latest,
        provider => git,

        owner    => "root",
        group    => "root",

        source   => $servioticy::params::git_servioticy_url,
        revision => $servioticy::params::git_servioticy_revision,

    } ->
     # Setup a .mavenrc file for the specified user
    maven::environment { "maven-env" :
        user                 => "root",
        maven_opts           => "-Xmx1384m",       # anything to add to MAVEN_OPTS in ~/.mavenrc
        maven_path_additions => "",      # anything to add to the PATH in ~/.mavenrc
    } ->
    exec { "build_servioticy":
        cwd     => "${servioticy::params::srcdir}/servioticy",
        command => "git submodule update --init --recursive; mvn -Dmaven.test.skip=true package",
        path    => "/usr/local/bin/:/usr/bin:/bin/",
        user    => "root",
        timeout => 0
    } ->
    file { "private.war":
        path => "${servioticy::params::installdir}/jetty/webapps/private.war",
        ensure => present,
        source => "${servioticy::params::srcdir}/servioticy/servioticy-api-private/target/api-private.war",
    } ->
    file { "root.war":
        path => "${servioticy::params::installdir}/jetty/webapps/root.war",
        ensure => present,
        source => "${servioticy::params::srcdir}/servioticy/servioticy-api-public/target/api-public.war",
    } ->
    file { "dispatcher-jar":
        path => "${servioticy::params::installdir}/servioticy-dispatcher/${servioticy::params::dispatcher_jar}",
        ensure => present,
        source => "${servioticy::params::srcdir}/servioticy/servioticy-dispatcher/target/${servioticy::params::dispatcher_jar}",
        owner    => $servioticy::params::user,
        group    => $servioticy::params::user,
    }


}
