
class servioticy {

    if $::osfamily != "Debian" {
      fail("This module only works on Debian or derivatives like Ubuntu")
    }  

    include servioticy::params
    include servioticy::setup

    include servioticy::apollo
    include servioticy::bridge
    include servioticy::storm
    include servioticy::kestrel
    include servioticy::composer
    include servioticy::couchbase
    include servioticy::es
    include servioticy::couchbase-elasticsearch

    include servioticy::service_manager
    include servioticy::uaa
    include servioticy::security
    include servioticy::servioticy

}
