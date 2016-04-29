class servioticy {

    if $::osfamily != "Debian" {
      fail("This module only works on Debian or derivatives like Ubuntu")
    }

    include servioticy::params

    class { "servioticy::hosts": }
    -> class { 'servioticy::prepare':}
    -> class { 'servioticy::vagrant_repo':}
    -> class { 'servioticy::files':}
    -> class { 'servioticy::packages':}

    -> class { "servioticy::nginx_http": }
    -> class { "servioticy::apollo": }
    -> class { "servioticy::tomcat": }

    -> class { "servioticy::couchbase": }
    -> class { "servioticy::couchbase-elasticsearch": }
    -> class { "servioticy::serviolastic": }

    -> class { "servioticy::bridge": }
    -> class { "servioticy::service_manager": }
    -> class { "servioticy::composer": }

    -> class { "servioticy::servioticy": }

    -> class { "servioticy::start_all": }

}
