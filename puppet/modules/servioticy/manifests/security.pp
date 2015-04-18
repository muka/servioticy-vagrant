class servioticy::security {

    file { "git dir compose-idm":
        path    => "${servioticy::params::srcdir}/compose-idm",
        ensure  => directory,
        recurse => true,
        owner   => $servioticy::params::user,
        mode    => 0774
    } ->
    vcsrepo { "git compose-idm":

        path     => "${servioticy::params::srcdir}/compose-idm",
        ensure   => latest,
        provider => git,

        owner    => "root",
        group    => "root",

        source   => $git_idm_url,
        revision => $git_idm_revision,

    } ->
    file_line { "change_idm_port":
      path  => "${servioticy::params::srcdir}/compose-idm/src/main/resources/application.properties",
      line  => "server.port = 8082",
      match => "^server.port*",
    } ->
    exec { "compose-idm":
        path    => "/usr/local/bin/:/usr/bin:/bin/:${servioticy::params::srcdir}/compose-idm:${servioticy::params::gradle_path}",
        cwd     => "${servioticy::params::srcdir}/compose-idm",
        command => "sh compile_jar.sh",
        user    => "root",
        group   => "root",
    } ->
    file { "compose-idm jar":
        path => "${servioticy::params::installdir}/compose-idm/${servioticy::params::idm_jar}",
        ensure => present,
        source => "${servioticy::params::srcdir}/compose-idm/build/libs/$idm_jar",
    } ->
    file { "git dir compose-pdp":
        path    => "${servioticy::params::srcdir}/compose-pdp",
        ensure  => directory,
        recurse => true,
        owner   => $servioticy::params::user,
        mode    => 0774
    } ->
    vcsrepo { "git compose-pdp":

        path     => "${servioticy::params::srcdir}/compose-pdp",
        ensure   => latest,
        provider => git,

        owner    => "root",
        group    => "root",

        source   => $git_pdp_url,
        revision => $git_pdp_revision,

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
        command => "mvn install:install-file -Dfile=PDPComponentServioticy-0.1.0.jar -DgroupId=de.passau.uni -DartifactId=servioticy-pdp -Dversion=0.1.0 -Dpackaging=jar",
        user    => "root",
        group   => "root",
    } 

}
