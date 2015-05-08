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
    exec { "build_servioticy":
        cwd     => "${servioticy::params::srcdir}/servioticy",
        command => "git submodule update --init --recursive; mvn -Dmaven.test.skip=true package; mvn install",
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
    exec { "build_dispatcher":
        cwd     => "${servioticy::params::srcdir}/servioticy/servioticy-dispatcher",
        command => "mvn clean package",
        path    => "/usr/local/bin/:/usr/bin:/bin/",
        user    => "root",
        timeout => 0
    } ->
    file { "dispatcher-jar":
        path => "${servioticy::params::installdir}/servioticy-dispatcher/dispatcher.jar",
        ensure => "link",
        source => "${servioticy::params::srcdir}/servioticy/servioticy-dispatcher/target/${servioticy::params::dispatcher_jar}",
        owner    => "root",
        group    => "root",
    }


}
