class servioticy::servioticy {

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

    file { "tomcat api public":
        path => "/var/lib/tomcat7/webapps/ROOT.war",
        ensure => "link",
        source => "${servioticy::params::srcdir}/servioticy/servioticy-api-public/target/api-public.war",
        owner    => "root",
        group    => "root",
    } ->
    file { "tomcat api private":
        path => "/var/lib/tomcat7/webapps/private.war",
        ensure => "link",
        source => "${servioticy::params::srcdir}/servioticy/servioticy-api-private/target/api-private.war",
        owner    => "root",
        group    => "root",
    }

}
