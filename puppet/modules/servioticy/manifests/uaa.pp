class servioticy::uaa {

    vcsrepo { "git cf-uaa":

        path     => "${servioticy::params::srcdir}/cf-uaa",
        ensure   => latest,
        provider => git,

        owner    => "root",
        group    => "root",

        source   => $servioticy::params::git_uaa_url,
        revision => $servioticy::params::git_uaa_revision,

    } ->
    yaml_setting { "classname":
        target => "${servioticy::params::srcdir}/cf-uaa/uaa/src/main/resources/uaa.yml",
        key    => "database/driverClassName",
        value  => "com.mysql.jdbc.Driver",
    } ->
    yaml_setting { "url":
        target => "${servioticy::params::srcdir}/cf-uaa/uaa/src/main/resources/uaa.yml",
        key    => "database/url",
        value  => "jdbc:mysql://localhost:3306/uaadb",
    } ->
    yaml_setting { "username":
        target => "${servioticy::params::srcdir}/cf-uaa/uaa/src/main/resources/uaa.yml",
        key    => "database/username",
        value  => "root",
    } ->
    yaml_setting { "password":
        target => "${servioticy::params::srcdir}/cf-uaa/uaa/src/main/resources/uaa.yml",
        key    => "database/password",
        value  => "root",
    } ->
    yaml_setting { "spring_profile":
        target => "${servioticy::params::srcdir}/cf-uaa/uaa/src/main/resources/uaa.yml",
        key    => "spring_profiles",
        value  => "mysql,default",
    } ->
    exec { "build-uaa":
        path    => "/usr/local/bin/:/usr/bin:/bin/:${servioticy::params::srcdir}/cf-uaa:${servioticy::params::gradle_path}",
        cwd     => "${servioticy::params::srcdir}/cf-uaa",
        command => "gradle :cloudfoundry-identity-uaa:war",
        user    => "root",
        group   => "root",
    } ->
    file { "uaa.properties":
        path    => "${servioticy::params::srcdir}/compose-idm/src/main/resources/uaa.properties",
        ensure  => present,
        source  => "${servioticy::params::vagrantdir}/puppet/files/idm/uaa.properties",
    } ->
    file { "uaa.war":
        path    => "/var/lib/tomcat7/webapps/uaa.war",
        ensure  => present,
        source  => "${servioticy::params::srcdir}/cf-uaa/uaa/build/libs/${servioticy::params::uaa_war}",
    }
}
