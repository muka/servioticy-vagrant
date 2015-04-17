
class servioticy {

    if $::osfamily != 'Debian' {
      fail('This module only works on Debian or derivatives like Ubuntu')
    }
    
    include maven::maven

    include servioticy::params
    
    include servioticy::setup
    include servioticy::files
    include servioticy::user
    include servioticy::packages

    include servioticy::apollo
    include servioticy::bridge
    include servioticy::storm
    include servioticy::kestrel
    include servioticy::composer
    include servioticy::couchbase
    include servioticy::elasticsearch
    include servioticy::couchbase-elasticsearch
    include servioticy::motd
    include servioticy::service_manager

    include servioticy::security
    include servioticy::servioticy

}