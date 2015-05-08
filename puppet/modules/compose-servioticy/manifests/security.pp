class servioticy::security {

    vcsrepo { "git compose-idm":

        path     => "${servioticy::params::srcdir}/compose-idm",
        ensure   => latest,
        provider => git,

        owner    => "root",
        group    => "root",

        source   => $servioticy::params::git_idm_url,
        revision => $servioticy::params::git_idm_revision,

    } ->
    file_line { "change_idm_port":
      path  => "${servioticy::params::srcdir}/compose-idm/src/main/resources/application.properties",
      line  => "server.port = 8082",
      match => "^server.port*",
    } ->
    exec { "build compose-idm":
        path    => "/usr/local/bin/:/usr/bin:/bin/:${servioticy::params::srcdir}/compose-idm:${servioticy::params::gradle_path}",
        cwd     => "${servioticy::params::srcdir}/compose-idm",
        command => "gradle installApp",
        user    => "root",
        group   => "root",
    } ->
    file { "compose-idm mv jar":
        path => "${servioticy::params::installdir}/compose-idm/${servioticy::params::idm_jar}",
        ensure => present,
        source => "${servioticy::params::srcdir}/compose-idm/build/libs/${servioticy::params::idm_jar}",
    } ->
    vcsrepo { "git compose-pdp":

        path     => "${servioticy::params::srcdir}/compose-pdp",

        ensure   => latest,
        provider => git,

        owner    => "root",
        group    => "root",

        source   => $servioticy::params::git_pdp_url,
        revision => $servioticy::params::git_pdp_revision,

    } ->
    exec { "build compose-pdp":
        path    => "/usr/local/bin/:/usr/bin:/bin/:${servioticy::params::srcdir}/compose-pdp:${servioticy::params::gradle_path}",
        cwd     => "${servioticy::params::srcdir}/compose-pdp",
        command => "gradle clean build install -x test",
        user    => "root",
        group   => "root",
    } ->
    exec { "install-pdp":
        path    => "/usr/local/bin/:/usr/bin:/bin/",
        cwd     => "${servioticy::params::srcdir}/compose-pdp/build/libs",
        command => "mvn install:install-file -Dfile=${servioticy::params::pdp_jar} -DgroupId=de.passau.uni -DartifactId=servioticy-pdp -Dversion=0.1.0 -Dpackaging=jar",
        user    => "root",
        group   => "root",
    } 

}
