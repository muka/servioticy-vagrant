class servioticy::servioticy {

    include servioticy::params

    vcsrepo { "$srcdir/rhinomod":
      ensure   => latest,
      provider => git,
      owner    => 'root',
      group    => 'root',
      require  => Class['servioticy::packages'],
      source   => $git_rhinomod_src,
      revision => $git_rhinomod_revision,
    } ->
    exec { "build_rhinomod":
       cwd     => "$srcdir/rhinomod",
       command => "mvn -Dmaven.test.skip=true package",
       path    => "/usr/local/bin/:/usr/bin:/bin/",
       user    => 'root',
       timeout => 0
    } ->

    vcsrepo { "$srcdir/servioticy":
        ensure   => latest,
        provider => git,
        owner    => 'root',
        group    => 'root',
        require  => Class['servioticy::packages'],
        source   => $git_servioticy_url,
        revision => $git_servioticy_revision,
    } ->
    class { "maven::maven":
        version => "3.2.2", # version to install
    } ->
     # Setup a .mavenrc file for the specified user
    maven::environment { 'maven-env' :
        user => 'root',
        # anything to add to MAVEN_OPTS in ~/.mavenrc
        maven_opts => '-Xmx1384m',       # anything to add to MAVEN_OPTS in ~/.mavenrc
        maven_path_additions => "",      # anything to add to the PATH in ~/.mavenrc
    } ->
    exec { "build_servioticy":
        cwd     => "$srcdir/servioticy",
        command => "git submodule update --init --recursive; mvn -Dmaven.test.skip=true package",
        path    => "/usr/local/bin/:/usr/bin:/bin/",
        user    => 'root',
        timeout => 0
    }


}
