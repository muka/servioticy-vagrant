class servioticy::jetty_instance {

    $tpl_path = "${servioticy::params::vagrantdir}/puppet/modules/servioticy/templates/jetty-default.erb"
    $tpl_content = template($tpl_path)

    $jetty_home = "${servioticy::params::installdir}/jetty"
    $jetty_dir = "${servioticy::params::installdir}/jetty-${servioticy::params::jetty_version}"

    if $servioticy::params::jetty_user {
        $jetty_user = $servioticy::params::jetty_user
    }
    else {
        $jetty_user = "jetty"
    }

    group {"jetty_gid":
        name        => "jetty",
        ensure      => present
    } ->
    user {"jetty_user":
        ensure      => present,
        name        => "jetty",
        gid         => "jetty",
        system      => true,
        managehome  => true,
        password    => "*",
    } ->
    archive { "jetty-${servioticy::params::jetty_version}.tar.gz":
        url    => $servioticy::params::jetty_url,
        target => $jetty_dir,
        src_target => $servioticy::params::downloaddir,
        ensure => present,
        follow_redirects => true,
        checksum => false,
        timeout => 0
    } ->
    file { "jetty etc default":
        path    => "/etc/default/jetty",
        content => $tpl_content,
    } ->
    file { "link-to-jetty":
        path    => $jetty_home,
        ensure  => 'link',
        target  => $jetty_dir,
    } ->
    file { "chown jetty dir":
        path    => $jetty_dir,
        ensure  => directory,
        recurse => true,
        owner   => $jetty_user,
        mode    => 0774
    } ->
    file { "jetty/start.ini":
        path    => "${jetty_home}/start.ini",
        ensure  => "present",
        audit   => "all",
    } ->
    file_line { "cross_origin":
        path    => "${jetty_home}/start.ini",
        line    => "--module=servlets",
    }

}