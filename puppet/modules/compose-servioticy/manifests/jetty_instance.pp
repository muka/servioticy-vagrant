class servioticy::jetty_instance {

    $jetty_home = "${servioticy::params::installdir}/jetty"
    $jetty_dir = $servioticy::params::jetty_dir

    if $servioticy::params::jetty_user {
        $jetty_user = $servioticy::params::jetty_user
    }
    else {
        $jetty_user = "jetty"
    }

    if $servioticy::params::jetty_port {
        $jetty_port = $servioticy::params::jetty_port
    }
    else {
        $jetty_port = "8070"
    }

    if $servioticy::params::jetty_host {
        $jetty_host = $servioticy::params::jetty_host
    }
    else {
        $jetty_host = "127.0.0.1"
    }

    $tpl_path = "servioticy/jetty-default.erb"
    $tpl_content = template($tpl_path)

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
        target => $servioticy::params::installdir,
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
    } ->
    file { "/etc/init.d/jetty":
        ensure  => "link",
        target  => "${jetty_home}/bin/jetty.sh",
        mode    => 755
    }

}