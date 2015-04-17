class servioticy::security {

    include servioticy::params

    vcsrepo { "$srcdir/compose-idm":
        ensure   => latest,
        provider => git,
        owner    => 'root',
        group    => 'root',
        require  => Class['servioticy::files', 'servioticy::packages']
        source   => $git_idm_url,
        revision => $git_idm_revision,
    } ->
    file_line { 'change_idm_port':
      path  => '$srcdir/compose-idm/src/main/resources/application.properties',
      line  => 'server.port = 8082',
      match => '^server.port*',
    } ->
    exec { "compose-idm":
        path    => "/usr/local/bin/:/usr/bin:/bin/:$srcdir/compose-idm:/opt/gradle-2.1/bin",
        cwd     => "$srcdir/compose-idm",
        command => "sh compile_jar.sh",
        user    => 'root',
        group   => 'root',
    }

    vcsrepo { "$srcdir/compose-pdp":
        ensure   => latest,
        provider => git,
        owner    => 'root',
        group    => 'root',
        require  => Class['servioticy::files', 'servioticy::packages']
        source   => $git_pdp_url,
        revision => $git_pdp_revision,
    } ->
    exec { "compose-pdp":
        path => "/usr/local/bin/:/usr/bin:/bin/:$srcdir/compose-pdp:/opt/gradle-2.1/bin",
        cwd => "$srcdir/compose-pdp",
        command => "gradle clean build install -x test",
        user    => 'root',
        group    => 'root',
    } ->
    exec { "install-pdp":
        path => "/usr/local/bin/:/usr/bin:/bin/",
        cwd => "$srcdir/compose-pdp/build/libs",
        command => "mvn install:install-file -Dfile=PDPComponentServioticy-0.1.0.jar -DgroupId=de.passau.uni -DartifactId=servioticy-pdp -Dversion=0.1.0 -Dpackaging=jar",
        user    => 'root',
        group    => 'root',
        before   => Class['servioticy::servioticy'],
    }

}
