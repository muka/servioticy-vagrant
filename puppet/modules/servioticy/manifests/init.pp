class servioticy {

    if $::osfamily != "Debian" {
      fail("This module only works on Debian or derivatives like Ubuntu")
    }

    include servioticy::params
    include maven::maven

    class { "servioticy::hosts": }
    -> class { 'servioticy::prepare':}
    -> class { 'servioticy::vagrant_repo':}
    -> class { 'servioticy::files':}
    -> class { 'servioticy::packages':}

    -> class { "servioticy::storm": }
    -> class { "servioticy::apollo": }
    -> class { "servioticy::kestrel": }
    -> class { "servioticy::tomcat": }
    -> class { "servioticy::jetty_instance": }

    -> class { "servioticy::couchbase": }
    -> class { "servioticy::couchbase-elasticsearch": }
    -> class { "servioticy::serviolastic": }

    -> class { "servioticy::bridge": }
    -> class { "servioticy::service_manager": }
    -> class { "servioticy::composer": }

    -> class { "servioticy::security": }
    -> class { "servioticy::uaa": }
    -> class { "servioticy::servioticy": }

}
