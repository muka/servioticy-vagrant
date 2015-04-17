class servioticy::service_manager {

    include servioticy::params

    vcsrepo { "$srcdir/cf-uaa":
        ensure   => latest,
        provider => git,
        owner    => 'root',
        group    => 'root',
        require  => Class["servioticy::packages"],
        source   => $git_uaa_url,
        revision => $git_uaa_revision,
    } ->
    yaml_setting { 'classname':
        target => '$srcdir/cf-uaa/uaa/src/main/resources/uaa.yml',
        key    => 'database/driverClassName',
        value  => 'com.mysql.jdbc.Driver',
    } ->
    yaml_setting { 'url':
        target => '$srcdir/cf-uaa/uaa/src/main/resources/uaa.yml',
        key    => 'database/url',
        value  => 'jdbc:mysql://localhost:3306/uaadb',
    } ->
    yaml_setting { 'username':
        target => '$srcdir/cf-uaa/uaa/src/main/resources/uaa.yml',
        key    => 'database/username',
        value  => 'root',
    } ->
    yaml_setting { 'password':
        target => '$srcdir/cf-uaa/uaa/src/main/resources/uaa.yml',
        key    => 'database/password',
        value  => 'root',
    } ->
    yaml_setting { 'spring_profile':
        target => '$srcdir/cf-uaa/uaa/src/main/resources/uaa.yml',
        key    => 'spring_profiles',
        value  => 'mysql,default',
    } ->
    exec { "build-uaa":
        path => "/usr/local/bin/:/usr/bin:/bin/:$srcdir/cf-uaa:/opt/gradle-2.1/bin",
        cwd => "$srcdir/cf-uaa",
        require  => Class["servioticy::packages"],
        command => "gradle :cloudfoundry-identity-uaa:war",
        user    => 'root',
        group    => 'root',
    }

}